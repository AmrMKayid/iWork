﻿using System;
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

    public partial class Manager_Projects : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {


            if (Session["Username"] == null)
                Response.Redirect("~/Default.aspx");



            SqlCommand cmd = new SqlCommand("SELECT P.* from Projects P, Staff_Members s1, Staff_Members s2 Where s1.username =P.mananger_define_username and s1.department = s2.department and s2.username=\'" + Session["Username"] + "\'", conn);

            conn.Open();

            SqlDataReader ds = cmd.ExecuteReader();

            MyProjectsView.DataSource = ds;


            MyProjectsView.DataBind();

            conn.Close();

        }

        protected void SelectProject_Clicked(object sender, CommandEventArgs e)
        {
            string SelectedProject = MyProjectsView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            Session["SelectedProject"] = SelectedProject;


            Response.Redirect("Manager_Selected_Project.aspx");
        }

        protected void CreateNewProject(object sender, EventArgs e)
        {
            string[] ProjectName = new string[MyProjectsView.Rows.Count];

            for (int i = 0; i < MyProjectsView.Rows.Count; i++)
                ProjectName[i] = MyProjectsView.Rows[i].Cells[0].Text;
                
            if(ProjectNametxt.Text == "")
            {
                string script = "alert('You Can't Create a Project without a Name!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else if(ProjectName.Contains(ProjectNametxt.Text))
            {
                string script = "alert('You Can't Create a Project with the SAME name of another Project!" + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("CreateNewProject", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

                    cmd.Parameters.Add(new SqlParameter("@name", ProjectNametxt.Text));

                    cmd.Parameters.Add(new SqlParameter("@start_date", TextBox1.Text));

                    cmd.Parameters.Add(new SqlParameter("@end_date", TextBox2.Text));

                    conn.Open();

                    cmd.ExecuteReader();

                    conn.Close();

                    string script = "alert('" + "Project (" + ProjectNametxt.Text + ") Created" + "');";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                }
                catch (SqlException ee)
                {
                    string script = "alert('" + ee.Message + "');";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                }
            }

        }

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../Default.aspx", true);
        }

    }
}
