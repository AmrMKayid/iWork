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

            //string departmentCode = CompanyDepartmentJobsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

            //Session["companyDepartmentCode"] = departmentCode;

            //Response.Redirect("Company_Departments.aspx");

        }
    }
}
