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

namespace iWork
{

    public partial class Login : System.Web.UI.Page
    {

        protected void login(object sender, EventArgs e)
        {
            // ======> Team Windows 
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
            SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());


            SqlCommand cmd = new SqlCommand("loginweb", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = txt_username.Text;
            string password = txt_password.Text;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            SqlParameter user_type = cmd.Parameters.Add("@user_type", SqlDbType.VarChar);
            user_type.Direction = ParameterDirection.Output;
            user_type.Size = 50;

            SqlParameter error = cmd.Parameters.Add("@error_message", SqlDbType.VarChar);
            error.Direction = ParameterDirection.Output;
            error.Size = 50;

            conn.Open();
            cmd.ExecuteReader();
            conn.Close();

           if (user_type.Value.Equals("R"))
            {
                Session["Username"] = username;
                Response.Write("Passed");
                Response.Redirect("Regular_Employee/Regular_Employee.aspx", true);
            }
            else if (user_type.Value.Equals("M"))
            {
                Session["Username"] = username;
                Response.Write("Passed");
                Response.Redirect("Manager/Manager.aspx", true);
                //Response.Redirect("Manager/Manager_Projects.aspx");
            }
            else if (user_type.Value.Equals("H"))
            {
                Session["Username"] = username;
                Response.Write("Passed");
                Response.Redirect("Staff_Member/Dashboard/Index.aspx", true);
            }
            else if (user_type.Value.Equals("J"))
            {
                Session["Username"] = username;
                Response.Write("Passed");
                Response.Redirect("Job_Seeker/Job_Seeker.aspx", true);
            }
            else
            {
                Response.Write(username + " " + password + " " + user_type.Value + " " + error.Value); // TO SEE What is the Error!!!
                Response.Write("Failed: " + error.Value);
            }
        }
    }
}
