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

    public partial class Manager_Requests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            cmd.Parameters.Add(new SqlParameter("@start_date", start_date));
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
    }
}
