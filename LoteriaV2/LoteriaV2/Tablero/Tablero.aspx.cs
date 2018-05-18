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
    int fraseAtHandID;
    //used by the Tablero to know what cards not use
    List<int> usedCards = new List<int>();
    //Frase used, runs paralel to usedCards List
    Dictionary<string, int> usedFrases = new Dictionary<string, int>();

    //CartaId, Carta Object. To be stored into the database as game detail
    List<CartasDTO> cardStatics = new List<CartasDTO>();
    //holds the cards that are used in the tablero
    ArrayList arrCardsTablero = new ArrayList();
    Dictionary<string, int> arrFrasesTablero = new Dictionary<string, int>();//todo add to viewstate

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

            if(arrCardsAvailable.ToArray().Length <(sizeTablero * sizeTablero))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "showalert",
                            "alert('El Jugador no cuenta con las suficientes cartas para jugar, " +
                            "intente con un tablero mas pequeño'); window.close();", true);

                return;
            }
            else
            {
                foreach (var card in arrCardsAvailable)
                {
                    (card as CartasDTO).Frases = loteria.getFrasesPerCard((card as CartasDTO).ID);
                }
            }

            /*Set the available cards to be used in the board*/
            setCardsTablero();

            /*card to guess*/
            setNewRandomCard();

            ViewState["arrTablero"] = arrCardsAvailable;

            ViewState["usedCards"] = usedCards;
            ViewState["usedFrases"] = usedFrases;

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
            fraseAtHandID = Int32.Parse(ViewState["fraseAtHandID"].ToString());

            usedCards = ViewState["usedCards"] as List<int>;
            usedFrases = ViewState["usedFrases"] as Dictionary<string,int>;

            arrFrasesTablero = ViewState["arrFrasesTablero"] as Dictionary<string, int>;

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

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "playsound",
                            "playSound('correct.mp3');", true);

            /*Random ran = new Random();
            int randomNum = ran.Next(((int)ViewState["ctrCardsRemaining"])  - 1);
            lblCardAtHand.Text = (arrTablero[randomNum] as  CartasDTO).Name;*/

            // + " "+ ((int)ViewState["ctrCardsRemaining"]
            //arrTablero.RemoveAt(randomNum);
            //ViewState["ctrCardsRemaining"] = (((int)ViewState["ctrCardsRemaining"])-1);
        }
        else
        {
            ib.ImageUrl = "~/images/fijo/incorrect.png";
            cardStatics[cardStatics.ToArray().Length - 1].GuessedCorrectly = false;
            ctrTotalIncorrect++;
            ViewState["ctrTotalIncorrect"] = ctrTotalIncorrect;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "playsound",
                            "playSound('incorrect.mp3');", true);
        }
        /*todo: move to above else statements because they are causing issues with
         * selecting a card incorrectly counting the card not selected (the one at hand) to be saved to the 
         * used arrays
        */
        usedCards.Add(Int32.Parse(ib.ID));
        usedFrases.Add( ib.AlternateText, arrFrasesTablero[ib.AlternateText]);

        ViewState["usedCards"] = usedCards;
        ViewState["usedFrases"] = usedFrases;
        ctrTotalCardsPlayer++;
        ViewState["ctrTotalCardsPlayer"] = ctrTotalCardsPlayer;

        //used sound, store it
        cardStatics[cardStatics.ToArray().Length - 1].UsedSound = Int32.Parse(hdnUsedSound.Value) >= 1 ? true : false;
        
        //Page variable to hold the ctrSound total of times Sound was used (it is Int, not boolean)
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
                //if (isHard && cardAtHand.Frases.ToArray().Length >= 1)
                if (isHard && arrFrasesTablero.ElementAt(randomNum).Value >= 1)
                {
                        //if cards help disabled (hard mode), then use frases
                        //AND there is at least one Frase for the card

                        /*todo: move this code to the setCardsTablero function to add in parallel to the
                         available cards at random the Frase instead here because this causes problems with the saving in the other todo*/
                        /*int tmpRandNum = ran.Next(cardAtHand.Frases.ToArray().Length);
                        lblCardAtHand.Text = cardAtHand.Frases.ToArray().ElementAt(tmpRandNum).Key;
                        fraseAtHandID = cardAtHand.Frases.ToArray().ElementAt(tmpRandNum).Value;*/
                        lblCardAtHand.Text = arrFrasesTablero.ElementAt(randomNum).Key;
                        fraseAtHandID = arrFrasesTablero.ElementAt(randomNum).Value;
                }
                else
                {
                    //help is enabled AND/OR there are no more than 1 Frases for the card
                    lblCardAtHand.Text = cardAtHand.Name;
                    fraseAtHandID = 0;
                }
                imgCardAtHand.ImageUrl = cardAtHand.Path;
                imgCardAtHand.Visible = false;
                ViewState["fraseAtHandID"] = fraseAtHandID;
                ViewState["cardAtHand"] = cardAtHand;
                ViewState["ctrImage"] = ctrImage;

                cardStatics.Add(cardAtHand);
                ViewState["cardStatics"] = cardStatics;
                if (!isHard)
                {
                    imgBtnShowImage.Enabled = true;
                    imgBtnShowImage.Visible = true;
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
                        for(int i = 0; i< usedFrases.ToArray().Length; i++)
                        //foreach(CartasDTO carta in cardStatics)
                        {
                            CartasDTO carta = cardStatics.ToArray().ElementAt(i);
                            loteria.insertGameDetails(gameID, usedCards[i], carta.UsedSound, carta.UsedImage, 
                                carta.GuessedCorrectly, usedFrases.ElementAt(i).Value);
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
        arrFrasesTablero.Clear();
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
        (sender as ImageButton).Visible = false;
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
            index = ran.Next(arrCardsAvailable.ToArray().Length);

            if ((arrCardsAvailable[index] as CartasDTO).Weight
                >= ran.Next(sizeTablero * sizeTablero))//Check weight and random position number
            {
                //is card not already in the ArrayList of to-be-played cards"
                if (arrCardsTablero.IndexOf(arrCardsAvailable[index] as CartasDTO)==-1)
                {
                    arrCardsTablero.Add(arrCardsAvailable[index]);
                    ctrWhile++;
                    if ((arrCardsAvailable[index] as CartasDTO).Frases.ToArray().Length >= 1)
                    {
                        int tmpFrase = ran.Next((arrCardsAvailable[index] as CartasDTO).Frases.ToArray().Length);
                        arrFrasesTablero.Add((arrCardsAvailable[index] as CartasDTO).Frases.ToArray().ElementAt(tmpFrase).Key,
                            (arrCardsAvailable[index] as CartasDTO).Frases.ToArray().ElementAt(tmpFrase).Value);
                    }
                    else
                    {
                        arrFrasesTablero.Add((arrCardsAvailable[index] as CartasDTO).Name, 0);
                    }
                }
            }
        } while (ctrWhile< (sizeTablero * sizeTablero));
        ViewState["arrFrasesTablero"] = arrFrasesTablero;
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
                imgbt.AlternateText = arrFrasesTablero.ElementAt((row * sizeTablero) + col).Key;
                //    imgbt.AlternateText = cdto.ID.ToString();
                
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

    /// <summary>
    /// Skips the card temporarly changing to another card to minimize frustration for the user
    /// </summary>
    /// <param name="sender">Button to skip</param>
    /// <param name="e">Click parameters</param>
    protected void btnSkip_Click(object sender, ImageClickEventArgs e)
    {
        setNewRandomCard();
    }
}