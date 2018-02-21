using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tablero : PageBaseJugadorAuthentication
{
    ArrayList arrCardsAvailable = new ArrayList();
    int sizeTablero=2;
    bool isHard;
    int ctrCardsRemaining;
    readonly int ctrRefresh = 2;
    CartasDTO cardAtHand;
    //used by the Tablero to know what cards not use
    List<int> usedCards = new List<int>();
    //CartaId, Carta Object. To be stored into the database as game detail
    List<CartasDTO> cardStatics = new List<CartasDTO>();
    //holds the cards that are used in the tablero
    ArrayList arrCardsTablero = new ArrayList();
    //Dictionary<int, CartasDTO> cardStatics = new Dictionary<int, CartasDTO>();
    Random ran = new Random();

    int ctrImage = 0;
    int ctrSoundTotal = 0;
    int ctrSort = 0;
    int ctrTotalCorrect = 0;
    int ctrTotalIncorrect = 0;
    int ctrTotalCardsPlayer = 0;

    bool isGameFinished = false;

    LoteriaDAO loteria = new LoteriaDAO();

    /// <summary>
    /// Main function.
    /// Load the data into the Tablero, then create the ViewState to keep info between postbacks
    /// and reloads the info after postbacks
    /// </summary>
    /// <param name="sender">The page</param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        isJugadorLoggedIn();

        Int32.TryParse(Request.QueryString["size"], out sizeTablero);
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
            arrCardsAvailable = loteria.getCartasByJugador( JugadorID );

            /*Set the available cards to be used in the board*/
            setCardsTablero();

            /*card to guess*/
            setNewRandomCard();

            ViewState["arrTablero"] = arrCardsAvailable;

            ViewState["usedCards"] = usedCards;
            ViewState["cardStatics"] = cardStatics;
            ViewState["ctrSoundTotal"] = ctrSoundTotal;
            ViewState["arrCardsTablero"] = arrCardsTablero;
            ViewState["ctrSort"] = ctrSort;
            ViewState["ctrTotalCorrect"] = ctrTotalCorrect;
            ViewState["ctrTotalIncorrect"] = ctrTotalIncorrect;
            ViewState["ctrTotalCardsPlayer"] = ctrTotalCardsPlayer;
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
            ctrTotalIncorrect = Int32.Parse(ViewState["ctrTotalIncorrect"].ToString());
            ctrTotalCardsPlayer = Int32.Parse(ViewState["ctrTotalCardsPlayer"].ToString());

        }

        redrawBoard();
    }

    /// <summary>
    /// Called by the buttons in the Tablero table grid
    /// </summary>
    /// <param name="sender">ImageButton in the Tablero</param>
    /// <param name="e">Event of the click</param>
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
            ctrTotalIncorrect++;
            ViewState["ctrTotalIncorrect"] = ctrTotalIncorrect;
        }
        usedCards.Add(Int32.Parse(ib.ID));
        ViewState["usedCards"] = usedCards;
        ctrTotalCardsPlayer++;
        ViewState["ctrTotalCardsPlayer"] = ctrTotalCardsPlayer;

        //used sound, store it
        cardStatics[cardStatics.ToArray().Length - 1].UsedSound = Int32.Parse(hdnUsedSound.Value) >= 1 ? true : false;
        
        //todo: create Page variable to hold the ctrSound total of times Sound was used (it is Int, not boolean)
        ViewState["ctrSoundTotal"] = ctrSoundTotal +Int32.Parse(hdnUsedSound.Value);
        /*Get new random card to show*/
        setNewRandomCard();
        ib.Enabled = false;
    }
    

    /// <summary>
    /// Set a new random card from the cards available into the Tablero, and set the initial default values
    /// </summary>
    protected void setNewRandomCard()
    {
        /*card to guess*/
        
        int randomNum;
        do
        {
            randomNum = ran.Next(sizeTablero * sizeTablero);
            //            if (usedCards.IndexOf(randomNum) == -1)
            int returnVal = usedCards.IndexOf((arrCardsTablero[randomNum] as CartasDTO).ID);
            if (returnVal == -1 && !isGameFinished)//card not existing or isGameFinished is false
            {
                //set a new random card                
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
                if(usedCards.ToArray().Length >= (sizeTablero * sizeTablero) || isGameFinished)//game is ended?
                {
                    
                    imgBtnShowImage.Enabled = false;
                    imgBtnMakeNoise.Enabled = false;
                    lblGameFinished.Visible = true;

                    int gameID = loteria.insertGameInfo(JugadorID,
                        DateTime.Now, ctrTotalCorrect, ctrTotalIncorrect,
                        ((double)ctrTotalCorrect) / ((double)ctrTotalCardsPlayer) * 10.0, //grade
                        ctrTotalCardsPlayer, isHard, ctrSoundTotal);
                    if(gameID >= 1)
                    {
                        foreach(CartasDTO carta in cardStatics)
                        {
                            loteria.insertGameDetails(gameID, carta.ID, true, false, true);
                        }

                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup",
                            "window.open('" + "Recompensa.aspx?total="+(sizeTablero*sizeTablero)+"&correct="+ ctrTotalCorrect + "','_blank', " +
                            "'width=250,height=350,toolbar=no,location = no,status = no," +
                            "menubar = no,scrollbars = yes,resizable = yes,width = SomeSize,height = SomeSize')", true);
                    }
                    else
                    {
                        //problem when trying to save the game, let them know
                        lblGameFinished.Text = "Ha habido algun problema, contacta al administrador";
                    }

                    break;
                }
            }
        } while (true);

    }

    /// <summary>
    /// Reloads the Tablero table grid with new ImageButtons.
    /// It is used a maximum of 2 times
    /// </summary>
    /// <param name="sender">The ImageButton to reload the Tablero</param>
    /// <param name="e">Click event</param>
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

    /// <summary>
    /// Show the image that is being played to help the Jugador.
    /// Only show in in "easy" mode.
    /// </summary>
    /// <param name="sender">The ImageButton</param>
    /// <param name="e">Click event</param>
    protected void imgBtnShowImage_Click(object sender, ImageClickEventArgs e)
    {
        hideSortControls();
        cardStatics[cardStatics.ToArray().Length - 1].UsedImage = true;
        ViewState["cardStatics"] = cardStatics;
        imgCardAtHand.Visible = true;
        ViewState["ctrImage"] = ++ctrImage;
        (sender as ImageButton).Enabled = false;
    }

    /// <summary>
    /// Picks the from the Available cards the ones to be played in the Tablero
    /// by measuring the Weight + Random index position.
    /// </summary>
    protected void setCardsTablero()
    {
        //Weight
        //based in 1-9 (like 10%-90% but inverse), higher weight number, higher probability to show

        int index;
        int ctrWhile = 0;
        do
        {
            index = ran.Next(arrCardsAvailable.ToArray().Length-1);

            if ((arrCardsAvailable[index] as CartasDTO).Weight
                >= ran.Next(sizeTablero * sizeTablero))//Check weight and random position number
            {
                //is card not already in the ArrayList of to-be-played cards"
                if (arrCardsTablero.IndexOf(arrCardsAvailable[index] as CartasDTO)==-1)
                {
                    arrCardsTablero.Add(arrCardsAvailable[index]);
                    ctrWhile++;
                }
            }
        } while (ctrWhile< (sizeTablero * sizeTablero));
    }

    /// <summary>
    /// Hide sort controls after the Jugador played one card of finished all his tries
    /// </summary>
    protected void hideSortControls()
    {
        imgBtnRefresh.Visible = false;
        lblSortQuestion.Visible = false;
    }

    /// <summary>
    /// Redraw the board based in the cards played and to-be-played.
    /// </summary>
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

    /// <summary>
    /// Finish the game called by the user. Only finish the game if played 2 or more cards.
    /// </summary>
    /// <param name="sender">Finish Button</param>
    /// <param name="e">Click parameters</param>
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        if(ctrTotalCardsPlayer>=2)
        { 
            isGameFinished = true;
            setNewRandomCard();//finish the game
        }
    }
}