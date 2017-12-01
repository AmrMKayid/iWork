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

    public partial class Manager : System.Web.UI.Page
    {
        protected void ViewNewRequests(object sender, EventArgs e)
        {

            //TODO: Redirect to New Page for REQUESTS

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ViewNewRequests", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);
            objAdp.Fill(ds);

            RequestsGridView.DataSource = ds;


            RequestsGridView.DataBind();

            conn.Close();

        }

        protected void AcceptRequest(object sender, CommandEventArgs e)
        {
            string username = RequestsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            string start_date = RequestsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ReviewRequest", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
            cmd.Parameters.Add(new SqlParameter("@start_date",start_date));
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@isAccepted", 1));
            cmd.Parameters.Add(new SqlParameter("@reason", null));

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();

            RequestsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text = "Accepted";
        }

        protected void RejectRequest(object sender, CommandEventArgs e)
        {
            // TODO
        }

        //########################################################################################//

        protected void ViewNewApplications(object sender, EventArgs e)
        {

            //TODO: Redirect to New Page for Application

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ViewApplication", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            // TODO: Get the job title
            cmd.Parameters.Add(new SqlParameter("@job_title", "Manager-Junior Software Engineering Manager"));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            ApplicationGridView.DataSource = ds;

            ApplicationGridView.DataBind();

            conn.Close();

        }

        protected void AcceptApplication(object sender, CommandEventArgs e)
        {
            // TODO

            int id = Convert.ToInt32(ApplicationGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ReviewApplication", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
            cmd.Parameters.Add(new SqlParameter("@id", id));
            cmd.Parameters.Add(new SqlParameter("@isAccepted", 1));

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();

            ApplicationGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[10].Text = "Accepted";
        }

        protected void RejectApplication(object sender, CommandEventArgs e)
        {
            // TODO

            int id = Convert.ToInt32(ApplicationGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text);

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ReviewApplication", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
            cmd.Parameters.Add(new SqlParameter("@id", id));
            cmd.Parameters.Add(new SqlParameter("@isAccepted", 0));

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();

            ApplicationGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[10].Text = "Rejected";
        }

        //########################################################################################//
       
        protected void NewProjectClicked(object sender, EventArgs e)
        {
            // TODO
        }

        protected void CreateNewProject(object sender, EventArgs e)
        {
            // TODO
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

        //########################################################################################//
    }
}
