/*
 * User: ayee
 * Date: 12/12/2017
 * Time: 2:09 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Data.Odbc;
using System.Data.Common;

/// <summary>
/// Description of Class1.
/// </summary>
public abstract class DAO<T>
{

	protected DataConnection dataConnection;
	protected OdbcCommand command;
	
	protected OdbcDataReader reader;

	public DAO(DataConnection dataConection)
	{
		this.dataConnection = dataConection;
	}
  
	//public abstract void executeSQL(T objeto, String procedimiento, int opcion);
	public DbDataReader executeQuery(String query){
		command = new OdbcCommand(query);
			reader = command.ExecuteReader();
		
		/*if(reader.HasRows)
		{
			reader.
		}
		else
        {
            Console.WriteLine("No rows found.");
        }*/
		return reader;
	}
	public DbDataReader executeProcedure(String procedimiento){
		return executeQuery("call "+procedimiento);
		
	}
  
}
