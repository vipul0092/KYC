using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request["from"] != null)
            {
                if (Request["from"] == "uc")
                {
                    successMessage.InnerHtml = "Your input ratings have been successfully added to the Database. Thank You for your valuable input!";
                    successMessage.InnerHtml += "<br/>Click <a href=\"../Default.aspx\">Here</a> to go back to the Home page.<br/>";
                }
            }
        }
    }
}