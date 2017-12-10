﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace iWork.Manager
{

    public partial class Manager_Review_Task : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

        protected void SearchForTask_Clicked(object sender, EventArgs e)
        {
            string viewTasks = "SELECT project, name, regular_employee_username, status, deadline, description from Tasks where mananger_username =\'" +
                Session["Username"] + "\' AND " + "project =\'" + projectNameforTaskTxt.Text + "\'" + " AND " + "status =\'" + statusTxt.Text + "\'";

            SqlCommand viewTasksCmd = new SqlCommand(viewTasks, conn);


            conn.Open();

            // View Tasks
            DataSet ds3 = new DataSet();
            SqlDataAdapter objAdp3 = new SqlDataAdapter(viewTasksCmd);
            objAdp3.Fill(ds3);

            SearchForTaskView.DataSource = ds3;
            SearchForTaskView.DataBind();

            conn.Close();

        }

        protected void AcceptTask_Clicked(object sender, CommandEventArgs e)
        {
            string project = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            string task = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
            string status = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;


            if (status.ToLower() != "fixed")
            {
                string script = "alert(' You can ONLY REVIEW Fixed Tasks | " + "this task status is:" + status + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else
            {
                SqlCommand cmd = new SqlCommand("ReviewTask", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", project));
                cmd.Parameters.Add(new SqlParameter("@task", task));
                cmd.Parameters.Add(new SqlParameter("@isAccepted", 1));
                cmd.Parameters.Add(new SqlParameter("@newDeadline", null));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();

                SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text = "Closed";
            }

        }

        protected void RejectTask_Clicked(object sender, CommandEventArgs e)
        {

            string project = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            string task = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
            string status = SearchForTaskView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;

            if (status.ToLower() != "fixed")
            {
                string script = "alert(' You can ONLY REVIEW Fixed Tasks | " + "this task status is:" + status + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else
            {
                Session["NameOfTaskProject"] = project;
                Session["NameOfRejectedTask"] = task;

                Response.Redirect("Manager_Review_Task_Reject.aspx");

            }

        }
    }
}