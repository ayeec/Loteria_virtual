using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Loteria.Startup))]
namespace Loteria
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
