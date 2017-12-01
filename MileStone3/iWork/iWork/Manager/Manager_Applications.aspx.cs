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

    public partial class Manager_Applications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
    }
}
