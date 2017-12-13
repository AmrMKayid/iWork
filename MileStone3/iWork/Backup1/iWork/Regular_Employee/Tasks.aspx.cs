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

    public partial class Tasks : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null && Session["Project"] != null)
            {
                string userId = Session["Username"].ToString();
                string project = Session["Project"].ToString();
                view_tasks(userId, project);

            }
        }
        protected void view_tasks(String username, String project)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("viewMyAssignedTasksInAProject", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", username));
            cmd.SelectCommand.Parameters.Add(new SqlParameter("@project", project));

            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            tasks.DataSource = dtbl;
            tasks.DataBind();
        }
        protected void fix(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();
            string project = Session["Project"].ToString();
            string t = Convert.ToString(((sender as Button).CommandArgument));
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("FinishedTask", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@project", project));
            cmd.Parameters.Add(new SqlParameter("@task", t));
            conn.Open();
            int rowsUpdated = cmd.ExecuteNonQuery();
            if (rowsUpdated > 0)
            {
                view_tasks(username, project);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('You cannot fix this task as deadline has passed or it's already fixed');</script>", false);

            }

        }
        protected void Assign(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();
            string project = Session["Project"].ToString();
            string t = Convert.ToString(((sender as Button).CommandArgument));
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("ChangeTaskStatus", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@project", project));
            cmd.Parameters.Add(new SqlParameter("@task", t));
            conn.Open();
            int rowsUpdated = cmd.ExecuteNonQuery();
            if (rowsUpdated > 0)
            {
                view_tasks(username, project);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('You cannot resume working on this task as it is either:'+' < br />'+'1-Reviewed by manager'+' < br >/ '+'2-Deadline already passed');</script>", false);

            }

        }
        protected void View_projects(object sender, EventArgs e)
        {

            Response.Redirect("projects.aspx", true);
        }

        protected void View_comments(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlDataAdapter cmd = new SqlDataAdapter("Task_Comments", conn);
        cmd.SelectCommand.CommandType = CommandType.StoredProcedure;
        string[] commandArgs = ((sender as Button).CommandArgument).Split(new char[] { ',' });
        string task = commandArgs[0];
        string company = commandArgs[1];
        string project = commandArgs[2];
        if (Session["Username"] != null)
        {
            String username = Session["Username"].ToString();
            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", username));

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@task", task));
            cmd.SelectCommand.Parameters.Add(new SqlParameter("@project", project));
            cmd.SelectCommand.Parameters.Add(new SqlParameter("@company", company));

            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            GridView2.DataSource = dtbl;
            GridView2.DataBind();

        }
        }
    }
}
