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

namespace iWork
{
    public partial class Register : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(DbHelper.GetConnectionString());

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register_Button_Click(object sender, EventArgs e)
        {

            string username = Username_TextBox.Text;
            string password = Password_TextBox.Text;

            string firstName = FirstName_TextBox.Text;
            string middleName = MiddleName_TextBox.Text;
            string lastName = LastName_TextBox.Text;

            string email = Email_TextBox.Text;

            DateTime birthdate = DateTime.MinValue;
            int yearsOfExperience = 0;

            if(string.IsNullOrWhiteSpace(BirthDate_TextBox.Text)
                || !DateTime.TryParse(BirthDate_TextBox.Text, out birthdate))
            {
                Response.Write("Please provide your birthdate");
                return;
            }

            if (string.IsNullOrWhiteSpace(YearsOfExperience_TextBox.Text))
                yearsOfExperience = 0;
            else if(!int.TryParse(YearsOfExperience_TextBox.Text, out yearsOfExperience))
            {
                Response.Write("Please provide valid number of years to show how much is your experience so far");
                return;
            }

            if(Model.User.Register(
                username, password, email, firstName, middleName, lastName, birthdate, yearsOfExperience))
            {
                Response.Write("Welcome to iWork!");
                Response.Redirect("Login.aspx", true);
                return;
            }
            else
            {
                Response.Write("Failed to register");
                return;
            }

        }
    }
}