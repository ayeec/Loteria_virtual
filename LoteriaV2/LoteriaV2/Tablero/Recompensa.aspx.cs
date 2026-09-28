using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_Recompensa : PageBaseJugadorAuthentication
{
    protected int CorrectAnswers { get; private set; }
    protected int TotalQuestions { get; private set; }
    protected string Grade { get; private set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        isJugadorLoggedIn();
        int correctAnswers;
        int totalQuestions;
        if (!GameInputValidator.TryGetRewardScore(
            Request.QueryString["correct"], Request.QueryString["total"],
            out correctAnswers, out totalQuestions))
        {
            Response.StatusCode = 400;
            Response.TrySkipIisCustomErrors = true;
            Response.Write("El resultado del juego no es válido.");
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        CorrectAnswers = correctAnswers;
        TotalQuestions = totalQuestions;
        double grade = (double)CorrectAnswers / TotalQuestions * 10;
        Grade = String.Format("{0:0.0}", grade);
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