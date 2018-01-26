﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Jugadores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        DropDownList ddlIDUsuario = (lvJugadores.InsertItem.FindControl("ddlUsuariosDisponibles") as DropDownList);
        (lvJugadores.InsertItem.FindControl("INTCVEUSUARIOTextBox") as TextBox).Text = ddlIDUsuario.SelectedValue;

        RadioButtonList rblGenero = (lvJugadores.InsertItem.FindControl("rblGenero") as RadioButtonList);
        (lvJugadores.InsertItem.FindControl("GENEROTextBox") as TextBox).Text = rblGenero.SelectedValue;
    }

    protected void txtSuscriptionDate_PreRender(object sender, EventArgs e)
    {
        (sender as TextBox).Text = DateTime.Today.ToString("yyyy-MM-dd");
    }
}