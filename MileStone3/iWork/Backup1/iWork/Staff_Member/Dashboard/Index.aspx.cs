using System;
using System.Collections.Generic;
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

            }

        }

        protected void LoginFirst_LinkButton_Click(object sender, EventArgs e) =>
            Response.Redirect("../../Login.aspx", true);
        
    }
}