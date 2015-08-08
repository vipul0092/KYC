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
using System.Collections.Specialized;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public bool HelloWorld(string name) {
        if (name != "Vipul")
            return false;
        else
            return true;
    }

    [WebMethod]
    public string[] sendObject(string name)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies["CommentVoted"];
        cookie["9"] = "done";
        HttpContext.Current.Response.Cookies.Add(cookie);
        if (name != "Vipul")
            return (new string[2] { "Hello", " You didn't send Vipul" });
        else
            return (new string[2] { "Hello", " You sent Vipul" });

    }

    [WebMethod]
    public string updateDB(string input)
    {
        string pressedButton = input.Split(',')[1]; string reviewID = input.Split(',')[0];
        string res = "true"; string updQuery; DatabaseManager db = new DatabaseManager(); SqlCommand updCommand;
        int upvotes, downvotes, score; HttpCookie cookie = HttpContext.Current.Request.Cookies["CommentVoted"];
        bool done = true; DataSet ds;

        if (cookie != null)
        {   if(cookie[reviewID] != null) { res = "done"; return res; }     }
        else
        { cookie = new HttpCookie("CommentVoted");}
         

        updQuery = "UPDATE Reviews SET ";
        updQuery += "Upvotes=@upvotes, Downvotes=@downvotes, Score=@score WHERE Id=" + reviewID;
        updCommand = db.GetCommand(updQuery); cookie.Expires = DateTime.Now.AddYears(1);
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
            { db.dbCon.Open(); updCommand.ExecuteNonQuery(); }
            catch
            { done = false; }
            db.dbCon.Close();            
        }
        if (done)
        { cookie[reviewID] = "done"; HttpContext.Current.Response.Cookies.Add(cookie); }
        else
          res = "false";

        return res;
    }
    
}
