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
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// La clase SingletonDataConnection, está desarrollada siguiendo el patrón de diseño Singleton 
/// el cual define una sola instancia para la conexion de base de datos
/// </summary>
public sealed class SingletonDataConnection
{
    private static  DbConnection conn;
    private static volatile SingletonDataConnection instance;
    private static object syncRoot = new Object();

    public static SqlConnection Instance {
        get
        {
            if (conn == null)
            {
                lock (syncRoot)
                {
                    if (conn == null)
                        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLServer_loteria"].ConnectionString);
                        SingletonDataConnection.Instance.Open();
                }
            }

            return conn as SqlConnection;
        }
    }

}
