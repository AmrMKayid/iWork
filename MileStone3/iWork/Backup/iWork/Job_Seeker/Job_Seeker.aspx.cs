using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iWork.Model;

namespace iWork.Job_Seeker
{

    public partial class Job_Seeker : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string userId = Session["Username"].ToString();

            }
        }
        protected void View_AStatus(object sender, EventArgs e)
        {

            Response.Write("Passed");
            Response.Redirect("Application_Status.aspx", true);


        }

        protected void show_searched_jobs(object sender, EventArgs e)
        {
            string x = Searched_job.Value;
            Session["searched_job"] = x;
            Response.Redirect("searched_jobs.aspx", true);

        }

    }
}
