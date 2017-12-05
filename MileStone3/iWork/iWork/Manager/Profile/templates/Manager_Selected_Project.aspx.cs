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

        protected void Page_Load(object sender, EventArgs e)
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
