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

    public partial class Default : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void login_Clicked(object sender, EventArgs e)
        {
            if (txt_username.Text == "")
            {
                string script = "alert(' You should enter your USERNAME ');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else if (txt_password.Text == "")
            {
                string script = "alert(' You should enter your PASSWORD ');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            else
            {
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


                Session["UsernameType"] = user_type.Value;

                if (user_type.Value.Equals("Regular Employee"))
                {
                    Session["Username"] = username;
                    Response.Write("Passed");
                    Response.Redirect("Regular_Employee/Regular_Employee.aspx", true);
                }
                else if (user_type.Value.Equals("Manager"))
                {
                    Session["Username"] = username;
                    Response.Write("Passed");
                    Response.Redirect("Manager/Manager.aspx", true);
                    //Response.Redirect("Manager/Manager_Projects.aspx");
                }
                else if (user_type.Value.Equals("HR Employee"))
                {
                    Session["Username"] = username;
                    Response.Write("Passed");
                    Response.Redirect("Staff_Member/Dashboard/Index.aspx", true);
                }
                else if (user_type.Value.Equals("Job Seeker"))
                {
                    Session["Username"] = username;
                    Response.Write("Passed");
                    Response.Redirect("Job_Seeker/Job_Seeker.aspx", true);
                }
                else
                {
                    String x = error.Value.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);

                }
            }
        }


        protected void singup_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("Home/Register.aspx");
        }
    }
}
