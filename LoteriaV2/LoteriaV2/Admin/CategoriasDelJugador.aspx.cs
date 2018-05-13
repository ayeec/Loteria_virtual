using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CategoriasDelJugador : PageBaseUsuarioAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checkAdminPrivileges();
        if (String.IsNullOrEmpty(Request.QueryString["idJugador"]))
        {
            h1Title.InnerText = "Categorias Asignadas a los Jugadores";
            
        }
        else
        {
            h1Title.InnerText = "Categorias Asignadas al Jugador " + Request.QueryString["idJugador"];
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvCategoriasDelJugador.InsertItem);
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        //fill_textboxes(lvCategoriasDelJugador.EditItem);
        CheckBox ckbActivo = (lvCategoriasDelJugador.EditItem.FindControl("ckbActivo") as CheckBox);
        (lvCategoriasDelJugador.EditItem.FindControl("BOOLACTIVOTextBox") as TextBox).Text = ckbActivo.Checked==true ? "1" : "0";
    }

    protected void fill_textboxes(ListViewItem lvi)
    {
        DropDownList ddlCategorias = (lvi.FindControl("ddlCategorias") as DropDownList);
        (lvi.FindControl("INTIDCATEGORIATextBox") as TextBox).Text = ddlCategorias.SelectedValue;

        DropDownList ddlJugadores = (lvi.FindControl("ddlJugadores") as DropDownList);
        (lvi.FindControl("INTCVEJUGADORTextBox") as TextBox).Text = ddlJugadores.SelectedValue;

        CheckBox ckbActivo = (lvi.FindControl("ckbActivo") as CheckBox);
        (lvi.FindControl("BOOLACTIVOTextBox") as TextBox).Text = (ckbActivo.Checked? "1":"0");
    }

    protected void ddlJugadores_DataBound(object sender, EventArgs e)
    {
        //if(!IsPostBack)
        { 
            if (!string.IsNullOrEmpty(Request.QueryString["idJugador"]))
            {
                (sender as DropDownList).Enabled = false;
                (sender as DropDownList).SelectedValue = Request.QueryString["idJugador"];


            }
            (sender as DropDownList).Items.Insert(0, new ListItem("Seleccione un Jugador", "0"));
        }
    }

    protected void ddlJugadores_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_categorias_to_jugador(lvCategoriasDelJugador.InsertItem);
        //hidIDJugador.Value = ddlJugadores.SelectedValue;
        //SQLDSCategorias.DataBind();
    }

    protected void bind_categorias_to_jugador(ListViewItem lvi)
    {

        //HiddenField hidIDJugador = (lvi.FindControl("hidIDJugador") as HiddenField);
        hidIDJugador.Value = (lvi.FindControl("ddlJugadores") as DropDownList).SelectedValue;
        SQLDSCategorias.DataBind();
        ddlCategorias.DataBind();
        (lvi.FindControl("ddlCategorias") as DropDownList).Items.Clear();
        (lvi.FindControl("ddlCategorias") as DropDownList).Items.AddRange(ddlCategorias.Items.OfType<ListItem>().ToArray());


        //(lvi.FindControl("ddlCategorias") as DropDownList).Items.Add( );
    }
}