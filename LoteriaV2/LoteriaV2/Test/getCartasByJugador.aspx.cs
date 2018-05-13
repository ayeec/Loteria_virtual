using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test_getCartasByJugador : System.Web.UI.Page
{
    ArrayList arrCartas;
    protected void Page_Load(object sender, EventArgs e)
    {
        LoteriaDAO loteria = new LoteriaDAO();
        arrCartas = loteria.getCartasByJugador(2);
        
        foreach (var carta in arrCartas )
        {
            Console.WriteLine(carta);
        }


        int gameID = loteria.insertGameInfo(2, DateTime.Now, 2, 2, 5, 4, false, 5);

        loteria.insertGameDetails(gameID, 1, true, false, true);
    }
}