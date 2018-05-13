using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero_TableroFijo : System.Web.UI.Page
{
    ArrayList arrCardsAvailable = new ArrayList();
    int sizeTablero=2;
    bool isHard;
    int ctrCardsRemaining;
    readonly int ctrRefresh = 2;
    CartasDTO cardAtHand;
    //used by the Tablero to know what cards not use
    List<int> usedCards = new List<int>();
    //CartaId, Carta Object
    List<CartasDTO> cardStatics = new List<CartasDTO>();
    ArrayList arrCardsTablero = new ArrayList();
    //Dictionary<int, CartasDTO> cardStatics = new Dictionary<int, CartasDTO>();
    Random ran = new Random();

    int ctrImage = 0;
    int ctrSoundTotal = 0;
    int ctrSort = 0;
    int ctrTotalCorrect = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int32.TryParse(Request.QueryString["size"], out sizeTablero);
        //isHard = Request.QueryString["hard"].Equals("True") ? true : false;
        Boolean.TryParse(Request.QueryString["hard"], out isHard);
        if (!IsPostBack)
        {
            
            /*ctrCardsRemaining = sizeTablero * sizeTablero;
            ViewState["ctrCardsRemaining"] = sizeTablero* sizeTablero;*/
            

            if (isHard)
            {
                imgBtnShowImage.Visible = false;
            }

            /*Load cards data*/
            arrCardsAvailable.Add(new CartasDTO(1, "Elefante", "~/images/fijo/elefante.jpg", "El Elefante tiene orejas grandes",1));
            arrCardsAvailable.Add(new CartasDTO(2, "Delfín", "~/images/fijo/delfin.jpg", "El Delfín nada rápido",2));
            arrCardsAvailable.Add(new CartasDTO(3, "Gato", "~/images/fijo/gato.jpg", "El Gato maulla",5));
            arrCardsAvailable.Add(new CartasDTO(4, "León", "~/images/fijo/leon.jpg", "El León es el rey de la sabana",6));
            arrCardsAvailable.Add(new CartasDTO(5, "Oveja", "~/images/fijo/oveja.jpg", "La oveja esta cubierta de lana",5));
            arrCardsAvailable.Add(new CartasDTO(6, "Perro", "~/images/fijo/perro.jpg", "Al Perro le gustan los huesos",4));
            arrCardsAvailable.Add(new CartasDTO(7, "Puerco", "~/images/fijo/puerco.jpg", "El Puerco esta gordito",9));
            arrCardsAvailable.Add(new CartasDTO(8, "Rana", "~/images/fijo/rana.jpg", "La Rana hace ribit",3));
            arrCardsAvailable.Add(new CartasDTO(9, "Tortuga", "~/images/fijo/tortuga.gif", "La tortuga camina lento",7));


            /*Set the available cards to be used in the board*/
            setCardsTablero();

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

            ViewState["arrTablero"] = arrCardsAvailable;

            ViewState["usedCards"] = usedCards;
            ViewState["cardStatics"] = cardStatics;
            ViewState["ctrSoundTotal"] = ctrSoundTotal;
            ViewState["arrCardsTablero"] = arrCardsTablero;
            ViewState["ctrSort"] = ctrSort;
            ViewState["ctrTotalCorrect"] = ctrTotalCorrect;
        }
        else
        {
            arrCardsAvailable = ViewState["arrTablero"] as ArrayList;
            cardAtHand = ViewState["cardAtHand"] as CartasDTO;
            usedCards = ViewState["usedCards"] as List<int>;
            cardStatics = ViewState["cardStatics"] as List<CartasDTO>;
            ctrImage = Int32.Parse(ViewState["ctrImage"].ToString());
            ctrSoundTotal = Int32.Parse(ViewState["ctrSoundTotal"].ToString());
            arrCardsTablero = ViewState["arrCardsTablero"] as ArrayList;
            ctrSort = Int32.Parse(ViewState["ctrSort"].ToString());
            ctrTotalCorrect = Int32.Parse(ViewState["ctrTotalCorrect"].ToString());
            //todo: show results as variable for testing
            //tbTablero = ViewState["tbTablero"] as Table;
        }

        redrawBoard();

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
        hideSortControls();
        ImageButton ib = (sender as ImageButton);
        //if( .ToString().Equals(lblCardAtHand.Text))
        if (cardAtHand.ID.ToString() == ib.ID)
        {
            (sender as ImageButton).ImageUrl = "~/images/fijo/correct.png";
            lblScore.Text = (Int32.Parse(lblScore.Text) + 1).ToString();
            cardStatics[cardStatics.ToArray().Length - 1].GuessedCorrectly = true;
            ctrTotalCorrect++;
            ViewState["ctrTotalCorrect"] = ctrTotalCorrect;
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
            cardStatics[cardStatics.ToArray().Length - 1].GuessedCorrectly = false;
        }
        usedCards.Add(Int32.Parse(ib.ID));

        //used sound, store it
        cardStatics[cardStatics.ToArray().Length - 1].UsedSound = Int32.Parse(hdnUsedSound.Value) >= 1 ? true : false;
        
        //todo: create Page variable to hold the ctrSound total of times Sound was used (it is Int, not boolean)
        ViewState["ctrSoundTotal"] = ctrSoundTotal +Int32.Parse(hdnUsedSound.Value);
        /*Get new random card to show*/
        setNewRandomCard();
        ib.Enabled = false;
    }

    protected void setNewRandomCard()
    {
        /*card to guess*/
        
        int randomNum;
        do
        {
            randomNum = ran.Next(sizeTablero * sizeTablero);
            //            if (usedCards.IndexOf(randomNum) == -1)
            int returnVal = usedCards.IndexOf((arrCardsTablero[randomNum] as CartasDTO).ID);
            if (returnVal == -1)
                //if (usedCards.IndexOf((arrTablero[randomNum] as CartasDTO).ID) == -1)
            {
                //int randomNum = ran.Next(((int)ViewState["ctrCardsRemaining"]) - 1);
                cardAtHand = (arrCardsTablero[randomNum] as CartasDTO);
                if (isHard)
                {
                    lblCardAtHand.Text = cardAtHand.Statement;
                }
                else
                {
                    lblCardAtHand.Text = cardAtHand.Name;
                }
                imgCardAtHand.ImageUrl = cardAtHand.Path;
                imgCardAtHand.Visible = false;
                ViewState["cardAtHand"] = cardAtHand;
                ViewState["ctrImage"] = ctrImage;

                cardStatics.Add(cardAtHand);
                ViewState["cardStatics"] = cardStatics;
                if (!isHard)
                {
                    imgBtnShowImage.Enabled = true;
                }
                hdnUsedSound.Value = "0";
                break;
            }
            else
            {
                if(usedCards.ToArray().Length >= (sizeTablero * sizeTablero))
                {
                    bool isGameFinished = true;
                    imgBtnShowImage.Enabled = false;
                    imgBtnMakeNoise.Enabled = false;
                    lblGameFinished.Visible = true;
                   
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup",
                        "window.open('" + "Recompensa.aspx?total="+(sizeTablero*sizeTablero)+"&correct="+ ctrTotalCorrect + "','_blank', " +
                        "'width=250,height=350,toolbar=no,location = no,status = no," +
                        "menubar = no,scrollbars = yes,resizable = yes,width = SomeSize,height = SomeSize')", true);
                    break;
                }
            }
        } while (true);

    }

    protected void imgBtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        ctrSort = Int32.Parse(ViewState["ctrSort"].ToString());
        ctrSort++;



        lblSortQuestion.Text = "¿Reborujar por última vez?";
        arrCardsTablero.Clear();
        tbTablero.Rows.Clear();
        setCardsTablero();
        setNewRandomCard();
        redrawBoard();

        if (ctrSort >=2)
        {
            hideSortControls();
        }

        ViewState["ctrSort"] = ctrSort;
    }

    protected void imgBtnShowImage_Click(object sender, ImageClickEventArgs e)
    {
        hideSortControls();
        cardStatics[cardStatics.ToArray().Length - 1].UsedImage = true;
        ViewState["cardStatics"] = cardStatics;
        imgCardAtHand.Visible = true;
        ViewState["ctrImage"] = ++ctrImage;
        (sender as ImageButton).Enabled = false;
    }

    protected void setCardsTablero()
    {
        //arrCardsTablero;
        //randomNum = ran.Next(sizeTablero * sizeTablero);
        //Weight
        //based in 1-9 (like 10%-90% but inverse), higher weight number, higher probability to show

        int index;
        int ctrWhile = 0;
        do
        {
            index = ran.Next(9);

            if ((arrCardsAvailable[index] as CartasDTO).Weight
                >= ran.Next(sizeTablero * sizeTablero))
            {
                //is card not already in the ArrayList?
                if (arrCardsTablero.IndexOf(arrCardsAvailable[index] as CartasDTO)==-1)
                {
                    arrCardsTablero.Add(arrCardsAvailable[index]);
                    ctrWhile++;
                }
            }
        } while (ctrWhile< (sizeTablero * sizeTablero));
    }

    protected void hideSortControls()
    {
        imgBtnRefresh.Visible = false;
        lblSortQuestion.Visible = false;
    }

    protected void redrawBoard()
    {
        for (int row = 0; row < sizeTablero; row++)
        {
            TableRow tr = new TableRow();
            for (int col = 0; col < sizeTablero; col++)
            {
                TableCell tc = new TableCell();
                ImageButton imgbt = new ImageButton();
                CartasDTO cdto = (arrCardsTablero[(row * sizeTablero) + col] as CartasDTO);
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
    }
}