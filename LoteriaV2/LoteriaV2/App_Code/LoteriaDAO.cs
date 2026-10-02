using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Where the queries and stored procedures are called
/// Refactored: All queries now use parameterization to prevent SQL injection
/// </summary>
public class LoteriaDAO : DAO<CartasDTO>
{
    List<CartasDTO> cardsByPlayer = new List<CartasDTO>();

    public LoteriaDAO() : base()
    {
        
    }

    public List<CartasDTO> getCartasByJugador(int jugadorID)
    {
        cardsByPlayer.Clear();
        
        string query = "SELECT c.intcvecarta, c.vchnombre, c.rutaimagen, cdj.intIDpeso " +
            "FROM cartas c JOIN cartascategoria cc ON c.intcvecarta = cc.intcvecarta " +
            "JOIN categoria cat ON cat.intidcategoria = cc.intidcategoria " +
            "JOIN categoriasdejugador cdj ON cdj.intidcategoria = cat.intidcategoria " +
            "WHERE cdj.intcvejugador = @jugadorID";
        
        SqlParameter[] parameters = new SqlParameter[] {
            new SqlParameter("@jugadorID", SqlDbType.Int) { Value = jugadorID }
        };
        
        reader = executeQuery(query, parameters);

        if (reader.HasRows)
        {
            while(reader.Read())
            {
                cardsByPlayer.Add(new CartasDTO(reader.GetInt32(0), reader.GetString(1),
                   "~/images/" + reader.GetString(2), reader.GetInt32(3)));
            }
        }
        else
        {
            return null;
        }
        reader.Close();
        return cardsByPlayer;
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
    /// <returns>ID of the HISTORIALRESULTADOS record, to be used in the insert of the DETALLEJUEGO inserts</returns>
    public int insertGameInfo(int idJugador, DateTime date, int totalCorrect, int totalIncorrect, double grade,
        int totalCardsPlayed /*total = X*X */, bool isHard, int totalSound)
    {
        int idJuego = -1;

        // Using parameterized query to prevent SQL injection
        string query = "INSERT INTO HISTORIALRESULTADOS " +
            "(intcvejugador, datefecha, intaciertos, interrores, intcalificacion, inttotalcartas, booldificil, intsonido) " +
            "VALUES (@idJugador, @date, @totalCorrect, @totalIncorrect, @grade, @totalCardsPlayed, @isHard, @totalSound);" +
            "SELECT MAX(intIDjuego) FROM HISTORIALRESULTADOS";
        
        SqlParameter[] parameters = new SqlParameter[]
        {
            new SqlParameter("@idJugador", SqlDbType.Int) { Value = idJugador },
            new SqlParameter("@date", SqlDbType.DateTime) { Value = date },
            new SqlParameter("@totalCorrect", SqlDbType.Int) { Value = totalCorrect },
            new SqlParameter("@totalIncorrect", SqlDbType.Int) { Value = totalIncorrect },
            new SqlParameter("@grade", SqlDbType.Float) { Value = grade },
            new SqlParameter("@totalCardsPlayed", SqlDbType.Int) { Value = totalCardsPlayed },
            new SqlParameter("@isHard", SqlDbType.Bit) { Value = isHard },
            new SqlParameter("@totalSound", SqlDbType.Int) { Value = totalSound }
        };
        
        reader = executeQuery(query, parameters);

        if (reader.HasRows)
        {
            reader.Read();
            idJuego = reader.GetInt32(0);
            
        }
        else
        {
            idJuego = -1;
        }
        reader.Close();

        return idJuego;
    }

    public void insertGameDetails(int idJuego, int idCarta, bool usedSound, bool usedImage, bool guessedCorrectly, int idFrase)
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
        
        // CRITICAL: Using parameterized query to prevent SQL injection
        string query = "SELECT u.INTCVEUSUARIO, u.VCHUSUARIO, u.CHRTIPOUSUARIO, j.INTCVEJUGADOR, j.VCHNOMBRE " +
            "FROM usuario u LEFT OUTER JOIN jugador j " +
            "ON u.INTCVEUSUARIO = j.INTCVEUSUARIO " +
            "WHERE UPPER(u.VCHUSUARIO) = @user AND u.VCHPASSWORD = @password";
        
        SqlParameter[] parameters = new SqlParameter[]
        {
            new SqlParameter("@user", SqlDbType.NVarChar, 100) { Value = user.ToUpper() },
            new SqlParameter("@password", SqlDbType.NVarChar, 100) { Value = password }
        };
        
        reader = executeQuery(query, parameters);

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

    public Dictionary<string, int> getFrasesPerCard(int cardID)
    {
        Dictionary<string, int> frasesPerCard = new Dictionary<string, int>();
        
        string query = "SELECT INTIDFRASE, VCHARFRASE FROM Frases " +
            "WHERE INTCVECARTA = @cardID";
        
        SqlParameter[] parameters = new SqlParameter[]
        {
            new SqlParameter("@cardID", SqlDbType.Int) { Value = cardID }
        };
        
        reader = executeQuery(query, parameters);

        if (reader.HasRows)
        {
            reader.Read();
            frasesPerCard.Add(reader.GetString(1), reader.GetInt32(0));
        }

        reader.Close();
        return frasesPerCard;

    }

    int boolToInt(bool isVar)
    {
        return ((isVar) == true) ? 1 : 0;
    }

}
