using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnStartGame_Click(object sender, EventArgs e)
    {
        Response.Redirect(String.Format("Tablero.aspx?size={0}&hard={1}",txtSize.Text,chkHard.Checked));
    }
}