using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Jobs
{
    public partial class QuestionsLibrary : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            AddNewQ_Status_Label.Text = "";

            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;

            if (string.IsNullOrWhiteSpace(username) || !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This library is accessible only to HR employees of companies.";

                QuestionsLibrary_Panel.Visible = false;
                NotHR_Panel.Visible = true;
                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);

                NotHR_Panel.Visible = false;
                QuestionsLibrary_Panel.Visible = true;
            }

            Questions_GridView.DataSource = _hrEmployee.ViewInterviewQuestionsLibrary();
            Questions_GridView.DataBind();
        }

        protected void AddNewQ_Button_Click(object sender, EventArgs e)
        {
            string question = NewQuestion_TextBox.Text;

            bool answer = bool.Parse(AnswerNewQ_DropDownList.SelectedValue);

            if (string.IsNullOrWhiteSpace(question))
                AddNewQ_Status_Label.Text = "Please type the question you want to add.";
            else
            {
                if (_hrEmployee.AddNewQuestionToLibrary(question, answer))
                {
                    NewQuestion_TextBox.Text = "";

                    Questions_GridView.DataSource = _hrEmployee.ViewInterviewQuestionsLibrary();
                    Questions_GridView.DataBind();
                }
                else
                    AddNewQ_Status_Label.Text = "Could not add this question.";
            }
        }

        protected void LoginFirst_Button_Click(object sender, EventArgs e)
            => Response.Redirect("../../../Login.aspx", true);

    }
}