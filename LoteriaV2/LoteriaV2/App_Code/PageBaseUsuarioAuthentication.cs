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
        if (!IsAuthenticated)
        {
            RedirectToLogin();
        }
    }

    protected void checkAdminPrivileges()
    {
        if (!SessionAuthorization.IsAdmin(Session["usuarioID"], Role))
        {
            RedirectToLogin();
        }
    }

    protected bool IsAuthenticated
    {
        get
        {
            return SessionAuthorization.IsAuthenticated(Session["usuarioID"], Role);
        }
    }

    protected void RedirectToLogin()
    {
        Response.Redirect("~/Account/Login.aspx");
    }

    public char Role
    {
        get
        {
            object role = Session["role"];
            string roleValue = role as string;
            if (roleValue != null && roleValue.Length > 0)
            {
                return roleValue[0];
            }

            if (role is char)
            {
                return (char)role;
            }

            return '\0';
        }
    }

    public int UsuarioID
    {
        get
        {
            object userId = Session["usuarioID"];
            return userId is int ? (int)userId : 0;
        }
    }

    protected string usuarioName
    {
        get
        {
            return Session["usuarioName"] as string;
        }
    }
}