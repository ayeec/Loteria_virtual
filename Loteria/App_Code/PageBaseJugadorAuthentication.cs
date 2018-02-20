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
        if (Session["jugadorID"] is null)
        {
            Response.Redirect("~/Account/Login.aspx");
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    
    protected int JugadorID
    {
        get
        {
            return Int32.Parse(Session["jugadorID"].ToString());
        }
    }

    protected string JugadorName
    {
        get
        {
            return Session["jugadorName"].ToString();
        }
    }


}