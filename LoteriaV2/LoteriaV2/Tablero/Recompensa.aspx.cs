using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_Recompensa : PageBaseJugadorAuthentication
{
    protected void Page_Load(object sender, EventArgs e)
    {
        isJugadorLoggedIn();
        double grade = Double.Parse(Request.QueryString["correct"]) / Double.Parse(Request.QueryString["total"]) * 10;
        switch (grade)
        {
            case double g when (g >= 8):
                imgReward.ImageUrl = "~/images/fijo/happy.jpg";
                break;
            case double g when (g >= 6):
                imgReward.ImageUrl = "~/images/fijo/serious.jpg";
                break;
            case double g when (g < 6):
                imgReward.ImageUrl = "~/images/fijo/sad.jpg";
                break;
        }
    }
}