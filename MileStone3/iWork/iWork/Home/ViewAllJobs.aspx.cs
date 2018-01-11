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

namespace iWork.Home
{

    public partial class ViewAllJobs : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dsC = new DataTable();
            dsC = null;
            JobsGridView.DataSource = dsC;
            JobsGridView.DataBind();

            string JobsStr = "Select * from Jobs";

            SqlCommand cmd = new SqlCommand(JobsStr, conn);

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            JobsGridView.DataSource = ds;

            JobsGridView.DataBind();

            conn.Close();
        }

        protected void SelectJob_Clicked(object sender, CommandEventArgs e)
        {
            string[] commandArgs = ((sender as Button).CommandArgument).Split(new char[] { ',' });
            string Applied_job_tittle = commandArgs[0];
            string job_department = commandArgs[1];
            string job_company = commandArgs[2];
            Session["Applied_job_tittle"] = Applied_job_tittle;
            Session["Applied_job_department"] = job_department;
            Session["Applied_job_company"] = job_company;

            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd1 = new SqlCommand("Applyforjobcheck", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            if (Session["Username"] != null)
            {
                cmd1.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
                cmd1.Parameters.Add(new SqlParameter("@jobtitle", Session["Applied_job_tittle"].ToString()));
                cmd1.Parameters.Add(new SqlParameter("@dep", Session["Applied_job_department"].ToString()));
                cmd1.Parameters.Add(new SqlParameter("@comp", Session["Applied_job_company"].ToString()));



                SqlParameter error = cmd1.Parameters.Add("@error", SqlDbType.VarChar);
                error.Direction = ParameterDirection.Output;
                error.Size = 100;
                conn.Open();
                cmd1.ExecuteNonQuery();
                conn.Close();
                if (error.Value.Equals(""))
                {
                    Response.Redirect("~/Job_Seeker/Job_seeker_interview.aspx", true);
                }
                else
                {
                    String x = error.Value.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Sign up or Log in!!');</script>", false);
            }

        }
    }
}
