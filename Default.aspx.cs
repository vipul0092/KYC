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

public partial class _Default : System.Web.UI.Page
{
    public string like_message;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            Bind();
            string topReviewQuery = "SELECT TOP 4 * FROM Reviews ORDER BY Reviews.CalcRating DESC";
            string topRatedCompanies = "SELECT TOP 4 CompanyRId, AverageRating, CompanyName, CompanyId FROM CompanyRatings, MainTable WHERE CompanyRatings.CompanyRId=MainTable.CompanyId ORDER BY CompanyRatings.AverageRating DESC";
            string recentReviewsQuery = "SELECT TOP 4 ReviewText, Id, DateAdded FROM Reviews ORDER BY DateAdded DESC";

            DatabaseManager db = new DatabaseManager();
            DataSet[] queryRes = new DataSet[3];
            queryRes[0] = db.GetDataSet(topReviewQuery); queryRes[1] = db.GetDataSet(topRatedCompanies);
            queryRes[2] = db.GetDataSet(recentReviewsQuery);
            Rating10[] ratCol = new Rating10[4] {Rating, Rating1, Rating2, Rating3};

            for (int a = 1; a <= queryRes[0].Tables[0].Rows.Count; a++)
            {
                string comment = ((string)queryRes[0].Tables[0].Rows[a-1]["ReviewText"]);
                comment.Replace("&apos;", "'");
                if (comment.Length <= 27)
                  table1in3.Rows[a].Cells[0].InnerHtml = comment;
                else
                  table1in3.Rows[a].Cells[0].InnerHtml = comment.Substring(0, 27) + "...";
                
                table1in3.Rows[a].Cells[0].InnerHtml += "<br/> <a title=\"Read the full comment\" class=\"more\" href=\"../View/Reviews.aspx?id=" + queryRes[0].Tables[0].Rows[a - 1]["Id"] + "\">Read More</a>";
                table1in3.Rows[a].Cells[0].Attributes["class"] = "border";
            }

            for (int a = 1; a <= queryRes[1].Tables[0].Rows.Count; a++)
            {
                table2in3.Rows[(2 * a) - 1].Cells[0].InnerHtml = "<a title=\"Click here to see detailed ratings for " + (string)queryRes[1].Tables[0].Rows[a - 1]["CompanyName"] + "\" class=\"sideLinks , links\" href=\"CompanyDetails.aspx?id=" + queryRes[1].Tables[0].Rows[a - 1]["CompanyId"] + "\">" + (string)queryRes[1].Tables[0].Rows[a - 1]["CompanyName"] + "</a>";
                ratCol[a - 1].Visible = true; ratCol[a - 1].setRating((int)queryRes[1].Tables[0].Rows[a - 1]["AverageRating"]); ratCol[a - 1].disable(1);
            }

            for (int a = 1; a <= queryRes[2].Tables[0].Rows.Count; a++)
            {
                string comment = ((string)queryRes[2].Tables[0].Rows[a-1]["ReviewText"]);
                comment.Replace("&apos;", "'");
                if (comment.Length <= 27)
                    table3in3.Rows[a].Cells[0].InnerHtml = comment;
                else
                    table3in3.Rows[a].Cells[0].InnerHtml = comment.Substring(0, 27) + "...";

                table3in3.Rows[a].Cells[0].InnerHtml += "<br/> <a title=\"Read the full comment\" class=\"more\" href=\"../View/Reviews.aspx?id=" + queryRes[2].Tables[0].Rows[a - 1]["Id"] + "\">Read More</a>";
                table3in3.Rows[a].Cells[0].Attributes["class"] = "border";
            }

        }
        like_message = Get_Message();  
    }

    public void Bind()
    {
        DatabaseManager db = new DatabaseManager();
        if (Cache["CompanyList"] != null)
        {
            lock (Cache["CompanyList"])
            { Cache["CompanyList"] = db.GetUpdatedData(); }
        }
        else
        {
            Cache["CompanyList"] = db.GetUpdatedData();
        }

    }

    public string Get_Message()
    {
        string str = "";
        DataTable dt = Get_source();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            str += "arrList[intIndex++] = \"" + dt.Rows[i]["message"].ToString() + "\";\n";
        }
        return str;
    }

    public DataTable Get_source()
    {
        DataTable dt = new DataTable(); DataSet ds;
        DataRow dr;
        if (Cache["CompanyList"] != null)
            ds = (DataSet)Cache["CompanyList"];
        else
        { Bind(); ds = (DataSet)Cache["CompanyList"]; }

        dt.Columns.Add(new DataColumn("message"));
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            dr = dt.NewRow();
            dr["message"] = ds.Tables[0].Rows[i].Field<string>(0);
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void search_ServerClick(object sender, ImageClickEventArgs e)
    {
        if (searchBox.Value != "")
        {
            string company = searchBox.Value;
            DatabaseManager db = new DatabaseManager();
            DataSet ds = db.GetDataSet("SELECT CompanyName, CompanyId FROM MainTable WHERE MainTable.CompanyName='" + company + "'");

            if (ds.Tables[0].Rows.Count != 0)
            {
                Response.Redirect("CompanyDetails.aspx?id=" + ((int)ds.Tables[0].Rows[0]["CompanyId"]).ToString());
            }
            else
            {
                Response.Redirect("Error.aspx?from=main&data=" + company);
            }
        }
    }
}