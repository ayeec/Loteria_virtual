using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Frases : PageBaseUsuarioAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checkAdminPrivileges();
        if (String.IsNullOrEmpty(Request.QueryString["idCarta"]))
        {
            h1Title.InnerText = "Frases para las Cartas";

        }
        else
        {
            h1Title.InnerText = "Frases para la Carta " + Request.QueryString["idCarta"];
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvFrases.InsertItem);
    }

    protected void fill_textboxes(ListViewItem lvi)
    {
        DropDownList ddlIDCartas = (lvi.FindControl("ddlCartas") as DropDownList);
        (lvi.FindControl("INTCVECARTATextBox") as TextBox).Text = ddlIDCartas.SelectedValue;
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvFrases.EditItem);
    }

    protected void ddlCartas_PreRender(object sender, EventArgs e)
    {
        (lvFrases.EditItem.FindControl("ddlCartas") as DropDownList).SelectedValue =(lvFrases.EditItem.FindControl("INTCVECARTATextBox") as TextBox).Text;
    }

    protected void ddlCartas_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["idCarta"]))
        {
            (sender as DropDownList).Enabled = false;
            (sender as DropDownList).SelectedValue = Request.QueryString["idCarta"];
        }
    }
}