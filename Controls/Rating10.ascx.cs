using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Rating10 : System.Web.UI.UserControl
{
    RadioButton[] radioArray;

    /// <summary>
    /// Sets Rating in the control programatically
    /// </summary>
    /// <param name="rating">The rating value to set in the control</param>
    public void setRating(int rating)
    {
        radioArray = new RadioButton[10] { Radio1, Radio2, Radio3, Radio4, Radio5, Radio6, Radio7, Radio8, Radio9, Radio10 };
        if (rating != 0)
        { radioArray[rating - 1].Checked = true; ratingDisp.InnerText = rating.ToString() + "/10"; }
        else
        { for (int i = 0; i < 10; i++) radioArray[i].Checked = false; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Radio_ServerChange(object sender, EventArgs e)
    {
        int radioIndex=0;
        radioArray = new RadioButton[10] { Radio1, Radio2, Radio3, Radio4, Radio5, Radio6, Radio7, Radio8, Radio9, Radio10 };
        if (((RadioButton)sender).Checked == true)
        {
            for (int i = 0; i < 10; i++)
                if (radioArray[i] == (RadioButton)sender)
                    radioIndex = i + 1;
            
            for (int i = 0; i < 10; i++)
                if (i != radioIndex - 1)
                    radioArray[i].Checked = false;

            ratingDisp.InnerText = radioIndex.ToString() + "/10";
        }
    }

    public int GetRating()
    {
        int rating = 0;
        radioArray = new RadioButton[10] { Radio1, Radio2, Radio3, Radio4, Radio5, Radio6, Radio7, Radio8, Radio9, Radio10 };
        for (int i = 0; i < 10; i++)
        {
            if (radioArray[i].Checked == true)
                rating = i + 1;
        }
        return rating;
    }

    public void disable(int param=0)
    {       
        radioArray = new RadioButton[10] { Radio1, Radio2, Radio3, Radio4, Radio5, Radio6, Radio7, Radio8, Radio9, Radio10 };
        for (int i = 0; i < 10; i++)
                radioArray[i].Enabled = false;
        if (param == 0)
        {
            for (int i = 0; i < 10; i++)
            { radioTable.Rows[0].Cells[i].Visible = false; }
        }
        else if (param == 1)
        { radioTable.Visible = false; }

    }
}