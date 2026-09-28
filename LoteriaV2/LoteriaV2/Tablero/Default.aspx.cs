using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_Default : PageBaseJugadorAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        isJugadorLoggedIn();
    }

    protected void btnStartGame_Click(object sender, EventArgs e)
    {
        int size;
        if (!Int32.TryParse(txtSize.Text, out size) || size < 2 || size > 5)
        {
            lblValidation.Text = "El tamaño del tablero debe estar entre 2 y 5.";
            return;
        }

        Response.Redirect(String.Format("Tablero.aspx?size={0}&hard={1}", size, chkHard.Checked));
    }
}