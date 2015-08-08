using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

/// <summary>
/// Manages the connections to the DataBase
/// </summary>
public class DatabaseManager
{
    public SqlConnection dbCon;
    public DatabaseManager()
	{
        string conStr = WebConfigurationManager.ConnectionStrings["dbConString"].ConnectionString;
        dbCon = new SqlConnection(conStr);
	}

    public SqlCommand GetCommand(string commandText)
    {
        SqlCommand command = new SqlCommand(commandText);
        command.Connection = dbCon;
        return command;
    }

    /// <summary>
    /// Gets the DataSet to the corresponding Query
    /// </summary>
    /// <param name="SqlQuery">The Query String for the required data</param>
    /// <returns></returns>
    public DataSet GetDataSet(string SqlQuery)
    {
        DataSet ds = null;
        try
        {
            using (SqlCommand command = GetCommand(SqlQuery))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(command))
                {
                    ds = new DataSet();
                    sda.Fill(ds);
                }
            }
        }
        catch { }
        return ds;
    }

    public DataSet GetUpdatedData()
    {
        DataSet ds = null;
        ds = GetDataSet("SELECT CompanyName FROM MainTable");
        return ds;
    }

}