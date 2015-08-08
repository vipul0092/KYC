using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class Demo_DB_Demo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        //Import the connection string from Web.config file
        string connectionString = WebConfigurationManager.ConnectionStrings["dbConString"].ConnectionString;

        //Declare a connection to the your Database
        SqlConnection dbCon = new SqlConnection(connectionString);

        SqlCommand command = new SqlCommand(); //Declare a SQL Command
        command.Connection = dbCon; //Give the command a connection to query upon

        string startLetter = "A";
        //The actual SQL command syntax
        command.CommandText = "SELECT CompanyName, CompanyId, CompanyRId, AverageRating  FROM MainTable, CompanyRatings WHERE MainTable.CompanyId = CompanyRatings.CompanyRId AND MainTable.CompanyName LIKE '" + startLetter + "%'";
        SqlDataReader reader;

        TableRow tempRow = new TableRow();
        tempRow.CssClass = "centerAlign";
        for (int cellNum = 0; cellNum < 2; cellNum++)
        {
            TableCell tempCell = new TableCell();
            tempCell.CssClass = "centerAlign";
            if (cellNum % 2 == 0)
                tempCell.Text = "Name Of Company";
            else
                tempCell.Text = "Average Rating";
            tempRow.Cells.Add(tempCell);
        }
        Table1.Rows.Add(tempRow);

        try
        {
            using (dbCon)
            {
                dbCon.Open(); //Open the Database
                reader = command.ExecuteReader(); //Fetch the results of the query from the Database into the SqlDataReader object.

                for (int i = 0; i < 6; i++)
                {
                    reader.Read(); //Read an individual row from the collections of rows obtained.
                    tempRow = new TableRow();
                    tempRow.CssClass = "centerAlign";
                    for (int cellNum = 0; cellNum < 2; cellNum++)
                    {
                        TableCell tempCell = new TableCell();
                        tempCell.CssClass = "centerAlign";
                        if (cellNum % 2 == 0)
                            tempCell.Text = (string)reader["CompanyName"]; //Here we can obtain the data corresponding to the different columns in our database
                        else
                            tempCell.Text = ((int)reader["AverageRating"]).ToString();
                        tempRow.Cells.Add(tempCell);
                    }
                    Table1.Rows.Add(tempRow);   
                }
                reader.Close();
            }
        }
        catch
        {
        }
        finally
        {
            
            dbCon.Close();
        } 
    }
}