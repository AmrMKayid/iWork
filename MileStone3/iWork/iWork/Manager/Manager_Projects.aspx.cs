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
    }
}
