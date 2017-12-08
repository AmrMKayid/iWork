using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace iWork.Manager
{

    public partial class Manager_Review_Task_Reject : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");

        protected void RejectTask_Clicked(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(NewDeadline.Text))
            {
                string script = "alert(' You NEED to choose new DeadLine for the task');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }

            else
            {
                SqlCommand cmd = new SqlCommand("ReviewTask", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));
                cmd.Parameters.Add(new SqlParameter("@project", Session["NameOfTaskProject"]));
                cmd.Parameters.Add(new SqlParameter("@task", Session["NameOfRejectedTask"]));
                cmd.Parameters.Add(new SqlParameter("@isAccepted", 0));
                cmd.Parameters.Add(new SqlParameter("@newDeadline", NewDeadline.Text));

                conn.Open();
                cmd.ExecuteReader();
                conn.Close();


            }

        }
    }
}
