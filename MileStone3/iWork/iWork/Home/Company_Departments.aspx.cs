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

    public partial class Company_Departments : System.Web.UI.Page
    {
        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dsC2 = new DataTable();
            dsC2 = null;
            CompanyGridView.DataSource = dsC2;
            CompanyGridView.DataBind();

            string AllCompanies = "Select C.*, avg(salary) as salary from Companies C Inner join Staff_Members S on C.domain = S.company group by C.name, C.domain, C.email, C.address, C.type, C.specialization, C.vision having C.domain=\'" + Session["companyDomian"].ToString() + "\' order by avg(S.salary) desc";

            SqlCommand cmd2 = new SqlCommand(AllCompanies, conn);

            conn.Open();

            DataSet ds2 = new DataSet();
            SqlDataAdapter objAdp2 = new SqlDataAdapter(cmd2);

            objAdp2.Fill(ds2);

            CompanyGridView.DataSource = ds2;

            CompanyGridView.DataBind();

            conn.Close();


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
