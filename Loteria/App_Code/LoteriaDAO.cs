using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Loteria;
using System.Collections;
using System.Data;

/// <summary>
/// Where the queries and stored procedures are called
/// </summary>
public class LoteriaDAO : DAO<CartasDTO>
{
    ArrayList arrCartasByJugador = new ArrayList();

    static SingletonDataConnection sqlConnection;
    public LoteriaDAO () : base ()
    {
        
    }

    public ArrayList getCartasByJugador(int jugadorID)
    {
        reader = executeQuery("SELECT c.intcvecarta, c.vchnombre, c.rutaimagen, cdj.intIDpeso " +
            "FROM cartas c JOIN cartascategoria cc ON c.intcvecarta = cc.intcvecarta " +
            "JOIN categoria cat ON cat.intidcategoria = cc.intidcategoria " +
            "JOIN categoriasdejugador cdj ON cdj.intidcategoria = cat.intidcategoria " +
            "WHERE cdj.intcvejugador = "+ jugadorID);

        if (reader.HasRows)
        {
            while(reader.Read())
            {
                arrCartasByJugador.Add(new CartasDTO(reader.GetInt32(0), reader.GetString(1),
                   "~/images/"+ reader.GetString(2), reader.GetInt32(3)));
            }
        }
        else
        {
            return null;
        }
        reader.Close();
        return arrCartasByJugador;
    }

    /// <summary>
    /// Inserts the Game info into the HISTORIALRESULTADOS table, then returns the INTIDJUEGO
    /// </summary>
    /// <param name="idJugador"></param>
    /// <param name="date"></param>
    /// <param name="totalCorrect"></param>
    /// <param name="totalIncorrect"></param>
    /// <param name="grade"></param>
    /// <param name="totalCardsPlayed"></param>
    /// <param name="isHard"></param>
    /// <param name="totalSound"></param>
    /// <returns>}ID of the HISTORIALRESULTADOS record, to be used in the insert of the DETALLEJUEGO inserts</returns>
    public int insertGameInfo(int idJugador, DateTime date, int totalCorrect, int totalIncorrect, double grade,
        int totalCardsPlayed /*total = X*X */, bool isHard, int totalSound)
    {
        int idJuego = -1;

        //todo pass it to a SP
        reader = executeQuery("INSERT INTO HISTORIALRESULTADOS " +
            "(intcvejugador, datefecha, intaciertos, interrores, intcalificacion, inttotalcartas, booldificil, intsonido) " +
            "VALUES (" + idJugador+",'"+date.ToString("yyyy/MM/dd hh:mm") +"'," + totalCorrect + "," + totalIncorrect + "," + grade + ","
            + totalCardsPlayed + "," + boolToInt(isHard) + "," + totalSound + ");" +
            "SELECT MAX(intIDjuego) FROM HISTORIALRESULTADOS");

        if (reader.HasRows)
        {
            reader.Read();
            idJuego = reader.GetInt32(0);
            
        }
        else
        {
            idJuego=-1;
        }
        reader.Close();

        return idJuego;
    }

    public void insertGameDetails(int idJuego, int idCarta, bool usedSound,bool usedImage, bool guessedCorrectly, int idFrase)
    {
        setProcedure("sp_detallejuego_insert_or_update");
        base.command.Parameters.AddWithValue("@IDCarta", idCarta);
        base.command.Parameters.AddWithValue("@IDJuego", idJuego);
        base.command.Parameters.AddWithValue("@usedSound", usedSound);
        base.command.Parameters.AddWithValue("@usedImage", usedImage);
        base.command.Parameters.AddWithValue("@guessedCorrectly", guessedCorrectly);
        if(idFrase > 0 )
            base.command.Parameters.AddWithValue("@IDFrase", idFrase);
        //base.command.Parameters.Add("@IDDetalle", SqlDbType.Int).Value = null;

        executeProcedure();
        reader.Close();

    }

    public Usuario_Jugador isValidUser(string user, string password)
    {
        Usuario_Jugador userInfo = null;
        //todo, convert it to a SP
        reader = executeQuery("SELECT u.INTCVEUSUARIO, u.VCHUSUARIO, u.CHRTIPOUSUARIO, j.INTCVEJUGADOR, j.VCHNOMBRE " +
            "FROM usuario u LEFT OUTER JOIN jugador j " +
            "ON u.INTCVEUSUARIO = j.INTCVEUSUARIO " +
            "WHERE UPPER(u.VCHUSUARIO) = '" + user.ToUpper() + "' AND u.VCHPASSWORD = '"+ password+"'");

        if (reader.HasRows)
        {
            reader.Read();
            if (!reader.IsDBNull(3))
            {
                userInfo = new Usuario_Jugador(reader.GetInt32(0), reader.GetString(1),
                    reader.GetString(2)[0], reader.GetInt32(3), reader.GetString(4));
            }
            else
            {
                userInfo = new Usuario_Jugador(reader.GetInt32(0), reader.GetString(1),
                    reader.GetString(2)[0]);
            }
        }
        
        reader.Close();
        return userInfo;
    }

    public Dictionary<string, int> getFrasesPerCard (int cardID)
    {
        Dictionary<string, int> frasesPerCard = new Dictionary<string, int>();
        reader = executeQuery("SELECT INTIDFRASE, VCHARFRASE FROM Frases " +
            "WHERE INTCVECARTA = " + cardID);

        if (reader.HasRows)
        {
            reader.Read();
            frasesPerCard.Add( reader.GetString(1), reader.GetInt32(0));
        }

        reader.Close();
        return frasesPerCard;

    }

    int boolToInt(bool isVar)
    {
        return ((isVar) == true) ? 1 : 0;
    }

}