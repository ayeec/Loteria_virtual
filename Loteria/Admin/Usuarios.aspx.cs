using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Usuarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvJugadores_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        SQLDSUsuarios.Delete();
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        /*DropDownList ddlUserType = (lvUsuarios.InsertItem.FindControl("ddlUserType") as DropDownList);
        (lvUsuarios.InsertItem.FindControl("CHRTIPOUSUARIOTextBox") as TextBox).Text = ddlUserType.SelectedValue;*/

        fill_textboxes(lvUsuarios.InsertItem);
    }

    protected void fill_textboxes(ListViewItem lvi)
    {
        DropDownList ddlUserType = (lvi.FindControl("ddlUserType") as DropDownList);
        (lvi.FindControl("CHRTIPOUSUARIOTextBox") as TextBox).Text = ddlUserType.SelectedValue;
    }

   
    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        //fill_textboxes(lvUsuarios.selec);
    }



    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        fill_textboxes(lvUsuarios.EditItem);
    }
}