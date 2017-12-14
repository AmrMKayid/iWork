using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Register
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RegisterStatus_Label.Text = "";
        }

        protected void Register_Button_Click(object sender, EventArgs e)
        {

            string username = Username_TextBox.Value;
            string password = Password_TextBox.Value;

            if (string.IsNullOrWhiteSpace(username))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide a valid username');</script>", false);

                //RegisterStatus_Label.Text = "Please provide a valid username";
                return;
            }

            if (Model.User.IsUser(username))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Sorry, this username has already been taken in iWork.');</script>", false);
                //RegisterStatus_Label.Text = "";
                return;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide a valid password');</script>", false);
                //RegisterStatus_Label.Text = "";
                return;
            }

            string firstName = FirstName_TextBox.Value;
            string middleName = MiddleName_TextBox.Value;
            string lastName = LastName_TextBox.Value;

            if (string.IsNullOrWhiteSpace(firstName) || string.IsNullOrWhiteSpace(firstName))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide us with your first and last names');</script>", false);
                //RegisterStatus_Label.Text = "";
                return;
            }

            string email = Email_TextBox.Value;

            if (string.IsNullOrWhiteSpace(email) ||
                email.Split(new char[] { '@' }, StringSplitOptions.RemoveEmptyEntries).Length != 2)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide us with your email address');</script>", false);
                //RegisterStatus_Label.Text = "";
                return;
            }

            DateTime birthdate = DateTime.MinValue;
            int yearsOfExperience = 0;

            if (string.IsNullOrWhiteSpace(BirthDate_TextBox.Value)
                || !DateTime.TryParse(BirthDate_TextBox.Value, out birthdate))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide your birthdate');</script>", false);
                //RegisterStatus_Label.Text = "e";
                return;
            }

            if (string.IsNullOrWhiteSpace(YearsOfExperience_TextBox.Value))
                yearsOfExperience = 0;
            else if (!int.TryParse(YearsOfExperience_TextBox.Value, out yearsOfExperience))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Please provide valid number of years to show how much is your experience so far');</script>", false);
                //RegisterStatus_Label.Text = "";
                return;
            }

            if (Model.User.Register(
                username, password, email, firstName, middleName, lastName, birthdate, yearsOfExperience))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Welcome to iWork!');</script>", false);
                //RegisterStatus_Label.Text = "";
                Session["Username"] = username;
                Response.Redirect("../Job_Seeker/Job_Seeker.aspx", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "<script>alert('Failed to register');</script>", false);
                //RegisterStatus_Label.Text = "";
            }

        }
        
    }
}