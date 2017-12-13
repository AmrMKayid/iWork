using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iWork.Model;

namespace iWork.Job_Seeker
{

    public partial class Application_Status : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string userId = Session["Username"].ToString();
                Show_status(userId);
            }

        }
        protected void Show_status(String username)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("viewapplicationstatus", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", username));
            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            Applications.DataSource = dtbl;
            Applications.DataBind();
        }
        protected void delete_App(object sender, EventArgs e)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("deletejobapp", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (Session["Username"] != null)
            {
                String username = Session["Username"].ToString();
                cmd.Parameters.Add(new SqlParameter("@username", username));
                int hid = Convert.ToInt32(((sender as Button).CommandArgument));
                cmd.Parameters.Add(new SqlParameter("@id", hid));
                SqlParameter error = cmd.Parameters.Add("@error_message", SqlDbType.VarChar);
                error.Direction = ParameterDirection.Output;
                error.Size = 50;

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();


                if (error.Value.Equals(""))
                {
                    Show_status(username);
                }
                else
                {
                    String x = error.Value.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);
                }
            }

        }
        protected void Choose_App(object sender, EventArgs e)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("chooseajob", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            if (Session["Username"] != null)
            {
                String username = Session["Username"].ToString();
                cmd.Parameters.Add(new SqlParameter("@username", username));
                int hid = Convert.ToInt32(((sender as Button).CommandArgument));
                cmd.Parameters.Add(new SqlParameter("@appid", hid));
                SqlParameter error = cmd.Parameters.Add("@success", SqlDbType.VarChar);
                error.Direction = ParameterDirection.Output;
                error.Size = 100;
                String day_off = dayoff.SelectedValue;
                cmd.Parameters.Add(new SqlParameter("@dayoff", day_off));
                conn.Open();
                cmd.ExecuteReader();
                conn.Close();


                if (error.Value.Equals("error"))
                {
                    String x = error.Value.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);

                }
                else
                {
                    Response.Redirect("~/DefaultSigned.aspx", true);
                }
            }

        }
        protected void View_AStatus(object sender, EventArgs e)
        {

            Response.Write("Passed");
            Response.Redirect("Application_Status.aspx", true);

        }


    }
}
