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

            if (username == null || !Model.StaffMember.IsStaffMember(username)) // Not a staff member
            {
                // TODO: Status code -> Forbidden
                Response.StatusCode = 403;
                Response.StatusDescription = "Sorry, you are not working in a company, yet.";
                Response.Redirect("../../Default.aspx", true);
            }
            else
            {
                // TODO: View the features available to all Staff Members

                // View features available to only the role of that staff member
                if (Model.HrEmployee.IsHrEmployee(username))
                {
                    HR_Tasks_Panel.Visible = true;
                }
                // TODO: If Manager, view Manager's tasks, i.e. links to Manager-only 
                // TODO: If Regular Employee, view the pages available to them

            }

        }
    }
}