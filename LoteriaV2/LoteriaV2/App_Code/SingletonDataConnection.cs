using System;
using System.Configuration;
using System.Data.SqlClient;

public static class SingletonDataConnection
{
    public static SqlConnection CreateConnection()
    {
        ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["DefaultConnection"];
        if (settings == null || String.IsNullOrWhiteSpace(settings.ConnectionString))
        {
            throw new ConfigurationErrorsException(
                "The DefaultConnection connection string is missing or empty.");
        }

        return new SqlConnection(settings.ConnectionString);
    }
}
