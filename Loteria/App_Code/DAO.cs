/*
 * User: ayee
 * Date: 12/12/2017
 * Time: 2:09 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Data.SqlClient;
using System.Data.Common;
using Loteria;

/// <summary>
/// Data Access Object
/// Used to connect the queries and procedures to the database execution.
/// </summary>
public abstract class DAO<T>
{


	protected SqlCommand command;
	
	protected SqlDataReader reader;
    private SqlConnection sqlConnection;

    private string procedureName;

    public DAO()
	{
		//this.dataConnection = sqlConnection;
	}

    //public abstract void executeSQL(T objeto, String procedimiento, int opcion);
    public SqlDataReader executeQuery(String query){
		command = new SqlCommand(query, SingletonDataConnection.Instance);

        reader = command.ExecuteReader();
		
		return reader;
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
  
}
