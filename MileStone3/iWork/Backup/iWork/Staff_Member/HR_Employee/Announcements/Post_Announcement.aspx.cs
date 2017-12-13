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
            string username = Session["Username"]?.ToString();

            if(username == null || !Model.HrEmployee.IsHrEmployee(username))
            {
                // TODO: Status code -> Forbidden
                Response.StatusCode = 403;
                Response.StatusDescription = "Page accessible only to HR Employees";
                Response.Redirect("../../../Default.aspx", true);
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);
            }
            
        }

        protected void PostAnnouncement_Button_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(A_Title_TextBox.Text))
                Response.Write("Please provide a title for the announcement.");
            else
            {
                if (_hrEmployee?.PostAnnouncement(
                    A_Title_TextBox.Text,
                    string.IsNullOrWhiteSpace(A_Type_TextBox.Text) ? null : A_Type_TextBox.Text,
                    A_Desc_TextBox.Text) ?? false)
                {
                    Response.Write("Announcement posted!");
                }
                else
                {
                    Response.Write("Failed to post announcement.");
                }
            }
        }
    }
}