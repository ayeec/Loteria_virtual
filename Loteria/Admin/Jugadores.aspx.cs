using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Jugadores : PageBaseUsuarioAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checkAdminPrivileges();
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvJugadores.InsertItem);
    }

    protected void txtSuscriptionDate_PreRender(object sender, EventArgs e)
    {
        (sender as TextBox).Text = DateTime.Today.ToString("yyyy-MM-dd");
        
    }

    protected void fill_textboxes(ListViewItem lvi)
    {
        DropDownList ddlIDUsuario = (lvi.FindControl("ddlUsuariosDisponibles") as DropDownList);
        (lvi.FindControl("INTCVEUSUARIOTextBox") as TextBox).Text = ddlIDUsuario.SelectedValue;

        RadioButtonList rblGenero = (lvi.FindControl("rblGenero") as RadioButtonList);
        (lvi.FindControl("GENEROTextBox") as TextBox).Text = rblGenero.SelectedValue;

        
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvJugadores.EditItem);
    }

    protected void SQLDSJugadores_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null || e.AffectedRows <= 0)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alertCat",
                            "alert('El jugador tiene juegos y/o categorias asignadas.\\n" +
                            "Es recomendable que sea desactivado manualmente su cuenta de usuario\\n');", true);
            e.ExceptionHandled = true;
        }
    }
}