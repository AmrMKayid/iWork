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

    public partial class Companies : System.Web.UI.Page
    {

        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dsC = new DataTable();
            dsC = null;
            CompanyGridView.DataSource = dsC;
            CompanyGridView.DataBind();

            string AllCompanies = "Select C.*, avg(salary) as salary from Companies C Inner join Staff_Members S on C.domain = S.company group by C.name, C.domain, C.email, C.address, C.type, C.specialization, C.vision  order by avg(S.salary) desc";

            SqlCommand cmd = new SqlCommand(AllCompanies, conn);

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);

            objAdp.Fill(ds);

            CompanyGridView.DataSource = ds;

            CompanyGridView.DataBind();

            conn.Close();
        }

        protected void SelectCompany_Clicked(object sender, CommandEventArgs e)
        {

            string companyDomian = CompanyGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;

            Session["companyDomian"] = companyDomian;

            Response.Redirect("Company_Departments.aspx");

        }
    }
}
