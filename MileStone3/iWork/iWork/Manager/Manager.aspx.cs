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

            //BoundField test = new BoundField();
            //test.DataField = "New DATAfield Name";
            //test.HeaderText = "New Header";
            //grdloadproperties.Columns.Add(test);
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


            SqlCommand cmd = new SqlCommand("ViewNewRequests", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);
            objAdp.Fill(ds);

            //BoundField test = new BoundField();
            //test.DataField = "New DATAfield Name";
            //test.HeaderText = "New Header";
            //grdloadproperties.Columns.Add(test);
            GridView1.DataSource = ds;


            GridView1.DataBind();

            conn.Close();

        }
    }
}
