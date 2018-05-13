using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using LoteriaV2;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                Usuario_Jugador userInfo = new LoteriaDAO().isValidUser(UserName.Text, Password.Text);
                if(userInfo != null)
                {
                    Session["usarioID"] = userInfo.IDusuario;
                    Session["role"] = userInfo.Role;
                    Session["usuarioName"] = userInfo.NameUsuario;
                    Session["jugadorName"] = userInfo.NameJugador;
                    Session["jugadorID"] = userInfo.IDJugador;
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    FailureText.Text = "Clave o usuario inválido";
                    ErrorMessage.Visible = true;
                }
           
            }
        }
}