using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.Dashboard
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;
            usernameUpperRight_Label.Text = username;

            if (string.IsNullOrWhiteSpace(username) || !Model.StaffMember.IsStaffMember(username)) // Not a staff member
            {
                // Status code -> Forbidden
                Response.StatusCode = 403;
                Response.StatusDescription = "Sorry, you are not working in a company, yet.";

                NotStaffMember_Panel.Visible = true;
                Manager_Tasks_Nav_Panel.Visible = false;
                HR_Tasks_Panel.Visible = false;
                MainContent_Panel.Visible = false;
                return;
            }
            else
            {
                NotStaffMember_Panel.Visible = false;
                MainContent_Panel.Visible = true;

                // TODO: View the features available to all Staff Members

                // View features available to only the role of that staff member
                HR_Tasks_Panel.Visible = Model.HrEmployee.IsHrEmployee(username);
                // TODO: If Manager, view Manager's tasks, i.e. links to Manager-only
                Manager_Tasks_Nav_Panel.Visible = Model.Manager.IsManager(username);
                // TODO: If Regular Employee, view the pages available to them


                BindData();
                p_BindData(Session["Username"].ToString());
            }

        }

        protected void LoginFirst_LinkButton_Click(object sender, EventArgs e) =>
            Response.Redirect("../../Default.aspx", true);

        protected void BindData()

        {


            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("Viewuserinfo", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;
            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            DataSet ds = new DataSet();

            DataTable FromTable = new DataTable();

            conn.Open();



            cmd.Fill(ds);

            DataList1.DataSource = ds.Tables[0];

            DataList1.DataBind();
            conn.Close();

        }

        protected void Change_years_of_exp(object sender, EventArgs e)
        {
            String p = yofexp.SelectedItem.Text;
            int y = Convert.ToInt32(p);
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituseryofe", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newyofe", y));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();


        }

        protected void Change_date(object sender, EventArgs e)
        {
            String d = day.SelectedItem.Text;
            String m = Month.SelectedItem.Text;
            String y = Year.SelectedItem.Text;
            String date = y + "/" + m + "/" + d;

            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituserbd", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newbd", date));

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }

        protected void Change_first(object sender, EventArgs e)
        {
            String x = fn.Value;

            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituserfn", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newfn", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }
        protected void Change_middle(object sender, EventArgs e)
        {
            String x = mn.Value;
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("editusermn", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newmn", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }
        protected void Change_last(object sender, EventArgs e)
        {
            String x = ln.Value;
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituserln", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newln", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }
        protected void Change_password(object sender, EventArgs e)
        {
            String x = pass.Value;
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituserpassword", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newpassword", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }
        protected void Change_email(object sender, EventArgs e)
        {
            String x = email.Value;
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("edituseremail", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@newemail", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            BindData();

        }
        protected void p_BindData(String username)
        {
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlDataAdapter cmd = new SqlDataAdapter("Viewuserpj", conn);
            cmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            cmd.SelectCommand.Parameters.Add(new SqlParameter("@username", username));
            DataTable dtbl = new DataTable();
            cmd.Fill(dtbl);
            Previous.DataSource = dtbl;
            Previous.DataBind();
        }

        protected void deleteprevious(object sender, EventArgs e)
        {
            String x = Convert.ToString(((sender as Button).CommandArgument));
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("delete_previous", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@title", x));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            p_BindData(Session["Username"].ToString());


        }

        protected void Addprevious(object sender, EventArgs e)
        {
            String x = new_previous.Text;
            string connStr = Model.DbHelper.GetConnectionString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("insert_previous", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@title", x));
            SqlParameter error = cmd.Parameters.Add("@error", SqlDbType.VarChar);
            error.Direction = ParameterDirection.Output;
            error.Size = 50;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (error.Value.Equals(""))
            {
                p_BindData(Session["Username"].ToString());
            }
            else
            {
                String k = error.Value.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('" + k.ToString() + "');</script>", false);
            }

        }

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../../Default.aspx", true);
        }
    }
}