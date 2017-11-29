using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace iWork
{

    public partial class Manager : System.Web.UI.Page
    {

        protected void ViewNewRequests(object sender, EventArgs e) {

            //TODO: Redirect to New Page for REQUESTS

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ViewNewRequests", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);
            objAdp.Fill(ds);

            GridView1.DataSource = ds;


            GridView1.DataBind();

            conn.Close();

        }

        protected void AcceptRequest(object sender, EventArgs e)
        {

        }

        protected void RejectRequest(object sender, EventArgs e)
        {

        }

        //############################################

        protected void ViewNewApplications(object sender, EventArgs e)
        {

            //TODO: Redirect to New Page for Application

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ViewApplication", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            cmd.Parameters.Add(new SqlParameter("@job_title", "Manager-Junior Software Engineering Manager"));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            ApplicationGridView.DataSource = ds;

            ApplicationGridView.DataBind();

            conn.Close();

        }

        protected void AcceptApplication(object sender, EventArgs e)
        {
            // TODO
        }

        protected void RejectApplication(object sender, EventArgs e)
        {
            // TODO
        }
       
    }
}
