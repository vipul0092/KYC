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

public partial class CompanyRating : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        for (int i = 1; i <= 12; i++)
        {
            ratingDetailsTable.Rows[i].Cells[1].InnerHtml = "<img src=\"Images/arrow.gif\" />"; ratingDetailsTable.Rows[i].Cells[1].Attributes["class"] = "left";
        }

        if (!this.IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                int companyID = int.Parse(Request.QueryString["id"]);
                DatabaseManager db = new DatabaseManager();
                DataSet ratDS = db.GetDataSet("SELECT * FROM MainTable,CompanyRatings WHERE MainTable.CompanyId=" + companyID + " AND CompanyRatings.CompanyRId=" + companyID);
                DataSet revDS = db.GetDataSet("SELECT * FROM Reviews WHERE Reviews.CompanyIDRev=" + companyID);

                string company = (string)ratDS.Tables[0].Rows[0]["CompanyName"];
                int[] ratingInfo = new int[2] { (int)ratDS.Tables[0].Rows[0]["AverageRating"], (int)ratDS.Tables[0].Rows[0]["NumReviews"] };
                int[] indvRating = new int[12] { (int)ratDS.Tables[0].Rows[0]["InterviewAtmosphere"], (int)ratDS.Tables[0].Rows[0]["Recruitment"], (int)ratDS.Tables[0].Rows[0]["LevelOfStress"], (int)ratDS.Tables[0].Rows[0]["PhysicalCondition"], (int)ratDS.Tables[0].Rows[0]["HRPractices"], (int)ratDS.Tables[0].Rows[0]["SalaryBenefits"], (int)ratDS.Tables[0].Rows[0]["Schedule"], (int)ratDS.Tables[0].Rows[0]["Promotion"], (int)ratDS.Tables[0].Rows[0]["Recognition"], (int)ratDS.Tables[0].Rows[0]["SatisfactionLevel"], (int)ratDS.Tables[0].Rows[0]["LifeBalance"], (int)ratDS.Tables[0].Rows[0]["Recommendation"] };
                Session["company"] = company;

                rate.InnerHtml = "<a title=\"Rate " + company + " Now and leave a review.\" class=\"rateBtn\" href=\"SubmitReview/Default.aspx?company=" + company + "\">Rate Now</a>";
                companyName.InnerHtml = "<b>" + company + "</b>";
                companyLogo.Src = "../Images/Logos/logo_" + companyID + ".png";
                rating.setRating(ratingInfo[0]); rating.disable(2);
                numRatings.InnerHtml = " Based On " + ratingInfo[1] + " Ratings.";
                Rating10[] ratCol = new Rating10[12] { dRating1, dRating2, dRating3, dRating4, dRating5, dRating6, dRating7, dRating8, dRating9, dRating10, dRating11, dRating12 };
                for (int i = 0; i < 12; i++)
                { ratCol[i].Visible = true; ratCol[i].setRating(indvRating[i]); ratCol[i].disable(1); }

                if (revDS.Tables[0].Rows.Count != 0)
                {
                    //27 characters.
                    numReviewsTotal.Visible = true; numReviewsTotal.InnerHtml = "Total " + revDS.Tables[0].Rows.Count + " Review(s) Available.<br/><a title=\"View all reviews for " + company + "\" class=\"viewAll\" href=\"View/Reviews.aspx?id=" + ((int)revDS.Tables[0].Rows[0]["Id"]) + "&mode=all&page=1\">View All</a>";
                    int times = revDS.Tables[0].Rows.Count; if (times > 3) times = 3;
                    for (int a = 1; a <= times; a++)
                    {
                        string comment = ((string)revDS.Tables[0].Rows[a - 1]["ReviewText"]);
                        comment.Replace("&apos;", "'");
                        if (comment.Length <= 30)
                        { reviewTable.Rows[(2 * a) - 1].Cells[0].InnerHtml = comment; }
                        else
                        {
                            reviewTable.Rows[(2 * a) - 1].Cells[0].InnerHtml = comment.Substring(0, 30) + "...";
                        }
                        reviewTable.Rows[(2 * a) - 1].Cells[0].InnerHtml += "<br/> <a title=\"Read the full comment\" class=\"more\" href=\"../View/Reviews.aspx?id=" + ((int)revDS.Tables[0].Rows[a - 1]["Id"]) + "\">Read More</a>";
                        reviewTable.Rows[(2 * a) - 1].Cells[0].Attributes["class"] = "border , centerAlign";
                    }
                }
                else
                {
                    reviewTable.Rows[1].Cells[0].InnerHtml = "NO REVIEWS!";
                    reviewTable.Rows[1].Cells[0].Attributes["class"] = "centerAlign";
                }
            }         
          }
        }

    protected void rate_Click(object sender, EventArgs e) 
    {
        if (Session["company"] != null)
        {
            Response.Redirect("SubmitReview/Default.aspx?company="+Session["company"]);
        }
        else
        {
            Response.Redirect("Error.aspx?from=companydetails&data=expired");
        }
    }
}