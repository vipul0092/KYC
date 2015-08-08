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

public partial class Companies : System.Web.UI.Page
{
    string selectedLetter = "";
    public string like_message;

    void emptyTables()
    {
        for (int i = 1; i < companyNameRating.Rows.Count; i++)
        { companyNameRating.Rows[i].Cells[0].InnerHtml=""; }
        for (int i = 0; i < numLinksTable.Rows[0].Cells.Count; i++)
        { numLinksTable.Rows[0].Cells[i].InnerHtml = ""; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            Bind();
            
            if (Request.QueryString["letter"] != null || Request["spl"] != null)
            {
                DatabaseManager db = new DatabaseManager(); DataSet ds; string startLetter ="";
                if (Request.QueryString["letter"] != null)
                {
                    startLetter = selectedLetter = Request.QueryString["letter"];
                    ds = db.GetDataSet("SELECT CompanyName, CompanyId, CompanyRId, AverageRating  FROM MainTable, CompanyRatings WHERE MainTable.CompanyId = CompanyRatings.CompanyRId AND MainTable.CompanyName LIKE '" + startLetter + "%'");
                    alphabets.Rows[0].Cells[startLetter[0] - 65].Attributes["class"] = "alphacol , centerAlign , selected";
                }
                else
                {   string query = "SELECT CompanyName, CompanyId, CompanyRId, NumReviews, AverageRating FROM MainTable, CompanyRatings WHERE MainTable.CompanyId = CompanyRatings.CompanyRId ORDER BY ";
                if (Request["spl"] == "alp") { query += "CompanyName"; RadioButton1.Checked = true; orderByRes.Attributes["title"] = "Clear Alphabetically ordered search results"; }
                else if (Request["spl"] == "rat") { query += "AverageRating DESC"; RadioButton2.Checked = true; orderByRes.Attributes["title"] = "Clear search results ordered by Average Rating"; }
                else if (Request["spl"] == "nrat") { query += "NumReviews DESC"; RadioButton3.Checked = true; orderByRes.Attributes["title"] = "Clear search results ordered by No. of ratings"; }
                    ds = db.GetDataSet(query); alphabets.Visible = false; orderByRes.InnerText = "Clear Results";
                    emptyTables(); orderByRes.Attributes["href"] = "Companies.aspx";
                }
                #region Company & Rating Table Code
                if (ds.Tables[0].Rows.Count != 0)
                {
                    int i, j;
                    Rating10[] ratCol = new Rating10[10] { ratingCtrl1, ratingCtrl2, ratingCtrl3, ratingCtrl4, ratingCtrl5, ratingCtrl6, ratingCtrl7, ratingCtrl8, ratingCtrl9, ratingCtrl10 };

                    if (Request.QueryString["page"] != null)
                    {
                        int pageNum = int.Parse(Request.QueryString["page"]); int maxPages = (ds.Tables[0].Rows.Count / 10) + 1;
                        numLinksTable.Rows[0].Cells[pageNum + 1].Attributes["class"] = "numCol , centerAlign , selected";

                        int times = ds.Tables[0].Rows.Count - ((pageNum - 1) * 10);
                        if (times >= 10) times = 10;

                        for (i = 0; i < times; i++)
                        {
                            companyNameRating.Rows[i + 1].Cells[0].InnerHtml = "<a title=\"Click here to see detailed ratings for " + ds.Tables[0].Rows[((pageNum - 1) * 10) + i]["CompanyName"] + "\" class = \"nodecor , compLinks\" href=\"CompanyDetails.aspx?id=" + ds.Tables[0].Rows[((pageNum - 1) * 10) + i]["CompanyID"] + "\">" + ds.Tables[0].Rows[((pageNum - 1) * 10) + i]["CompanyName"] + "</a>";
                            int rating = (int)ds.Tables[0].Rows[((pageNum - 1) * 10) + i]["AverageRating"];
                            ratCol[i].Visible = true; ratCol[i].setRating(rating); ratCol[i].disable();
                        }

                        for (j = 0; j <= maxPages; j++)
                        {
                            if(Request["spl"] != null)
                            {    numLinksTable.Rows[0].Cells[j + 2].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=" + (j + 1).ToString() + "&maxpages=" + maxPages + "\">" + (j + 1).ToString() + "</a>";}
                            else
                                numLinksTable.Rows[0].Cells[j + 2].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=" + (j + 1).ToString() + "&maxpages=" + maxPages + "\">" + (j + 1).ToString() + "</a>";
                        }

                        if(Request["spl"] != null)
                            numLinksTable.Rows[0].Cells[0].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=1" + "&maxpages=" + maxPages + "\"><<</a>";
                        else
                            numLinksTable.Rows[0].Cells[0].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=1" + "&maxpages=" + maxPages + "\"><<</a>";
                        
                        if(Request["spl"] != null)
                            numLinksTable.Rows[0].Cells[j + 2].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=" + maxPages + "&maxpages=" + maxPages + "\">>></a>";
                        else
                            numLinksTable.Rows[0].Cells[j + 2].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=" + maxPages + "&maxpages=" + maxPages + "\">>></a>";

                        if (pageNum != 1)
                        {
                            if(Request["spl"] != null)
                                numLinksTable.Rows[0].Cells[1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=" + (pageNum - 1) + "&maxpages=" + maxPages + "\"><</a>";
                            else
                                numLinksTable.Rows[0].Cells[1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=" + (pageNum - 1) + "&maxpages=" + maxPages + "\"><</a>";
                        }
                        else
                        {
                            if(Request["spl"] != null)
                                numLinksTable.Rows[0].Cells[1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=1" + "&maxpages=" + maxPages + "\"><</a>";
                            else
                                numLinksTable.Rows[0].Cells[1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=1" + "&maxpages=" + maxPages + "\"><</a>";
                        }

                        if (pageNum == maxPages)
                        {
                            if(Request["spl"] != null)
                                numLinksTable.Rows[0].Cells[j + 1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=" + maxPages + "&maxpages=" + maxPages + "\">></a>";
                            else
                                numLinksTable.Rows[0].Cells[j + 1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=" + maxPages + "&maxpages=" + maxPages + "\">></a>";
                        }
                        else
                        {
                            if(Request["spl"] != null)
                                numLinksTable.Rows[0].Cells[j + 1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?spl=" + Request["spl"] + "&page=" + (pageNum + 1) + "&maxpages=" + maxPages + "\">></a>";
                            else
                                numLinksTable.Rows[0].Cells[j + 1].InnerHtml = "<a class = \"nodecor\" href=\"Companies.aspx?letter=" + startLetter + "&page=" + (pageNum + 1) + "&maxpages=" + maxPages + "\">></a>";
                        }

                    }
                }
                #endregion
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

    protected void RadioButton3_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton3.Checked == true)
        { 
            RadioButton2.Checked = RadioButton1.Checked = false;
            if (Request["spl"] != null)
            {
                if (Request["spl"] == "nrat")
                { orderByRes.InnerText = "Clear Results"; orderByRes.Attributes["href"] = "Companies.aspx"; orderByRes.Attributes["title"] = "Clear search results ordered by No. of Ratings"; }
                else
                { orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=nrat&page=1"; orderByRes.Attributes["title"] = "Get Search Results ordered by No. of ratings"; }
            }
            else
            {
                orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=nrat&page=1"; orderByRes.Attributes["title"] = "Get Search Results ordered by No. of ratings";
            }    
        }
    }
    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton2.Checked == true)
        { 
            RadioButton1.Checked = RadioButton3.Checked = false;
            if (Request["spl"] != null)
            {
                if (Request["spl"] == "rat")
                { orderByRes.InnerText = "Clear Results"; orderByRes.Attributes["href"] = "Companies.aspx"; orderByRes.Attributes["title"] = "Clear search results ordered by Average Rating"; }
                else
                { orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=rat&page=1"; orderByRes.Attributes["title"] = "Get Search Results ordered by Average Rating"; }
            }
            else
            {
                orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=rat&page=1"; orderByRes.Attributes["title"] = "Get Search Results ordered by Average Rating";
            }    
        
        }
    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton1.Checked == true)
        { 
            RadioButton2.Checked = RadioButton3.Checked = false;
            if (Request["spl"] != null)
            {
                if (Request["spl"] == "alp")
                { orderByRes.InnerText = "Clear Results"; orderByRes.Attributes["href"] = "Companies.aspx"; orderByRes.Attributes["title"] = "Clear Alphabetical Search Results from the page"; }
                else
                { orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=alp&page=1"; orderByRes.Attributes["title"] = "Get Alphabetical Search Results"; }
            }
            else
            {
                orderByRes.InnerText = "Get Results"; orderByRes.Attributes["href"] = "Companies.aspx?spl=alp&page=1"; orderByRes.Attributes["title"] = "Get Alphabetical Search Results";
            }  
        }
    }
    protected void search_ServerClick(object sender, ImageClickEventArgs e)
    {
        if (searchBox.Text != "")
        {
            string company = searchBox.Text;
            DatabaseManager db = new DatabaseManager();
            DataSet ds = db.GetDataSet("SELECT CompanyName, CompanyId FROM MainTable WHERE MainTable.CompanyName='" + company + "'");

            if (ds.Tables[0].Rows.Count != 0)
            {
                Response.Redirect("CompanyDetails.aspx?id=" + ((int)ds.Tables[0].Rows[0]["CompanyId"]).ToString());
            }
            else
            {
                Response.Redirect("Error.aspx?from=company&data=" + company);
            }
        }
    }
}