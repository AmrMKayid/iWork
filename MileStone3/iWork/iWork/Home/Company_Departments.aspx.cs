using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace iWork.Home
{

    public partial class Company_Departments : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dsC = new DataTable();
            dsC = null;
            CompanyDepartmentGridView.DataSource = dsC;
            CompanyDepartmentGridView.DataBind();

            string CompanyDepartment = "Select * from Departments where company=\'" + Session["companyDomian"] + "\'" ;

            SqlCommand cmd = new SqlCommand(CompanyDepartment, conn);

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            CompanyDepartmentGridView.DataSource = ds;

            CompanyDepartmentGridView.DataBind();

            conn.Close();
        }

        protected void viewDepartmentJobs_Clicked(object sender, CommandEventArgs e)
        {

            string departmentCode = CompanyDepartmentGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

            Session["companyDepartmentCode"] = departmentCode;

            Response.Redirect("Company_Department_Jobs.aspx");

        }
    }
}
