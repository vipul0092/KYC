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

public partial class RateComment : System.Web.UI.UserControl
{
    public int upvotes;
    public int downvotes;
    public int commentID;

    public string setVar;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public void setUpDownRating(int up, int down)
    {
        rateCommentTable.Rows[0].Cells[1].InnerText = up.ToString();
        rateCommentTable.Rows[0].Cells[3].InnerText = down.ToString();
        upvotes = up; downvotes = down;
    }

    public void setCId(int cId)
    { comment.InnerHtml = cId.ToString(); }

    /// <summary>
    /// Method that updates the DataBase when an "Up" or "Down" button is pressed on the Review page
    /// </summary>
    /// <param name="pressedButton">The button pressed on the review page</param>
    /// <param name="upvotes">Number of current upvotes</param>
    /// <param name="downvotes">Number of current downvotes</param>
    /// <param name="reviewID">Review ID of the shown review</param>
    /// <returns>true if DB update was successful, false otherwise</returns>
    string updateDB(string input)
    {
        string pressedButton = input.Split(',')[0]; string reviewID = input.Split(',')[1];
        string res = "true"; string updQuery; DatabaseManager db = new DatabaseManager(); SqlCommand updCommand;
        HttpCookie cookie = Request.Cookies["CommentVoted"]; int upvotes, downvotes, score;
        bool done = true; DataSet ds;

        if (cookie != null)
        {
            if (cookie[reviewID] != null)
            { res = "done"; }
            else
            {
                updQuery = "UPDATE Reviews SET ";
                updQuery += "Upvotes=@upvotes, Downvotes=@downvotes, Score=@score WHERE Id=" + reviewID;
                updCommand = db.GetCommand(updQuery);

                lock (db)
                {
                    ds = db.GetDataSet("SELECT Id, Upvotes, Downvotes, Score FROM Reviews WHERE Reviews.Id=" + reviewID);
                    upvotes = (int)ds.Tables[0].Rows[0]["Upvotes"]; score = (int)ds.Tables[0].Rows[0]["Score"];
                    downvotes = (int)ds.Tables[0].Rows[0]["Downvotes"];
                    if (pressedButton == "up")
                    { upvotes++; score++; }
                    else
                    { downvotes++; score--; }


                    updCommand.Parameters.AddWithValue("upvotes", upvotes);
                    updCommand.Parameters.AddWithValue("downvotes", downvotes);
                    updCommand.Parameters.AddWithValue("score", score);

                    try
                    {
                        db.dbCon.Open();
                        updCommand.ExecuteNonQuery();
                    }
                    catch
                    {
                        done = false;
                    }
                    db.dbCon.Close();
                }
                if (done)
                {
                }
                else
                    res = "false";
            }
        }
        else
        {
            HttpCookie _cookie = new HttpCookie("CommentVoted");
            updQuery = "UPDATE Reviews SET ";
            updQuery += "Upvotes=@upvotes, Downvotes=@downvotes, Score=@score WHERE Id=" + reviewID;
            updCommand = db.GetCommand(updQuery);

            lock (db)
            {
                ds = db.GetDataSet("SELECT Id, Upvotes, Downvotes, Score FROM Reviews WHERE Reviews.Id=" + reviewID);
                upvotes = (int)ds.Tables[0].Rows[0]["Upvotes"]; score = (int)ds.Tables[0].Rows[0]["Score"];
                downvotes = (int)ds.Tables[0].Rows[0]["Downvotes"];
                if (pressedButton == "up")
                { upvotes++; score++; }
                else
                { downvotes++; score--; }


                updCommand.Parameters.AddWithValue("upvotes", upvotes);
                updCommand.Parameters.AddWithValue("downvotes", downvotes);
                updCommand.Parameters.AddWithValue("score", score);

                try
                {
                    db.dbCon.Open();
                    updCommand.ExecuteNonQuery();
                }
                catch
                {
                    done = false;
                }
            }
            if (done)
            {
            }
            else
                res = "false";
        }
        var retobj = res;
        return retobj;
    }
    
}