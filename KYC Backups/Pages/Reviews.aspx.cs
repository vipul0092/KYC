using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.HtmlControls;
using KYClib;
using System.Web.Services;

public partial class View_Reviews : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (Request["id"] != null)
            {
                    int id = int.Parse(Request["id"]);
                    string query = "SELECT Id, CompanyIDRev, ReviewText, Upvotes, Downvotes, DateAdded, CompanyName, CompanyId FROM MainTable, Reviews WHERE MainTable.CompanyId=Reviews.CompanyIDRev AND Reviews.Id=" + id;
                    DatabaseManager db = new DatabaseManager();
                    DataSet ds = db.GetDataSet(query);
                    reviewTopTable.Rows[0].Cells[0].InnerHtml = "Review for " + (string)ds.Tables[0].Rows[0]["CompanyName"];
                    reviewText.Value = ((string)ds.Tables[0].Rows[0]["ReviewText"]).Replace("&apos;","'");
                    commentRate.setUpDownRating((int)ds.Tables[0].Rows[0]["Upvotes"], (int)ds.Tables[0].Rows[0]["Downvotes"]);
                    commentRate.setCId(id);
                    date.InnerText = "Submitted On: " + ((DateTime)ds.Tables[0].Rows[0]["DateAdded"]).Date.ToShortDateString();
            }
            if (Request["page"] != null)
            {
                int pageNum = int.Parse(Request["page"]);
                viewMore.Disabled = true; viewMore.Attributes["class"] = "btnDisable";
                int revId = int.Parse(Request["id"]); DataSet ds;
                DatabaseManager db = new DatabaseManager();
                string query = "SELECT Id, CompanyIDRev FROM Reviews WHERE Reviews.Id=" + revId;
                ds = db.GetDataSet(query);

                int id = (int)ds.Tables[0].Rows[0]["CompanyIDRev"];
                query = "SELECT ReviewText, Id FROM Reviews WHERE Reviews.CompanyIDRev=" + id;
                ds = db.GetDataSet(query); ds.Tables[0].PrimaryKey = new DataColumn[1] { ds.Tables[0].Columns["Id"] };
                FillReviewsTable(ds, revId, pageNum);
            }
            if (Request["mode"] != null)
            {
                viewMore.Visible = false;
            }
        }
    }

    protected void viewMore_ServerClick(object sender, EventArgs e)
    {
        viewMore.Disabled = true; viewMore.Attributes["class"] = "btnDisable";
        int revId = int.Parse(Request["id"]); DataSet ds;
        DatabaseManager db = new DatabaseManager();
        string query = "SELECT Id, CompanyIDRev FROM Reviews WHERE Reviews.Id=" + revId;
        ds = db.GetDataSet(query);

        int id = (int)ds.Tables[0].Rows[0]["CompanyIDRev"];
        query = "SELECT ReviewText, Id FROM Reviews WHERE Reviews.CompanyIDRev=" + id;
        ds = db.GetDataSet(query); ds.Tables[0].PrimaryKey = new DataColumn[1] {ds.Tables[0].Columns["Id"]};
        FillReviewsTable(ds,revId);     
    }

    void FillReviewsTable(DataSet ds, int revId, int pageNum = 1)
    {
        ds.Tables[0].Rows.Remove(ds.Tables[0].Rows.Find(revId));
        int times = ds.Tables[0].Rows.Count; if (times > 7) times = 7;
        int maxPages = (ds.Tables[0].Rows.Count / 7) + 1; int a = 0, j;
        moreRevTable.Visible = true;
        times = ds.Tables[0].Rows.Count - ((pageNum - 1) * 7); if (times > 7) times = 7;
        if (ds.Tables[0].Rows.Count != 0)
        {
            for (a = 0; a < times; a++)
            {
                string rev = ((string)ds.Tables[0].Rows[((pageNum - 1) * 7) + a]["ReviewText"]).Replace("&apos;", "'");
                if (rev.Length <= 30)
                { moreRevTable.Rows[(a)].Cells[0].InnerHtml = rev; }
                else
                {
                    moreRevTable.Rows[(a)].Cells[0].InnerHtml = rev.Substring(0, 30) + "...";
                }
                moreRevTable.Rows[(a)].Cells[0].InnerHtml += "<br/> <a class=\"more\" href=\"../View/Reviews.aspx?id=" + ds.Tables[0].Rows[((pageNum - 1) * 7) + a]["Id"] + "&max=" + maxPages + "&page=" + pageNum + "\">Read More</a>";
                moreRevTable.Rows[(a)].Cells[0].Attributes["class"] = "border , centerAlign";
            }

            for (j = 0; j < maxPages; j++)
            {
                moreRevNum.Rows[0].Cells[j + 2].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=" + (j + 1).ToString() + "&max=" + maxPages + "&id=" + revId + "\">" + (j + 1).ToString() + "</a>";
            }
            moreRevNum.Rows[0].Cells[0].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=1" + "&max=" + maxPages + "&id=" + revId + "\"><<</a>";
            moreRevNum.Rows[0].Cells[maxPages + 3].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=" + maxPages + "&max=" + maxPages + "&id=" + revId + "\">>></a>";
            moreRevNum.Rows[0].Cells[1].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=" + (pageNum - 1) + "&max=" + maxPages + "&id=" + revId + "\"><</a>";
            if (pageNum == maxPages)
                moreRevNum.Rows[0].Cells[maxPages + 2].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=" + maxPages + "&max=" + maxPages + "&id=" + revId + "\">></a>";
            else
                moreRevNum.Rows[0].Cells[maxPages + 2].InnerHtml = "<a class = \"nodecor\" href=\"Reviews.aspx?page=" + (pageNum + 1) + "&max=" + maxPages + "&id=" + revId + "\">></a>";

            for (j = 0; j < maxPages + 4; j++)
                moreRevNum.Rows[0].Cells[j].Attributes["class"] = "numCol , centerAlign";

            moreRevNum.Rows[0].Cells[pageNum + 1].Attributes["class"] = "numCol , centerAlign , selected";
          }
            else
            {
                moreRevTable.Rows[0].Cells[0].InnerHtml = "NO MORE REVIEWS";
                moreRevTable.Rows[0].Cells[0].Attributes["class"] = "centerAlign";
            }
    }
}