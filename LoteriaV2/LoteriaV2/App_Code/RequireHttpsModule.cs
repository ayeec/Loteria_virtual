using System;
using System.Configuration;
using System.Web;

public sealed class RequireHttpsModule : IHttpModule
{
    public void Init(HttpApplication application)
    {
        application.BeginRequest += RedirectToHttps;
    }

    private static void RedirectToHttps(object sender, EventArgs e)
    {
        HttpApplication application = (HttpApplication)sender;
        HttpRequest request = application.Context.Request;
        string publicHost = ConfigurationManager.AppSettings["PublicHttpsHost"];
        if (String.IsNullOrWhiteSpace(publicHost) ||
            publicHost.IndexOfAny(new[] { '/', '\\', ':' }) >= 0 ||
            Uri.CheckHostName(publicHost) == UriHostNameType.Unknown)
        {
            throw new ConfigurationErrorsException(
                "The PublicHttpsHost setting must contain the deployed HTTPS host name.");
        }

        bool canonicalHost = String.Equals(request.Url.Host, publicHost, StringComparison.OrdinalIgnoreCase);
        if (!request.IsSecureConnection || !canonicalHost)
        {
            application.Context.Response.RedirectPermanent(
                "https://" + publicHost + request.RawUrl, false);
            application.Context.ApplicationInstance.CompleteRequest();
        }
    }

    public void Dispose()
    {
    }
}
