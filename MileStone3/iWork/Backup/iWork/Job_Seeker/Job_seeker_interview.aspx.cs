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

    public partial class Job_seeker_interview : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load the GridView

                if (Session["Applied_job_tittle"] != null && Session["Applied_job_department"] != null && Session["Applied_job_company"] != null)
                {
                    string Applied_job_tittle = Session["Applied_job_tittle"].ToString();
                    string job_department = Session["Applied_job_department"].ToString();
                    string job_company = Session["Applied_job_company"].ToString();

                    //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
                    //SqlConnection conn = new SqlConnection(connStr);

                    SqlDataAdapter cmd = new SqlDataAdapter("viewquestions", conn);
                    cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

                    cmd.SelectCommand.Parameters.Add(new SqlParameter("@jobtitle", Applied_job_tittle));
                    cmd.SelectCommand.Parameters.Add(new SqlParameter("@dep", job_department));
                    cmd.SelectCommand.Parameters.Add(new SqlParameter("@comp", job_company));

                    DataTable dtbl = new DataTable();
                    cmd.Fill(dtbl);
                    Interview_GridView.DataSource = dtbl;
                    Interview_GridView.DataBind();
                }
            }
        }

        protected void View_AStatus(object sender, EventArgs e)
        {

            Response.Write("Passed");
            Response.Redirect("Application_Status.aspx", true);

        }
        protected void Submit_App(object sender, EventArgs e)
        {


            String ans;
            int id;
            int Score = 0;
            //string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);


            foreach (GridViewRow row in Interview_GridView.Rows)
            {

                id = int.Parse(row.Cells[0].Text);
                RadioButtonList rbl = (RadioButtonList)row.FindControl("RadioButtonList1");
                ans = rbl.SelectedItem.Value;

                SqlCommand cmd = new SqlCommand("calculateanswer", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@number", id));
                cmd.Parameters.Add(new SqlParameter("@answer", ans));
                SqlParameter Scoreout = cmd.Parameters.Add("@scoreout", SqlDbType.Int);
                Scoreout.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                int cscore = 0;
                Int32.TryParse(cmd.Parameters["@scoreout"].Value.ToString(), out cscore);
                Score = Score + cscore;

            }
            SqlCommand cmd1 = new SqlCommand("Applyforjob", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd1.Parameters.Add(new SqlParameter("@jobtitle", Session["Applied_job_tittle"].ToString()));
            cmd1.Parameters.Add(new SqlParameter("@dep", Session["Applied_job_department"].ToString()));
            cmd1.Parameters.Add(new SqlParameter("@comp", Session["Applied_job_company"].ToString()));
            cmd1.Parameters.Add(new SqlParameter("@score", Score));


            SqlParameter error = cmd1.Parameters.Add("@error", SqlDbType.VarChar);
            error.Direction = ParameterDirection.Output;
            error.Size = 100;
            conn.Open();
            cmd1.ExecuteNonQuery();
            conn.Close();
            if (error.Value.Equals(""))
            {
                Session["Score"] = Score;
                Response.Redirect("Score", true);
            }
            else
            {
                String x = error.Value.ToString();

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + x.ToString() + "');</script>", false);
            }
        }
    }
}
