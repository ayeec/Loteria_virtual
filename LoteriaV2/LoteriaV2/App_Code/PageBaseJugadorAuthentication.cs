using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PageBaseJugadorAuthentication : PageBaseUsuarioAuthentication
{
    public PageBaseJugadorAuthentication()
    {
        
    }

    protected void isJugadorLoggedIn()
    {
        isUserLoggedIn();
        object jugadorID = Session["jugadorID"];
        if (!SessionAuthorization.IsPlayer(Session["usuarioID"], jugadorID, Role))
        {
            RedirectToLogin();
        }
    }

    protected int JugadorID
    {
        get
        {
            object jugadorID = Session["jugadorID"];
            return jugadorID is int ? (int)jugadorID : 0;
        }
    }

    protected string JugadorName
    {
        get
        {
            return Session["jugadorName"] as string;
        }
    }


}