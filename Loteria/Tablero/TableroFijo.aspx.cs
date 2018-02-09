using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_TableroFijo : System.Web.UI.Page
{
    ArrayList arrTablero = new ArrayList();
    int sizeTablero;
    bool isHard;
    int ctrCardsRemaining;
    readonly int ctrRefresh = 2;
    CartasDTO cardAtHand;
    List<int> usedCards = new List<int>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            sizeTablero = 3;
            ctrCardsRemaining = sizeTablero * sizeTablero;
            ViewState["ctrCardsRemaining"] = sizeTablero* sizeTablero;
            isHard = false;

            if (isHard)
            {
                imgBtnShowImage.Enabled = false;
            }

            arrTablero.Add(new CartasDTO(1, "Elefante", "~/images/fijo/elefante.jpg", "El Elefante tiene orejas grandes"));
            arrTablero.Add(new CartasDTO(2, "Delfin", "~/images/fijo/delfin.jpg", "El Delfin nada rápido"));
            arrTablero.Add(new CartasDTO(3, "Gato", "~/images/fijo/gato.jpg", "El Gato maulla"));
            arrTablero.Add(new CartasDTO(4, "Leon", "~/images/fijo/leon.jpg", "El León es el rey de la sabana"));
            arrTablero.Add(new CartasDTO(5, "Oveja", "~/images/fijo/oveja.jpg", "La oveja esta cubierta de lana"));
            arrTablero.Add(new CartasDTO(6, "Perro", "~/images/fijo/perro.jpg", "El Perror le gustan los huesos"));
            arrTablero.Add(new CartasDTO(7, "Puerco", "~/images/fijo/puerco.jpg", "El Puerco esta gordito"));
            arrTablero.Add(new CartasDTO(8, "Rana", "~/images/fijo/rana.jpg", "La Rana hace ribit"));
            arrTablero.Add(new CartasDTO(9, "Tortuga", "~/images/fijo/tortuga.gif", "La tortuga camina lento"));



            /*card to guess*/
            setNewRandomCard();
            /*
            Random ran = new Random();
            int randomNum = ran.Next(sizeTablero* sizeTablero-1);
            //int randomNum = ran.Next(((int)ViewState["ctrCardsRemaining"]) - 1);
            cardAtHand = (arrTablero[randomNum] as CartasDTO);
            lblCardAtHand.Text = cardAtHand.Name;
            //arrTablero.RemoveAt(randomNum);
            //ctrCardsRemaining -= 1;*/

            ViewState["arrTablero"] = arrTablero;
            
            ViewState["usedCards"] = usedCards;
        }
        else
        {
            arrTablero = ViewState["arrTablero"] as ArrayList;
            sizeTablero = 3;
            isHard = false;
            cardAtHand = ViewState["cardAtHand"] as CartasDTO;
            usedCards = ViewState["usedCards"] as List<int>;
            //todo: store ctrSound as ViewState
            //todo: show results as variable for testing
            //tbTablero = ViewState["tbTablero"] as Table;
        }


        //lblScore.Text = "0";

        //url,nombre
        //Dictionary<string, string> example = new Dictionary<string, string>();
        //https://stackoverflow.com/questions/687942/java-map-equivalent-in-c-sharp

        //int sizeTablero = Int32.Parse(Request.QueryString["size"]);

        for (int row = 0; row < sizeTablero; row++)
        {
            TableRow tr = new TableRow();
            for (int col = 0; col < sizeTablero; col++)
            {
                TableCell tc = new TableCell();
                ImageButton imgbt = new ImageButton();
                CartasDTO cdto = (arrTablero[(row * 3) + col] as CartasDTO);
                imgbt.ImageUrl = cdto.Path;
                imgbt.AlternateText = cdto.ID.ToString();
                imgbt.Click += new ImageClickEventHandler(imgbtn1_Click);
                imgbt.ID = cdto.ID.ToString();
                tc.Controls.Add(imgbt);
                //tc.Width = new Unit("33px");
                tr.Cells.Add(tc);
            }
            tbTablero.Rows.Add(tr);
        }



        //tbTablero.Rows.Add(new TableRow());
        //tbTablero.Width = new Unit("800px");



        //ViewState["ctrCardsRemaining"] = (((int)ViewState["ctrCardsRemaining"]) - 1);
        //Session["tablero"] = tbTablero;
        /*}
        else
        {
            tbTablero = Session["tablero"] as Table;
        }*/
    }

    protected void imgbtn1_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton ib = (sender as ImageButton);
        //if( .ToString().Equals(lblCardAtHand.Text))
        if (!isHard && cardAtHand.ID.ToString() == ib.ID)
        {
            (sender as ImageButton).ImageUrl = "~/images/fijo/correct.png";
            lblScore.Text = (Int32.Parse(lblScore.Text) + 1).ToString();
            /*Random ran = new Random();
            int randomNum = ran.Next(((int)ViewState["ctrCardsRemaining"])  - 1);
            lblCardAtHand.Text = (arrTablero[randomNum] as  CartasDTO).Name;*/
            
            // + " "+ ((int)ViewState["ctrCardsRemaining"]
            //arrTablero.RemoveAt(randomNum);
            //ViewState["ctrCardsRemaining"] = (((int)ViewState["ctrCardsRemaining"])-1);
        }
        else
        {
            (sender as ImageButton).ImageUrl = "~/images/fijo/incorrect.png";
        }
        usedCards.Add(Int32.Parse(ib.ID));
        //todo: create Page variable to hold the ctrSound total of times Sound was used (it is Int, not boolean)
        int ctrSound = Int32.Parse(hdnUsedSound.Value);
        /*Get new random card to show*/
        setNewRandomCard();
        ib.Enabled = false;
    }

    protected void setNewRandomCard()
    {
        /*card to guess*/
        Random ran = new Random();
        int randomNum;
        do
        {
            randomNum = ran.Next(sizeTablero * sizeTablero);
            //            if (usedCards.IndexOf(randomNum) == -1)
            int returnVal = usedCards.IndexOf((arrTablero[randomNum] as CartasDTO).ID);
            if (returnVal == -1)
                //if (usedCards.IndexOf((arrTablero[randomNum] as CartasDTO).ID) == -1)
            {
                //int randomNum = ran.Next(((int)ViewState["ctrCardsRemaining"]) - 1);
                cardAtHand = (arrTablero[randomNum] as CartasDTO);
                lblCardAtHand.Text = cardAtHand.Name;
                ViewState["cardAtHand"] = cardAtHand;
                break;
            }
            else
            {
                if(usedCards.ToArray().Length >= (sizeTablero * sizeTablero))
                {
                    bool isGameFinished = true;
                    imgBtnShowImage.Enabled = false;
                    imgBtnMakeNoise.Enabled = false;
                    lblGameFinished.Enabled = true;
                    //todo: store ctrSound into database
                    //todo: save into database
                    //todo: change url to Virtual Reward with parameters
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + "google.com" + "','_blank')", true);
                    break;
                }
            }
        } while (true);

    }

    protected void imgBtnRefresh_Click(object sender, ImageClickEventArgs e)
    {

    }
}