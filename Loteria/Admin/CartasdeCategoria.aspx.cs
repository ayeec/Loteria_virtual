﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CartasDeCategoria_Jugadores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string idCategoria = Request.QueryString["IDcategoria"];
            if (!string.IsNullOrEmpty(idCategoria))
            {
              /*  DropDownList ddlIDcategorias = (lvCartasDeCategoria.InsertItem.FindControl("ddlIDcategorias") as DropDownList);
                //ddlIDcategorias.
                ddlIDcategorias.SelectedValue = Request.QueryString["IDcategoria"];
                ddlIDcategorias.Enabled = false;

                (lvCartasDeCategoria.InsertItem.FindControl("ddlIDcategorias") as DropDownList).Enabled = false;*/

            }
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        DropDownList ddlIDcategorias = (lvCartasDeCategoria.InsertItem.FindControl("ddlIDcategorias") as DropDownList);
        DropDownList ddlCartasByIDcategoria = (lvCartasDeCategoria.InsertItem.FindControl("ddlCartasByIDcategoria") as DropDownList);

        if (Int32.Parse(ddlCartasByIDcategoria.SelectedValue) != 0)
        {
            (lvCartasDeCategoria.InsertItem.FindControl("INTIDCATEGORIATextBox") as TextBox).Text = ddlIDcategorias.SelectedValue;
            (lvCartasDeCategoria.InsertItem.FindControl("INTCVECARTATextBox") as TextBox).Text = ddlCartasByIDcategoria.SelectedValue;
        }
        else
        {
            //do not insert
            Response.Redirect(Request.Url.AbsoluteUri);
        }

    }

    protected void ddlIDcategorias_DataBound(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["IDcategoria"]))
        {
            (sender as DropDownList).Enabled = false;
            (sender as DropDownList).SelectedValue = Request.QueryString["IDcategoria"];


        }
        (sender as DropDownList).Items.Insert(0, new ListItem("Seleccione una Carta", "0"));
    }

    protected void ddlCartasByIDcategoria_DataBound(object sender, EventArgs e)
    {
        (sender as DropDownList).Items.Insert(0, new ListItem("Seleccione una Carta", "0"));
    }
}