using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace iWork.Manager.Profile.templates
{

    public partial class Manager_Selected_Project : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

        protected void Page_Load(object sender, EventArgs e)
        {


            // View Regular Employees
            SqlCommand viewRegCmd = new SqlCommand("viewRegEmp2Projects", conn);
            viewRegCmd.CommandType = CommandType.StoredProcedure;

            viewRegCmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));


            // Remove Regular Employees
            string sqlSelect = "Select regular_employee_username from Project_Assignments where project_name=\'" + 
                                    Session["SelectedProject"] + "\' AND mananger_username=\'" + Session["Username"] + "\'";

            SqlCommand removeRegCmd = new SqlCommand(sqlSelect, conn);

            // View Tasks
            string viewTasks = "SELECT project, name, regular_employee_username, status, deadline, description from Tasks where mananger_username =\'" + 
                                Session["Username"] + "\' AND " + "project =\'" + Session["SelectedProject"] + "\'";
            SqlCommand viewTasksCmd = new SqlCommand(viewTasks, conn);  

            conn.Open();

            // View Regular Employees
            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(viewRegCmd);
            objAdp.Fill(ds);

            RegEmpView.DataSource = ds;
            RegEmpView.DataBind();

            // Remove Regular Employees Table 
            DataSet ds2 = new DataSet();
            SqlDataAdapter objAdp2 = new SqlDataAdapter(removeRegCmd);
            objAdp2.Fill(ds2);

            DeleteRegEmpView.DataSource = ds2;
            DeleteRegEmpView.DataBind();

            // View Tasks
            DataSet ds3 = new DataSet();
            SqlDataAdapter objAdp3 = new SqlDataAdapter(viewTasksCmd);
            objAdp3.Fill(ds3);

            MyTasksView.DataSource = ds3;
            MyTasksView.DataBind();

            conn.Close();

        }

        protected void AddToProject_Clicked(object sender, CommandEventArgs e)
        {
           try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                //index = (index < 0) ? 0 : (index >= RegEmpView.Rows.Count) ? index - 1 : index;
                string username = RegEmpView.Rows[index].Cells[0].Text;

                //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


                SqlCommand cmd = new SqlCommand("AddEmployeeToProject", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee", username));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();
            }
            catch (ArgumentOutOfRangeException ee)
            {
                string script = "alert('" + "Error:  " + ee.Message + " !!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

        }

        protected void RemoveFromProject_Clicked(object sender, CommandEventArgs e)
        {
            // TODO: View Project's Employee To remove them <= Done

            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                //index = (index < 0) ? 0 : (index >= DeleteRegEmpView.Rows.Count) ? index - 1 : index;
                string username = DeleteRegEmpView.Rows[index].Cells[0].Text;

                //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


                SqlCommand cmd = new SqlCommand("RemoveEmployeeFromProject", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee", username));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();
            }
            catch (ArgumentOutOfRangeException ee)
            {
                string script = "alert('" + "Error:  " + ee.Message + " !!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }


        //#########################################################################

        protected void CreateNewTask(object sender, EventArgs e)
        {
            // TODO
            //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

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

                cmd.ExecuteReader();

                conn.Close();

                string script = "alert('" + "Task (" + TaskNametxt.Text + ") Created" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch(SqlException ee) 
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void AssignEmp_Clicked(object sender, CommandEventArgs e) 
        {
            try
            {
                TextBox AssignEmpT = (TextBox) MyTasksView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[7].FindControl("AssignEmptxt");
                string SelectedTask = MyTasksView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

                SqlCommand cmd = new SqlCommand("AssignTask", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

                cmd.Parameters.Add(new SqlParameter("@name", SelectedTask));

                cmd.Parameters.Add(new SqlParameter("@regular_employee_username", AssignEmpT.Text));

                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));

                conn.Open();

                cmd.ExecuteReader();

                conn.Close();

                string script = "alert('" + "You Assigned (" + AssignEmptxt.Text + ")" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void ChangeEmp_Clicked(object sender, CommandEventArgs e)
        {
            try
            {
                string AssignedEmp = MyTasksView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                string SelectedTask = MyTasksView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

                SqlCommand cmd = new SqlCommand("ChangeTaskEmployee", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

                cmd.Parameters.Add(new SqlParameter("@task", SelectedTask));

                cmd.Parameters.Add(new SqlParameter("@regular_employee", AssignedEmp));

                cmd.Parameters.Add(new SqlParameter("@regular_employee_replacing", ChangeEmptxt.Text));

                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));

                conn.Open();

                cmd.ExecuteReader();

                conn.Close();

                string script = "alert('" + "You Changed the Task to (" + ChangeEmptxt.Text + ")" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }
    }
}
