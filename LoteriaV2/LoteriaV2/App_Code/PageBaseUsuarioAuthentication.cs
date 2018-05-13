using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PageBaseUsuarioAuthentication : System.Web.UI.Page
{
    public PageBaseUsuarioAuthentication()
    {
        
    }

    protected void isUserLoggedIn()
    {
        if (Session["usuarioID"] is null)
        {
            Response.Redirect("~/Account/Login.aspx");
        }

    }

    protected void checkAdminPrivileges()
    {
        if (Session["role"] is null|| !Session["role"].ToString()[0].Equals('A'))
        {
            Response.Redirect("~/Account/Login.aspx");
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    
    public char Role
    {
        get
        {
            return Session["role"].ToString()[0];
        }
    }

    public int UsuarioID
    {
        get
        {
            return Int32.Parse(Session["usuarioID"].ToString());
        }
    }

    protected string usuarioName
    {
        get
        {
            return Session["usuarioName"].ToString();
        }
    }
}