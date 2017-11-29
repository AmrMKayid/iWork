using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace iWork
{

    public partial class Manager : System.Web.UI.Page
    {
        protected void ViewNewRequests(object sender, EventArgs e) {

            SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");


            SqlCommand cmd = new SqlCommand("ViewNewRequests", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

            conn.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter objAdp = new SqlDataAdapter(cmd);
            objAdp.Fill(ds);

            grdloadproperties.DataSource = ds;

            grdloadproperties.DataBind();

            conn.Close();

        }
    }
}
