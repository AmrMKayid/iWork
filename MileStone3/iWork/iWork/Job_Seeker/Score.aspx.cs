using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iWork.Model;


namespace iWork.Job_Seeker
{

    public partial class Score : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Score"] != null)
            {
                string users = Session["Score"].ToString();
                
            }
        }

        protected void View_AStatus(object sender, EventArgs e)
        {
            Response.Write("Passed");
            Response.Redirect("Application_Status.aspx", true);
        }

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../Default.aspx", true);
        }
    }
}
