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

namespace iWork.Manager
{

    public partial class Manager_Project_Task : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] == null)
                Response.Redirect("~/Default.aspx");




            //// View Tasks
            string viewTasks = "SELECT project, name, regular_employee_username, status, deadline, description from Tasks where mananger_username =\'" + 
                                Session["Username"] + "\' AND " + "project =\'" + Session["SelectedProject"] + "\'";
            SqlCommand viewTasksCmd = new SqlCommand(viewTasks, conn);  

            conn.Open();

            // View Regular Employees
            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(viewTasksCmd);
            objAdp.Fill(ds);

            MyTasksView.DataSource = ds;
            MyTasksView.DataBind();

            conn.Close();

        }


        protected void CreateNewTask(object sender, EventArgs e)
        {

            try
            {
                SqlCommand cmd = new SqlCommand("CreateNewTask", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

                cmd.Parameters.Add(new SqlParameter("@name", TaskNametxt.Text));

                cmd.Parameters.Add(new SqlParameter("@description", descriptiontxt.Text));

                cmd.Parameters.Add(new SqlParameter("@deadline", deadline.Text));

                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));

                conn.Open();

                cmd.ExecuteNonQuery();

                conn.Close();

                string script = "alert('" + "Task (" + TaskNametxt.Text + ") Created" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);

            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void SelectTask_Clicked(object sender, CommandEventArgs e)
        {
            string SelectedTask = MyTasksView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
            Session["SelectedTask"] = SelectedTask;
            //TODO: Redirect to project details
            Response.Redirect("Manager_Selected_Task.aspx");
        }

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../Default.aspx", true);
        }
    }
}
