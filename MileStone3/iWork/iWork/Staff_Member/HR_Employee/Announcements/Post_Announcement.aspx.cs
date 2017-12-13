using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Announcements
{
    public partial class Post_Announcement : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            PostStatusResult_Label.Text = "";

            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;
            usernameUpperRight_Label.Text = username;

            if(string.IsNullOrWhiteSpace(username) || !Model.HrEmployee.IsHrEmployee(username))
            {
                // Status code -> Forbidden
                Response.StatusCode = 403;
                Response.StatusDescription = "Page accessible only to HR Employees";

                PostAnnouncement_Panel.Visible = false;
                NotHR_Panel.Visible = true;
                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);

                NotHR_Panel.Visible = false;
                PostAnnouncement_Panel.Visible = true;
            }
            
        }

        protected void PostAnnouncement_Button_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(A_Title_TextBox.Text))
                PostStatusResult_Label.Text = "Please provide a title for the announcement.";
            else
            {
                if (_hrEmployee?.PostAnnouncement(
                    A_Title_TextBox.Text,
                    string.IsNullOrWhiteSpace(A_Type_TextBox.Text) ? null : A_Type_TextBox.Text,
                    A_Desc_TextBox.Text) ?? false)

                    PostStatusResult_Label.Text = "Announcement posted!";

                else
                    PostStatusResult_Label.Text = "Failed to post announcement.";

            }
        }

        protected void LoginFirst_Button_Click(object sender, EventArgs e) =>
            Response.Redirect("../../../Default.aspx", true);

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../../../Default.aspx", true);
        }

    }
}