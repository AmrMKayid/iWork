using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using iWork.Model;

namespace iWork
{

    public partial class DefaultSigned : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());


        protected void profileBtn_Clicked(object sender, EventArgs e)
        {

            //Response.Write(Session["UsernameType"]);
            if (Session["Username"] != null)
            {
                if (Session["UsernameType"].Equals("Regular Employee"))
                    Response.Redirect("Regular_Employee/Regular_Employee.aspx", true);

                else if (Session["UsernameType"].Equals("Manager"))
                    Response.Redirect("Manager/Manager.aspx", true);

                else if (Session["UsernameType"].Equals("HR Employee"))
                    Response.Redirect("Staff_Member/Dashboard/Index.aspx", true);

                else if (Session["UsernameType"].Equals("Job Seeker"))
                    Response.Redirect("Job_Seeker/Job_Seeker.aspx", true);
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Error!!!');</script>", false);

            }

        }


        protected void logoutBtn_Clicked(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("~/Default.aspx");
        }

        protected void singup_Clicked(object sender, EventArgs e)
        {
          
        }
    }
}
