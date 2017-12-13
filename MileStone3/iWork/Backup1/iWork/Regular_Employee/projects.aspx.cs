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

namespace iWork.Regular_Employee
{

    public partial class projects : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string userId = Session["Username"].ToString();

                Show_Projects(userId);
            }

        }
        protected void Show_Projects(String username)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("viewMyAssignedProjects", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", username));
            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            Projects.DataSource = dtbl;
            Projects.DataBind();
        }
        protected void Show_Tasks(object sender, EventArgs e)
        {

            String p = Convert.ToString(((sender as Button).CommandArgument));
            Session["project"] = p;
            Response.Write("Passed");
            Response.Redirect("Tasks.aspx", true);

        }
        protected void View_projects(object sender, EventArgs e)
        {

            Response.Redirect("projects.aspx", true);
        }
    }
}
