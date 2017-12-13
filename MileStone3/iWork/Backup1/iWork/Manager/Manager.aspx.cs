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

namespace iWork.Manager
{

    public partial class Manager : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] == null) {

                string script = "alert('You are NOT Signed In!!');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);

                Response.Redirect("~/Default.aspx");
            }
                

        }

    }
}
