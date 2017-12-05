using System;
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

    public partial class Manager_Projects : System.Web.UI.Page
    {
        protected void CreateNewProject(object sender, EventArgs e)
        {
            // DONE in AspProject
            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("CreateNewProject", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            cmd.Parameters.Add(new SqlParameter("@name", ProjectNametxt.Text));

            cmd.Parameters.Add(new SqlParameter("@start_date", TextBox1.Text));

            cmd.Parameters.Add(new SqlParameter("@end_date", TextBox2.Text));

            conn.Open();

            cmd.ExecuteReader();

            Response.Write("Project " + ProjectNametxt.Text + " Created");

            conn.Close();


            SqlConnection conn2 = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd2 = new SqlCommand("viewRegEmp2Projects", conn2);
            cmd2.CommandType = CommandType.StoredProcedure;

            cmd2.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd2);
            objAdp.Fill(ds);

            RegEmpView.DataSource = ds;


            RegEmpView.DataBind();

            conn.Close();
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            Calendar1.Visible = true;

        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            TextBox1.Text = Calendar1.SelectedDate.ToShortDateString();
            Calendar1.Visible = false;
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {

            Calendar2.Visible = true;

        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            TextBox2.Text = Calendar2.SelectedDate.ToShortDateString();
            Calendar2.Visible = false;
        }







        //################################################################

        protected void viewMyProjects_Clicked(object sender, EventArgs e)
        {

            SqlConnection conn2 = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");



            SqlCommand cmd2 = new SqlCommand("SELECT name, start_date, end_date from Projects where mananger_define_username =\'" + Session["Username"] + "\'", conn2);

            conn2.Open();

            SqlDataReader ds = cmd2.ExecuteReader();

            MyProjectsView.DataSource = ds;


            MyProjectsView.DataBind();

            conn2.Close();
        }

        protected void SelectProject_Clicked(object sender, CommandEventArgs e) {
            string SelectedProject = MyProjectsView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            Session["SelectedProject"] = SelectedProject;
        }

        protected void viewRegularEmp_Clicked(object sender, EventArgs e)
        {

            SqlConnection conn2 = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd2 = new SqlCommand("viewRegEmp2Projects", conn2);
            cmd2.CommandType = CommandType.StoredProcedure;

            cmd2.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn2.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd2);
            objAdp.Fill(ds);

            RegEmpView.DataSource = ds;


            RegEmpView.DataBind();

            conn2.Close();
        }

        protected void AddToProject_Clicked(object sender, CommandEventArgs e)
        {

            string username = RegEmpView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("AddEmployeeToProject", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
            cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
            cmd.Parameters.Add(new SqlParameter("@regular_employee", username));

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();

        }

        protected void RemoveFromProject_Clicked(object sender, CommandEventArgs e)
        {
            // TODO: View Project's Employee To remove them
            string username = RegEmpView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("RemoveEmployeeFromProject", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
            cmd.Parameters.Add(new SqlParameter("@project", Session["SelectedProject"]));
            cmd.Parameters.Add(new SqlParameter("@regular_employee", username));

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();
        }

    }
}
