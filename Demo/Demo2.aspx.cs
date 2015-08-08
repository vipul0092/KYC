using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.HtmlControls;
using KYClib;

public partial class Demo_Demo2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Submit_ServerClick(object sender, EventArgs e)
    {
        result.InnerText = "";
        result.InnerText = "The Term(s) searched is(are) " + Search.Value + ".";        
    }
    protected void RadioButton3_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton3.Checked == true)
        { RadioButton2.Checked = RadioButton1.Checked = false; }
    }
    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton2.Checked == true)
        { RadioButton1.Checked = RadioButton3.Checked = false; }
    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton1.Checked == true)
        { RadioButton2.Checked = RadioButton3.Checked = false; }
    }
    
    [System.Web.Services.WebMethod]
    public string GetCompanyDetail() {

        string query = "SELECT CompanyName FROM MainTable WHERE MainTable.CompanyName LIKE '" + Search.Value + "%'";
        SqlCommand cmd = new SqlCommand(query);
        return GetData(cmd).GetXml();
    }

    private DataSet GetData(SqlCommand cmd)
    {
        string connString = WebConfigurationManager.ConnectionStrings["dbConString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            { cmd.Connection = con;
            sda.SelectCommand = cmd;
            using (DataSet ds = new DataSet())
            {
                sda.Fill(ds);
                return ds;
            }
            }
        }
    }
}

