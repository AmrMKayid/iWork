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


namespace iWork.Manager.Profile.templates
{

    public partial class Manager_Selected_Project : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] == null)
                Response.Redirect("~/Default.aspx");


            try
            {
                // View Regular Employees
                SqlCommand viewRegCmd = new SqlCommand("viewRegEmp2Projects", conn);
                viewRegCmd.CommandType = CommandType.StoredProcedure;

                viewRegCmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));


                // Remove Regular Employees
                string sqlSelect = "Select regular_employee_username from Project_Assignments where project_name=\'" +
                                        Session["SelectedProject"] + "\' AND mananger_username=\'" + Session["Username"] + "\'";

                SqlCommand removeRegCmd = new SqlCommand(sqlSelect, conn);

                //// View Tasks
                //string viewTasks = "SELECT project, name, regular_employee_username, status, deadline, description from Tasks where mananger_username =\'" + 
                //                    Session["Username"] + "\' AND " + "project =\'" + Session["SelectedProject"] + "\'";
                //SqlCommand viewTasksCmd = new SqlCommand(viewTasks, conn);  

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

                conn.Close();
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

        }

        protected void AddToProject_Clicked(object sender, CommandEventArgs e)
        {
           try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                index = (index < 0) ? 0 : (index >= RegEmpView.Rows.Count) ? index - 1 : index;
                string username = RegEmpView.Rows[index].Cells[0].Text;

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
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

        }

        protected void RemoveFromProject_Clicked(object sender, CommandEventArgs e)
        {
            // TODO: View Project's Employee To remove them <= Done

            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                index = (index < 0) ? 0 : (index >= DeleteRegEmpView.Rows.Count) ? index - 1 : index;
                string username = DeleteRegEmpView.Rows[index].Cells[0].Text;

                string countStr = "Select count(*) from Project_Assignments where project_name=\'" +
                    Session["SelectedProject"] + "\' AND mananger_username=\'" + Session["Username"] + "\' AND regular_employee_username=\'" + username + "\'"; 
                SqlCommand countCmd = new SqlCommand(countStr, conn);

                SqlCommand cmd = new SqlCommand("RemoveEmployeeFromProject", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
                cmd.Parameters.Add(new SqlParameter("@regular_employee", username));

                conn.Open();
                Int32 countBefore = Convert.ToInt32(countCmd.ExecuteScalar());
                conn.Close();

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();

                conn.Open();
                Int32 countAfter = Convert.ToInt32(countCmd.ExecuteScalar());
                conn.Close(); 


                if(countAfter == countBefore)
                {
                    string script = "alert('" + username + " has Tasks in this project >> You CAN NOT Remove him');";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                }
            }
            catch (ArgumentOutOfRangeException ee)
            {
                string script = "alert('" + "Error:  " + ee.Message + " !!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }


        //#########################################################################

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../Default.aspx", true);
        }

    }
}
