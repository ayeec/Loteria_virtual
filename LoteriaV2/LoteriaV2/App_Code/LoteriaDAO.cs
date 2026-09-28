using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

public class LoteriaDAO : DAO<CartasDTO>
{
    public ArrayList getCartasByJugador(int jugadorID)
    {
        return executeQuery(
            "SELECT c.intcvecarta, c.vchnombre, c.rutaimagen, cdj.intIDpeso " +
            "FROM cartas c JOIN cartascategoria cc ON c.intcvecarta = cc.intcvecarta " +
            "JOIN categoria cat ON cat.intidcategoria = cc.intidcategoria " +
            "JOIN categoriasdejugador cdj ON cdj.intidcategoria = cat.intidcategoria " +
            "WHERE cdj.intcvejugador = @jugadorID",
            delegate(SqlDataReader reader)
            {
                ArrayList cards = new ArrayList();
                while (reader.Read())
                {
                    cards.Add(new CartasDTO(reader.GetInt32(0), reader.GetString(1),
                        "~/images/" + reader.GetString(2), reader.GetInt32(3)));
                }

                return cards;
            },
            new SqlParameter("@jugadorID", SqlDbType.Int) { Value = jugadorID });
    }

    public int insertCompletedGame(
        int playerId,
        DateTime date,
        int totalCorrect,
        int totalIncorrect,
        double grade,
        int totalCardsPlayed,
        bool isHard,
        int totalSound,
        IList<int> cardIds,
        IList<CartasDTO> cardResults,
        IList<int> phraseIds)
    {
        if (cardIds == null || cardResults == null || phraseIds == null ||
            cardIds.Count != totalCardsPlayed ||
            cardResults.Count != totalCardsPlayed ||
            phraseIds.Count != totalCardsPlayed)
        {
            throw new ArgumentException("Game card results must match the total cards played.");
        }

        using (SqlConnection connection = SingletonDataConnection.CreateConnection())
        {
            connection.Open();
            using (SqlTransaction transaction = connection.BeginTransaction())
            {
                try
                {
                    object result = executeScalar(
                        "INSERT INTO HISTORIALRESULTADOS " +
                        "(intcvejugador, datefecha, intaciertos, interrores, intcalificacion, inttotalcartas, booldificil, intsonido) " +
                        "VALUES (@jugadorID, @fecha, @totalCorrect, @totalIncorrect, @calificacion, @totalCartas, @dificil, @sonido); " +
                        "SELECT CONVERT(int, SCOPE_IDENTITY())",
                        transaction,
                        new SqlParameter("@jugadorID", SqlDbType.Int) { Value = playerId },
                        new SqlParameter("@fecha", SqlDbType.DateTime) { Value = date },
                        new SqlParameter("@totalCorrect", SqlDbType.Int) { Value = totalCorrect },
                        new SqlParameter("@totalIncorrect", SqlDbType.Int) { Value = totalIncorrect },
                        new SqlParameter("@calificacion", SqlDbType.Float) { Value = grade },
                        new SqlParameter("@totalCartas", SqlDbType.Int) { Value = totalCardsPlayed },
                        new SqlParameter("@dificil", SqlDbType.Bit) { Value = isHard },
                        new SqlParameter("@sonido", SqlDbType.Int) { Value = totalSound });

                    if (result == null || result == DBNull.Value)
                    {
                        throw new DataException("The database did not return the new game ID.");
                    }

                    int gameId = Convert.ToInt32(result);
                    for (int i = 0; i < totalCardsPlayed; i++)
                    {
                        CartasDTO card = cardResults[i];
                        List<SqlParameter> parameters = new List<SqlParameter>
                        {
                            new SqlParameter("@IDCarta", SqlDbType.Int) { Value = cardIds[i] },
                            new SqlParameter("@IDJuego", SqlDbType.Int) { Value = gameId },
                            new SqlParameter("@usedSound", SqlDbType.Bit) { Value = card.UsedSound },
                            new SqlParameter("@usedImage", SqlDbType.Bit) { Value = card.UsedImage },
                            new SqlParameter("@guessedCorrectly", SqlDbType.Bit) { Value = card.GuessedCorrectly }
                        };

                        if (phraseIds[i] > 0)
                        {
                            parameters.Add(new SqlParameter("@IDFrase", SqlDbType.Int)
                                { Value = phraseIds[i] });
                        }

                        executeProcedureNonQuery(
                            "sp_detallejuego_insert_or_update", transaction, parameters.ToArray());
                    }

                    transaction.Commit();
                    return gameId;
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
        }
    }

    public Usuario_Jugador isValidUser(string user, string password)
    {
        LoginRecord record = executeQuery(
            "SELECT u.INTCVEUSUARIO, u.VCHUSUARIO, u.CHRTIPOUSUARIO, " +
            "j.INTCVEJUGADOR, j.VCHNOMBRE, u.VCHPASSWORD " +
            "FROM usuario u LEFT OUTER JOIN jugador j " +
            "ON u.INTCVEUSUARIO = j.INTCVEUSUARIO " +
            "WHERE UPPER(u.VCHUSUARIO) = UPPER(@username)",
            delegate(SqlDataReader reader)
            {
                if (!reader.Read())
                {
                    return null;
                }

                return new LoginRecord
                {
                    UserId = reader.GetInt32(0),
                    Username = reader.GetString(1),
                    Role = reader.GetString(2)[0],
                    PlayerId = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3),
                    PlayerName = reader.IsDBNull(4) ? null : reader.GetString(4),
                    Password = reader.IsDBNull(5) ? null : reader.GetString(5)
                };
            },
            new SqlParameter("@username", SqlDbType.NVarChar, 256)
                { Value = (user ?? String.Empty).ToUpperInvariant() });

        bool needsPasswordUpgrade;
        if (record == null ||
            (record.Role != 'A' && record.Role != 'J') ||
            !PasswordStorage.VerifyPassword(record.Password, password, out needsPasswordUpgrade))
        {
            return null;
        }

        if (needsPasswordUpgrade)
        {
            executeNonQuery("UPDATE usuario SET VCHPASSWORD = @newPassword " +
                "WHERE INTCVEUSUARIO = @userID AND VCHPASSWORD = @oldPassword",
                new SqlParameter("@newPassword", SqlDbType.NVarChar, 256)
                    { Value = PasswordStorage.HashPassword(password) },
                new SqlParameter("@userID", SqlDbType.Int) { Value = record.UserId },
                new SqlParameter("@oldPassword", SqlDbType.NVarChar, 256) { Value = record.Password });
        }

        if (record.PlayerId.HasValue)
        {
            return new Usuario_Jugador(record.UserId, record.Username, record.Role,
                record.PlayerId.Value, record.PlayerName);
        }

        return new Usuario_Jugador(record.UserId, record.Username, record.Role);
    }

    public Dictionary<string, int> getFrasesPerCard(int cardID)
    {
        return executeQuery(
            "SELECT INTIDFRASE, VCHARFRASE FROM Frases WHERE INTCVECARTA = @cardID",
            delegate(SqlDataReader reader)
            {
                Dictionary<string, int> phrases = new Dictionary<string, int>();
                if (reader.Read())
                {
                    phrases.Add(reader.GetString(1), reader.GetInt32(0));
                }

                return phrases;
            },
            new SqlParameter("@cardID", SqlDbType.Int) { Value = cardID });
    }

    private sealed class LoginRecord
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public char Role { get; set; }
        public int? PlayerId { get; set; }
        public string PlayerName { get; set; }
        public string Password { get; set; }
    }
}
