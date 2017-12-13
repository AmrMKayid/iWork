using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iWork.Model;


namespace iWork.Job_Seeker
{

    public partial class Score : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Score"] != null)
            {
                string users = Session["Score"].ToString();
                Response.Write(users);
            }
        }
    }
}
