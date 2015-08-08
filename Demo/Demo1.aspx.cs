using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.HtmlControls;
using KYClib;

public partial class Demo_Demo1 : System.Web.UI.Page
{
    public string like_message;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Bind();
        }
        like_message = Get_Message();
    }
    public void Bind()
    {
        
        /*DataTable dt = Get_source();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeNode no = new TreeNode();
            no.Text = dt.Rows[i]["message"].ToString();
            no.Value = dt.Rows[i]["message"].ToString();
            this.TreeView1.Nodes.Add(no);
        }*/

        DatabaseManager db = new DatabaseManager();

        using (SqlCommand command = db.GetCommand("SELECT CompanyName FROM MainTable"))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter(command))
            { DataSet ds = new DataSet();
              sda.Fill(ds);
              Session["CompanyList"] = ds;
            }
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
        /*string XM = "microsoft,my,ming,may,master,mingXu,more,make,most,mobile";
        string[] list1 = XM.Split(',');*/
        if (Session["CompanyList"] != null)
            ds = (DataSet)Session["CompanyList"];
        else
        { Bind(); ds = (DataSet)Session["CompanyList"]; }

        dt.Columns.Add(new DataColumn("message"));
        for (int i = 0; i < ds.Tables[0].Rows.Count ; i++)
        {
            dr = dt.NewRow();
            dr["message"] = ds.Tables[0].Rows[i].Field<string>(0);
            dt.Rows.Add(dr);
        }
        return dt;
    }
    protected void tbx_Microsoft_TextChanged(object sender, EventArgs e)
    {
        foreach (TreeNode no in this.TreeView1.Nodes)
        {
            if (no.Value == this.tbx_Microsoft.Text)
            {
                no.Selected = true;
            }
        }
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("message"));
        DataRow[] drs = Get_source().Select("message='" + this.tbx_Microsoft.Text + "'");
        foreach (DataRow dr in drs)
        {
            DataRow datarow = dt.NewRow();
            datarow.ItemArray = dr.ItemArray;
            dt.Rows.Add(datarow);
        }
        this.GridView1.DataSource = dt;
        this.GridView1.DataBind();

    }
}