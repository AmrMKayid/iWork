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

    public partial class Manager_Selected_Task : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

        protected void Page_Load(object sender, EventArgs e)
        {

            // View Tasks
            string sqlSelect = "Select regular_employee_username from Project_Assignments where project_name=\'" +
                                    Session["SelectedProject"] + "\' AND mananger_username=\'" + Session["Username"] + "\'";
            SqlCommand viewTasksCmd = new SqlCommand(sqlSelect, conn);

            conn.Open();

            // View Tasks
            DataSet ds4 = new DataSet();
            SqlDataAdapter objAdp4 = new SqlDataAdapter(viewTasksCmd);
            objAdp4.Fill(ds4);

            RegEmpView.DataSource = ds4;
            RegEmpView.DataBind();

            conn.Close();

        }

        protected void AssignToTask_Clicked(object sender, CommandEventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                index = (index < 0) ? 0 : (index >= RegEmpView.Rows.Count) ? index - 1 : index;
                string username = RegEmpView.Rows[index].Cells[0].Text;

                Session["AssignedEmp"] = username;

                SqlCommand cmd = new SqlCommand("AssignTask", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
                cmd.Parameters.Add(new SqlParameter("@name", Session["SelectedTask"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee_username", Session["AssignedEmp"]));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();

                string script = "alert('" + "Task:  " + Session["SelectedTask"] + " assigned to " + Session["AssignedEmp"] + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch (ArgumentOutOfRangeException ee)
            {
                string script = "alert('" + "Error:  " + ee.Message + " !!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void SelectEmp_Clicked(object sender, CommandEventArgs e)
        {
                int index = Convert.ToInt32(e.CommandArgument);
                index = (index < 0) ? 0 : (index >= RegEmpView.Rows.Count) ? index - 1 : index;
                string username = RegEmpView.Rows[index].Cells[0].Text;

                Session["ReplacementEmp"] = username;

        }

        protected void ReAssignToTask_Clicked(object sender, CommandEventArgs e)
        {
            try
            {

                SqlCommand cmd = new SqlCommand("ChangeTaskEmployee", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
                cmd.Parameters.Add(new SqlParameter("@task", Session["SelectedTask"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee", Session["AssignedEmp"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee_replacing", Session["ReplacementEmp"]));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();

                string script = "alert('" + "The new Employee for Task: " + Session["SelectedTask"] + " is " + Session["ReplacementEmp"] + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch (ArgumentOutOfRangeException ee)
            {
                string script = "alert('" + "Error:  " + ee.Message + " !!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

        }
    }
}
