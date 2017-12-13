using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using iWork.Model;

namespace iWork.Manager
{

    public partial class Manager_Requests_Review : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());


        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] == null)
                Response.Redirect("~/Default.aspx");

        }


        protected void AcceptRequest_Clicked(object sender, EventArgs e)
        {

            try
            {
                SqlCommand cmd = new SqlCommand("ReviewRequest", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@start_date", Session["SelectedRequest_start_date"]));
                cmd.Parameters.Add(new SqlParameter("@username", Session["SelectedRequest_Username"]));
                cmd.Parameters.Add(new SqlParameter("@isAccepted", "1"));
                cmd.Parameters.Add(new SqlParameter("@reason", ""));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }


        }

        protected void RejectRequest_Clicked(object sender, EventArgs e)
        {
            if (Reasontxt.Text == "")
            {
                string script = "alert('You Should give a REASON for Rejection!');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("ReviewRequest", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                    cmd.Parameters.Add(new SqlParameter("@start_date", Session["SelectedRequest_start_date"]));
                    cmd.Parameters.Add(new SqlParameter("@username", Session["SelectedRequest_Username"]));
                    cmd.Parameters.Add(new SqlParameter("@isAccepted", "0"));
                    cmd.Parameters.Add(new SqlParameter("@reason", Reasontxt.Text));

                    conn.Open();
                    cmd.ExecuteReader();
                    conn.Close();
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
