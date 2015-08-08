using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            string page = Request.QueryString["from"];
            if (page == "company" || page=="main")
            {
                string data = Request.QueryString["data"]; errBorder.Visible = errorMessage.Visible = false; errorCompany.Visible = true;
                errorCompany.Rows[0].Cells[0].InnerHtml = "Sorry! the company name <b>" + data + "</b> doesn't exist in our database.<br/>";
                addnRate.InnerText = "ADD AND RATE " + data + " TO OUR DATABASE NOW!"; addnRate.Attributes["href"] = "SubmitReview/Default.aspx?company=" + data + "&add=1";
                if (page == "company")
                    errorCompany.Rows[2].Cells[0].InnerHtml += " Or Click <a href=\"Companies.aspx\">Here</a> to go back to the Companies page.<br/>";
                else if (page == "main")
                    errorCompany.Rows[2].Cells[0].InnerHtml += "Or Click <a href=\"Default.aspx\">Here</a> to go back to the Home page.<br/>";
            }
            else if (page == "companydetails" || page == "reviews")
            {
                string data = Request.QueryString["data"];
                if (data == "expired")
                {
                    errorMessage.InnerHtml = "Sorry! your session has expired.";
                    errorMessage.InnerHtml += "<br/>Start a new session by Clicking <a href=\"Default.aspx\">Here</a>.";
                }               
            }
            else if (page == "revInput")
            {
                string data = Request["data"];
                if (data == "expired")
                {
                    errorMessage.InnerHtml = "Sorry! your session has expired.";
                    errorMessage.InnerHtml += "<br/>Start rating your employer again by Clicking <a href=\"SubmitReview/Default.aspx\">Here</a>.";
                }
                else if (data == "dbUpdError")
                {
                    errorMessage.InnerHtml = "Sorry! There was a problem updating the Database.";
                    errorMessage.InnerHtml += "<br/>Please rate your employer again by Clicking <a href=\"SubmitReview/Default.aspx?company="+Request["c"]+"\">Here</a>.";
                }
            }
        }
    }
}