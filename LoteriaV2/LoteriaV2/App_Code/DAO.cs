/*
 * User: ayee
 * Date: 12/12/2017
 * Time: 2:09 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 * 
 * Refactored: Added parameterized query support and proper disposal
 */
using System;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Data Access Object
/// Used to connect the queries and procedures to the database execution.
/// </summary>
public abstract class DAO<T> : IDisposable
{

	protected SqlCommand command;
	
	protected SqlDataReader reader;

    public DAO()
	{
		//this.dataConnection = sqlConnection;
	}

    //public abstract void executeSQL(T objeto, String procedimiento, int opcion);
    
    /// <summary>
    /// Executes a parameterized SQL query
    /// </summary>
    /// <param name="query">SQL query with parameters (use @paramName)</param>
    /// <param name="parameters">SqlParameter collection</param>
    /// <returns>SqlDataReader</returns>
    public SqlDataReader executeQuery(String query, SqlParameter[] parameters = null)
    {
        command = new SqlCommand(query, SingletonDataConnection.Instance);
        
        if (parameters != null && parameters.Length > 0)
        {
            command.Parameters.AddRange(parameters);
        }
        
        reader = command.ExecuteReader();
		
		return reader;
	}
	
    /// <summary>
    /// Executes a parameterized query and returns a scalar value
    /// </summary>
    /// <param name="query">SQL query</param>
    /// <param name="parameters">Parameters</param>
    /// <returns>Object result</returns>
    protected object executeScalar(String query, SqlParameter[] parameters = null)
    {
        using (var cmd = new SqlCommand(query, SingletonDataConnection.Instance))
        {
            if (parameters != null && parameters.Length > 0)
            {
                cmd.Parameters.AddRange(parameters);
            }
            return cmd.ExecuteScalar();
        }
    }
	
    public SqlDataReader executeProcedure(){
		
        reader = command.ExecuteReader();

        return reader;
    }

    public void setProcedure(string procName)
    {
        command = new SqlCommand(procName, SingletonDataConnection.Instance);
        command.CommandType = System.Data.CommandType.StoredProcedure;
    }
  
    public void Dispose()
    {
        if (reader != null && !reader.IsClosed)
        {
            reader.Close();
        }
        if (command != null)
        {
            command.Dispose();
        }
    }

}
