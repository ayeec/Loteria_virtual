/*
 * User: ayee
 * Date: 12/11/2017
 * Time: 5:07 PM
 * 
 * Refactored for proper singleton pattern and connection management
 */
using System;
using System.Data;
using System.Data.Common;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// La clase SingletonDataConnection, está desarrollada siguiendo el patrón de diseño Singleton 
/// el cual define una sola instancia para la conexion de base de datos
/// </summary>
public sealed class SingletonDataConnection : IDisposable
{
    private static volatile SqlConnection _connection;
    private static readonly object _syncRoot = new object();
    
    private SingletonDataConnection() { }

    public static SqlConnection Instance 
    {
        get
        {
            if (_connection == null)
            {
                lock (_syncRoot)
                {
                    if (_connection == null)
                    {
                        _connection = new SqlConnection(
                            ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                    }
                }
            }
            
            // Open connection if closed
            if (_connection.State != ConnectionState.Open)
            {
                _connection.Open();
            }
            
            return _connection;
        }
    }

    public static void CloseConnection()
    {
        if (_connection != null)
        {
            if (_connection.State == ConnectionState.Open)
            {
                _connection.Close();
            }
            _connection = null;
        }
    }

    public void Dispose()
    {
        CloseConnection();
    }
}

