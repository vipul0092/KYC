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

public partial class SubmitReview_Default : System.Web.UI.Page
{

    public string like_message;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["val"] != null)
        {
            RaterInfo storedInfo = (RaterInfo)Session["raterinfo"];
            nameIn.Value = storedInfo.name;
            employerIn.Value = storedInfo.employer;
            emailIn.Attributes["placeholder"] = "WRONG EMAIL ID!";
            empnumIn.Value = storedInfo.employerCode;
            contactnumIn.Value = storedInfo.contactNum;
        }
        if (!this.IsPostBack)
        {
            Bind();
            if (Request["company"] != null)
            {
                string company = Request["company"];
                employerIn.Value = company;
                if(Request["add"] == null)
                    employerIn.Disabled = true;
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

    protected void nextStep_Click(object sender, EventArgs e)
    {
        RaterInfo info = new RaterInfo(employerIn.Value, emailIn.Value, nameIn.Value, empnumIn.Value, contactnumIn.Value);
        emailIn.Attributes["placeholder"] = "";
        Session["raterinfo"] = info;
        bool res = info.checkEmail();

        if (!res)
            Response.Redirect("Default.aspx?val=error");
        else
        {
            Response.Redirect("ReviewInput.aspx");
        }
    }
}