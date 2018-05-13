using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(LoteriaV2.Startup))]
namespace LoteriaV2
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
