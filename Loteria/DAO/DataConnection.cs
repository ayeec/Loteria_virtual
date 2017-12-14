/*
 * User: ayee
 * Date: 12/11/2017
 * Time: 5:07 PM
 * 
 */
using System;
using System.Data;
using System.Data.Odbc;
using System.Data.Common;



/// <summary>
/// La clase DataConnection, está desarrollada siguiendo el patrón de diseño Singleton el cual define una sola instancia para la conexion de base de datos
/// </summary>
public sealed class DataConnection
{
    private static volatile DbConnection instance;
    private static readonly object syncRoot = new object();
    //private static DataConnection instance = new DataConnection();
    
    public static DbConnection Instance {
        get {
            if (instance == null)
                {
                    lock (syncRoot)
                    {
                        if (instance == null)
                            instance = new OdbcConnection(ConfigurationManager.ConnectionStrings["MySQLDBLoteria"].ConnectionString);
                    }
                }

                return instance;
        }
    }
    
    private DataConnection()
    {
        try
        {//https://msdn.microsoft.com/en-us/library/system.configuration.configurationmanager(v=vs.110).aspx
            //https://stackoverflow.com/questions/1189364/reading-settings-from-app-config-or-web-config-in-net
            //https://stackoverflow.com/questions/23911245/connection-string-for-mysql-c-in-asp-net
            connection = new  OdbcConnection(ConfigurationManager.ConnectionStrings["MySQLDBLoteria"].ConnectionString );
            //http://csharp.net-informations.com/data-providers/csharp-sql-server-connection.htm
            
                connection.Open();
                /*using(OdbcCommand command = new OdbcCommand("SELECT * FROM tablename", connection))
                using(OdbcDataReader dr = command.ExecuteReader())
                {
                    while(dr.Read())
                        Response.Write(dr["name"].ToString() + "<br>");
                    dr.Close();
                }
                connection.Close();*/
            
        }
        catch(Exception ex)
        {
            Response.Write("An error occurred, can not open connection: " + ex.Message);
        }
    }

}
