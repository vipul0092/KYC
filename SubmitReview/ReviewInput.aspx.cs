using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using KYClib;

public partial class SubmitReview_Default : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (Session["raterinfo"] != null)
            {
                cName.InnerHtml = "<b>" + ((RaterInfo)Session["raterinfo"]).employer + "</b>";
                DatabaseManager db = new DatabaseManager();
                SqlCommand com = db.GetCommand("SELECT CompanyName, CompanyId FROM MainTable WHERE MainTable.CompanyName='" + ((RaterInfo)Session["raterinfo"]).employer + "'");
                db.dbCon.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    string companyId = ((int)reader["CompanyId"]).ToString();
                    cLogo.Attributes["src"] = "../Images/Logos/logo_" + companyId + ".png";
                }
                reader.Close();
                db.dbCon.Close();
            }
            else
            { Response.Redirect("../Error.aspx?from=revInput&data=expired"); }


            if (Request["error"] == "1" && Session["ratings"] != null)
            {
                int[] ratings = (int[])Session["ratings"];
                HtmlTableCell[] celCol = new HtmlTableCell[12] { td, Td1, Td2, Td3, Td4, Td5, Td6, Td7, Td8, Td9, Td10, Td11 };
                Rating10[] ratCol = new Rating10[12] { rating1, rating2, rating3, rating4, rating5, rating6, rating7, rating8, rating9, rating10, rating11, rating12 };
                for (int i = 0; i < 12; i++)
                {
                    ratCol[i].setRating(ratings[i]);
                    if (ratings[i] == 0)
                        celCol[i].InnerText = "* - REQUIRED";
                }
                Session["ratings"] = null;
            }
        }
    }
    
    protected void submitButton_Click(object sender, EventArgs e)
    {
        int[] savedRating = new int[12];
        bool error = false;
        HtmlTableCell[] celCol = new HtmlTableCell[12] {td, Td1, Td2, Td3, Td4, Td5, Td6, Td7, Td8, Td9, Td10, Td11};
        Rating10[] ratCol = new Rating10[12]{ rating1, rating2, rating3, rating4, rating5, rating6, rating7, rating8, rating9, rating10, rating11, rating12};
        for (int i = 0; i < 12; i++)
        { savedRating[i] = ratCol[i].GetRating(); if (savedRating[i] == 0) error = true; }

        Session["ratings"] = savedRating;

        if (error)
            Response.Redirect("ReviewInput.aspx?error=1");
        else //Database Updation Code
        {
            if (Session["raterinfo"] != null)
            {
                string updateQuery, insertQuery;
                RaterInfo info = (RaterInfo)Session["raterinfo"];
                string company = info.employer;
                string checkQuery = "SELECT CompanyName,CompanyId FROM MainTable WHERE MainTable.CompanyName='" + company+ "'";
                DatabaseManager db = new DatabaseManager();
                Application.Lock(); //Lock so that Data is updated properly
                DataSet ds = db.GetDataSet(checkQuery);

                if (ds.Tables[0].Rows.Count != 0) //If the company already exists in the DB.
                {
                    //First Get all the already existing data for the company in DB
                    int id = (int)ds.Tables[0].Rows[0]["CompanyId"];
                    string obtainDataQuery = "SELECT * FROM MainTable, CompanyRatings WHERE MainTable.CompanyId=CompanyRatings.CompanyRId AND MainTable.CompanyName='" + company + "'";
                    ds = db.GetDataSet(obtainDataQuery);

                    // ------- Update Command Building Code for CompanyRatings Table --------
                    int[] updRes = GetUpdatedData(ds, savedRating);

                    updateQuery = "UPDATE CompanyRatings SET ";
                    updateQuery += StringCollection.CRCols[0] + "=@" + StringCollection.CRCols[0] + "," + StringCollection.CRCols[1] + "=@" + StringCollection.CRCols[1] + "," + StringCollection.CRCols[2] + "=@" + StringCollection.CRCols[2] + ",";
                    updateQuery += StringCollection.CRCols[3] + "=@" + StringCollection.CRCols[3] + "," + StringCollection.CRCols[4] + "=@" + StringCollection.CRCols[4] + "," + StringCollection.CRCols[5] + "=@" + StringCollection.CRCols[5] + ",";
                    updateQuery += StringCollection.CRCols[6] + "=@" + StringCollection.CRCols[6] + "," + StringCollection.CRCols[7] + "=@" + StringCollection.CRCols[7] + "," + StringCollection.CRCols[8] + "=@" + StringCollection.CRCols[8] + ",";
                    updateQuery += StringCollection.CRCols[9] + "=@" + StringCollection.CRCols[9] + "," + StringCollection.CRCols[10] + "=@" + StringCollection.CRCols[10] + "," + StringCollection.CRCols[11] + "=@" + StringCollection.CRCols[11] + ",";
                    updateQuery += StringCollection.CRCols[12] + "=@" + StringCollection.CRCols[12] + "," + StringCollection.CRCols[13] + "=@" + StringCollection.CRCols[13];
                    updateQuery += " WHERE CompanyRId=" + id;
                    SqlCommand upCom = db.GetCommand(updateQuery);

                    for (int j = 0; j < 14; j++)
                    { upCom.Parameters.AddWithValue(StringCollection.CRCols[j], updRes[j]); }
                    //------------------------------------------------------------------------

                    // ------ Insert Command Building Code for Reviews Table ----------
                    SqlCommand inCom=null;
                    if(comments.Value != ""){
                    insertQuery = "INSERT INTO Reviews (";
                    insertQuery += "ReviewText, CalcRating, CompanyIDRev, Upvotes, Downvotes, Score, DateAdded) ";
                    insertQuery += "VALUES ('" + comments.Value + "', 6, " + id + ", 0, 0, 0, GETDATE())";
                    inCom = db.GetCommand(insertQuery);
                    }
                    //-------------------------------------------------------------------

                    bool res = true;
                    try
                    {
                        db.dbCon.Open();
                        upCom.ExecuteNonQuery();
                        if(inCom != null)
                            inCom.ExecuteNonQuery();
                    }
                    catch
                    {
                        res = false;
                    }
                    Application.UnLock();
                    db.dbCon.Close();

                    if (res)
                    {   ds = db.GetUpdatedData();
                        if (Cache["CompanyList"] != null)
                        { lock (Cache["CompanyList"]) { Cache["CompanyList"] = ds; } }
                        else
                            Cache["CompanyList"] = ds;
                        Response.Redirect("../View/Done.aspx?from=uc"); 
                    }
                    else
                        Response.Redirect("../Error.aspx?from=revInput&data=dbUpdError&c=" + company);

                }
                else //If a new company is being added.
                {
                    //------- Insert Command Building Code in MainTable ----------
                    insertQuery = "INSERT INTO MainTable (";
                    insertQuery += "CompanyName, Industry) ";
                    insertQuery += "VALUES ('" + company + "', 'Demo Industry' )";
                    SqlCommand inCom = db.GetCommand(insertQuery); bool res = true;
                    //------------------------------------------------------------

                    try
                    { db.dbCon.Open();
                      inCom.ExecuteNonQuery();
                    } 
                    catch
                    { res = false; }
                    db.dbCon.Close();

                    if (!res)
                    {
                        Application.UnLock();
                        Response.Redirect("../Error.aspx?from=revInput&data=dbUpdError&c="+company);
                    }
                    else
                    {
                        string getNewIdQuery = "SELECT CompanyId, CompanyName FROM MainTable WHERE MainTable.CompanyName='" + company +"'";
                        DataSet id = db.GetDataSet(getNewIdQuery);
                        int newId = (int)id.Tables[0].Rows[0]["CompanyId"]; int avgRating = 0;

                        //------------- Insert Command Building Code for CompanyRatings Table -----------
                        insertQuery = "INSERT INTO CompanyRatings ( CompanyRId, ";
                        for (int i = 0; i < 14; i++)
                        { insertQuery += StringCollection.CRCols[i]; if (i != 13) insertQuery += ", "; }
                        insertQuery += " ) ";
                        insertQuery += "VALUES (" + newId + ", ";
                        for (int i = 0; i < 12; i++)
                        { insertQuery += (savedRating[i] + ", "); avgRating += savedRating[i]; }
                        avgRating /= 12;
                        insertQuery += "1, " + avgRating + ")";
                        SqlCommand inComCR = db.GetCommand(insertQuery); bool done = true;
                        //--------------------------------------------------------------------------------

                        //------------- Insert Command Building Code for Reviews Table ------------------
                        SqlCommand inComRev = null; string _insertQuery;
                        if (comments.Value != "")
                        {
                            comments.Value=comments.Value.Replace("'", "&apos;");
                            _insertQuery = "INSERT INTO Reviews (";
                            _insertQuery += "ReviewText, CalcRating, CompanyIDRev, Upvotes, Downvotes, Score, DateAdded) ";
                            _insertQuery += "VALUES ('" + comments.Value + "', 6, " + newId + ", 0, 0, 0, GETDATE())";
                            inComRev = db.GetCommand(_insertQuery);
                        }
                        //--------------------------------------------------------------------------------
                        int added = -1;
                        try
                        {
                            db.dbCon.Open();
                            added=inComCR.ExecuteNonQuery();
                            if (inComRev != null)
                                inComRev.ExecuteNonQuery();

                        }
                        catch
                        {
                            done = false; string delQuery; SqlCommand delCom;
                            if (added > 0)
                            {
                                delQuery = "DELETE FROM CompanyRatings WHERE CompanyRId=" + newId; delCom = db.GetCommand(delQuery);
                                delCom.ExecuteNonQuery();
                            }
                            delQuery = "DELETE FROM MainTable WHERE CompanyId=" + newId;
                            delCom = db.GetCommand(delQuery);
                            delCom.ExecuteNonQuery();

                            
                        }

                        Application.UnLock();
                        db.dbCon.Close();

                        if (done)
                        {
                            ds = db.GetUpdatedData();
                            if (Cache["CompanyList"] != null)
                            { lock (Cache["CompanyList"]) { Cache["CompanyList"] = ds; } }
                            else
                                Cache["CompanyList"] = ds;
                            Response.Redirect("../View/Done.aspx?from=uc");
                        }
                        else
                        { Response.Redirect("../Error.aspx?from=revInput&data=dbUpdError&c=" + company); }
                    }
                }
            }
            else
            { Response.Redirect("../Error.aspx?from=revInput&data=expired"); }
        }
    }

    int[] GetUpdatedData(DataSet old, int[] newData)
    {
        int[] retData = new int[14]; int avg = 0;
        int[] oldData = new int[12]; int nRev = (int)old.Tables[0].Rows[0]["NumReviews"];
        for (int i = 0; i < 12; i++)
        { oldData[i] = (int)old.Tables[0].Rows[0][StringCollection.CRCols[i]]; }

        for (int a = 0; a < 12; a++)
        { retData[a] = ((oldData[a] * nRev) + newData[a]) / (nRev + 1); avg += retData[a]; }
        avg /= 12;

        retData[12] = nRev + 1; retData[13] = avg;
        return retData;
    }
}