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

    public partial class searched_jobs : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["searched_job"] != null)
            {
                string searched_jobs = Session["searched_job"].ToString();
                display_searched_jobs(searched_jobs);
            }
        }
        protected void display_searched_jobs(String search)
        {
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("searchforjob", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@word", search));
            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            Searched_jobsGridView.DataSource = dtbl;
            Searched_jobsGridView.DataBind();
        }
        protected void View_AStatus(object sender, EventArgs e)
        {

            Response.Write("Passed");
            Response.Redirect("Application_Status.aspx", true);

        }

        protected void Apply_Clicked(object sender, EventArgs e)
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
                Response.Redirect("Job_seeker_interview.aspx", true);
            }
            else
            {
                String x = error.Value.ToString();

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);
            }





        }

    }
}
