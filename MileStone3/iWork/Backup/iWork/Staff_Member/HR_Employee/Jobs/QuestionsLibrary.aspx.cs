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
            string username = Session["Username"]?.ToString();

            if (username == null || !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This library is accessible only to HR employees of companies.";
                Response.Write(Response.StatusDescription);
                return;
            }
            else
                _hrEmployee = new Model.HrEmployee(username);

            Questions_GridView.DataSource = _hrEmployee.ViewInterviewQuestionsLibrary();
            Questions_GridView.DataBind();
        }

        protected void AddNewQ_Button_Click(object sender, EventArgs e)
        {
            string question = NewQuestion_TextBox.Text;
            bool answer = bool.Parse(AnswerNewQ_DropDownList.SelectedValue);

            if(string.IsNullOrWhiteSpace(question))
            {
                Response.Write("Please write the question you want to add.");
            }
            else
            {
                if(_hrEmployee.AddNewQuestionToLibrary(question, answer))
                {
                    NewQuestion_TextBox.Text = "";

                    Questions_GridView.DataSource = _hrEmployee.ViewInterviewQuestionsLibrary();
                    Questions_GridView.DataBind();
                }
                else
                {
                    Response.Write("Could not add this question.");
                }
            }
        }
    }
}