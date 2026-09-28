/*
 * User: ayee
 * Date: 12/12/2017
 * Time: 2:09 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Data;
using System.Data.SqlClient;

public abstract class DAO<T>
{
    protected TResult executeQuery<TResult>(
        string query, Func<SqlDataReader, TResult> readResult, params SqlParameter[] parameters)
    {
        if (readResult == null)
        {
            throw new ArgumentNullException("readResult");
        }

        using (SqlConnection connection = SingletonDataConnection.CreateConnection())
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            AddParameters(command, parameters);
            connection.Open();
            using (SqlDataReader reader = command.ExecuteReader())
            {
                return readResult(reader);
            }
        }
    }

    protected object executeScalar(
        string query, SqlTransaction transaction, params SqlParameter[] parameters)
    {
        if (transaction == null)
        {
            throw new ArgumentNullException("transaction");
        }

        using (SqlCommand command = new SqlCommand(query, transaction.Connection, transaction))
        {
            AddParameters(command, parameters);
            return command.ExecuteScalar();
        }
    }

    protected int executeNonQuery(string query, params SqlParameter[] parameters)
    {
        using (SqlConnection connection = SingletonDataConnection.CreateConnection())
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            AddParameters(command, parameters);
            connection.Open();
            return command.ExecuteNonQuery();
        }
    }

    protected int executeProcedureNonQuery(
        string procedureName, SqlTransaction transaction, params SqlParameter[] parameters)
    {
        if (transaction == null)
        {
            throw new ArgumentNullException("transaction");
        }

        using (SqlCommand command = new SqlCommand(procedureName, transaction.Connection, transaction))
        {
            command.CommandType = CommandType.StoredProcedure;
            AddParameters(command, parameters);
            return command.ExecuteNonQuery();
        }
    }

    private static void AddParameters(SqlCommand command, SqlParameter[] parameters)
    {
        if (parameters != null && parameters.Length > 0)
        {
            command.Parameters.AddRange(parameters);
        }
    }
}
