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

    public partial class Company_Department_Jobs : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dsC = new DataTable();
            dsC = null;
            CompanyDepartmentJobsGridView.DataSource = dsC;
            CompanyDepartmentJobsGridView.DataBind();

            string CompanyDepartment = "Select * from Jobs where company=\'" + Session["companyDomian"] + "\' AND department=\'" + Session["companyDepartmentCode"] + "\'";

            SqlCommand cmd = new SqlCommand(CompanyDepartment, conn);

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            CompanyDepartmentJobsGridView.DataSource = ds;

            CompanyDepartmentJobsGridView.DataBind();

            conn.Close();
        }

        protected void viewJob_Clicked(object sender, CommandEventArgs e)
        {

            //string departmentCode = CompanyDepartmentJobsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

            //Session["companyDepartmentCode"] = departmentCode;

            //Response.Redirect("Company_Departments.aspx");

        }
    }
}
