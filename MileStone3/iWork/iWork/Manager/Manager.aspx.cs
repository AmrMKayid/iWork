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

    public partial class Manager : System.Web.UI.Page
    {

        protected void ViewNewRequests(object sender, EventArgs e)
        {

            //TODO: Redirect to New Page for REQUESTS
            Response.Redirect("Manager_Requests.aspx");
        }

       //########################################################################################//

        protected void ViewNewApplications(object sender, EventArgs e)
        {

            //TODO: Redirect to New Page for Application

            Response.Redirect("Manager_Applications.aspx");

        }


        //########################################################################################//
       
        protected void NewProjectClicked(object sender, EventArgs e)
        {
            // TODO
            Response.Redirect("Manager_Projects.aspx");
        }

        //########################################################################################//
    }
}
