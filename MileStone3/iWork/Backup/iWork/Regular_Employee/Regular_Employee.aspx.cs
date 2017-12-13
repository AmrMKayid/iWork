using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Regular_Employee
{

    public partial class Regular_Employee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string userId = Session["Username"].ToString();

            }
        }
        protected void View_projects(object sender, EventArgs e)
        {

            Response.Redirect("projects.aspx", true);
        }


    }
}
