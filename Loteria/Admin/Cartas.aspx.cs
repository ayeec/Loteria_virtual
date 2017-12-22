using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_Cartas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["Image"] = null;
        }
    }

    protected void imageUpload_ServerClick(object sender, ImageClickEventArgs e)
    {
        ((TextBox)lvCartas.InsertItem.FindControl("RUTAIMAGENTextBox")).Text = "test";
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        FileUpload fileUpImage = ((FileUpload)lvCartas.InsertItem.FindControl("filUpImageInsert"));
        
        Stream fs = fileUpImage.PostedFile.InputStream;
        BinaryReader br = new BinaryReader(fs);
        byte[] bytes = br.ReadBytes((Int32)fs.Length);
        //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        //Image1.ImageUrl = "data:image/png;base64," + base64String;
        //Panel1.Visible = true;

        //save
        HttpPostedFile postedFile = fileUpImage.PostedFile;
        postedFile.SaveAs(Server.MapPath("~/images/") + Path.GetFileName(postedFile.FileName));

        //((TextBox)lvCartas.InsertItem.FindControl("RUTAIMAGENTextBox")).Text = (sender as FileUpload).PostedFile.FileName;
        ((TextBox)lvCartas.InsertItem.FindControl("RUTAIMAGENTextBox")).Text= Path.GetFileName(postedFile.FileName);
        //Response.Redirect(Request.Url.AbsoluteUri);
    }
    //<input id="imgUpload" size="28" name="Subiendo" runat="server" on /> 
    //((HtmlInputText)lvCartas.InsertItem.FindControl("imgUpload"))
    //https://www.codeproject.com/articles/3063/how-to-upload-an-image-using-asp-net



}