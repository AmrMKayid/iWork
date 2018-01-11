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

    public partial class Manager_Requests : System.Web.UI.Page
    {

        //SqlConnection conn = new SqlConnection(@"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017");
        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Username"] == null)
                Response.Redirect("~/Default.aspx");

            try
            {
                SqlCommand cmd = new SqlCommand("ViewNewRequests", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@manager", Session["Username"]));

                conn.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter objAdp = new SqlDataAdapter(cmd);
                objAdp.Fill(ds);

                RequestsGridView.DataSource = ds;


                RequestsGridView.DataBind();

                conn.Close();
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void SelectRequest_Clicked(object sender, CommandEventArgs e)
        {
            try
            {
                string username = RequestsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string start_date = RequestsGridView.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;

                SqlCommand cmd = new SqlCommand("Select type from Leave_Requests where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestType = (string)cmd.ExecuteScalar();
                conn.Close();

                SqlCommand cmd2 = new SqlCommand("Select destination from Business_Trips where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestDest = (string)cmd2.ExecuteScalar();
                conn.Close();

                SqlCommand cmd3 = new SqlCommand("Select purpose from Business_Trips where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestPurpose = (string)cmd3.ExecuteScalar();
                conn.Close();

                Session["SelectedRequest_Username"] = username;
                Session["SelectedRequest_start_date"] = start_date;

                //Response.Redirect("Manager_Requests_Review.aspx");

                if (requestType != null || requestType != "")
                {
                    Session["SelectedRequest_Type"] = requestType;
                    Response.Redirect("Manager_Requests_Review.aspx");
                }
                else
                {
                    Session["SelectedRequest_Dest"] = requestDest;
                    Session["SelectedRequest_Purp"] = requestPurpose;
                    Response.Redirect("Manager_Requests_Review.aspx");
                }
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void TypeOfRequest_Clicked(object sender, EventArgs e)
        {
            try
            {
                string[] commandArgs = ((sender as Button).CommandArgument).Split(new char[] { ',' });
                string username = commandArgs[0];
                string start_date = commandArgs[1];

                SqlCommand cmd = new SqlCommand("Select type from Leave_Requests where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestType = (string)cmd.ExecuteScalar();
                conn.Close();

                SqlCommand cmd2 = new SqlCommand("Select destination from Business_Trips where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestDest = (string)cmd2.ExecuteScalar();
                conn.Close();

                SqlCommand cmd3 = new SqlCommand("Select purpose from Business_Trips where start_date=\'" + start_date + "\' and username=\'" + username + "\'", conn);
                conn.Open();
                string requestPurpose = (string)cmd3.ExecuteScalar();
                conn.Close();


                if (requestType != "" && requestType != null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('This is a Leave Request, Type: " + requestType + "');</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('This is a Business Trip Request, Destination" + requestDest + ", Purpose: " + requestPurpose + " ');</script>", false);
                }
            }
            catch (SqlException ee)
            {
                string script = "alert('" + ee.Message + "');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../Default.aspx", true);
        }

    }
}
