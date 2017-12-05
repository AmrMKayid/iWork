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

    public partial class Manager_Projects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            SqlConnection conn2 = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");



            SqlCommand cmd2 = new SqlCommand("SELECT name, start_date, end_date from Projects where mananger_define_username =\'" + Session["Username"] + "\'", conn2);

            conn2.Open();

            SqlDataReader ds = cmd2.ExecuteReader();

            MyProjectsView.DataSource = ds;


            MyProjectsView.DataBind();

            conn2.Close();

        }

        protected void SelectProject_Clicked(object sender, CommandEventArgs e)
        {
            string SelectedProject = MyProjectsView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            Session["SelectedProject"] = SelectedProject;
            //TODO: Redirect to project details
            Response.Redirect("Manager_Selected_Project.aspx");
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

            conn.Close();

            string script = "alert('" + "Project " + ProjectNametxt.Text + " Created" +   "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
    }
}
