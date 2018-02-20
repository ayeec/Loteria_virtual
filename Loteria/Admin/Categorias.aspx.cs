using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Categorias : PageBaseUsuarioAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checkAdminPrivileges();
    }

    protected void btnAssignCartastoCategoria_Click(object sender, EventArgs e)
    {
        
        int ii = Int32.Parse(lvCategorias.SelectedValue.ToString());
        Response.Redirect("CartasDeCategoria.aspx?IDcategoria=" );
    }
}