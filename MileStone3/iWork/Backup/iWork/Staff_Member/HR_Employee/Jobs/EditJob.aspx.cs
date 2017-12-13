using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Jobs
{
    public partial class EditJob : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        private Model.Job _job = null;

        private List<Model.JobInterviewQuestion> _interviewQuestions = null;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                FormatApplicationsGridView();
                FormatJobQuestionsGridView();
            }

            string username = Session["Username"]?.ToString();

            if (username == null || !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is available for HR employees only.";
                Response.Write(Response.StatusDescription
                    + " If you are an HR Employee, please make sure you are logged in.");
                return;
            }
            else
                _hrEmployee = new Model.HrEmployee(username);

            string job_title = Request.QueryString["title"];

            if (string.IsNullOrWhiteSpace(job_title)) return;

            Model.Job hrJob = _hrEmployee.GetJob();

            _job = new Model.Job(job_title, hrJob.DepartmentCode, hrJob.CompanyDomain);

            _interviewQuestions = _hrEmployee.ViewInterviewQuestionsLibrary();

            if (!IsPostBack)
            {
                JobTitle_TextBox.Text = job_title;

                WorkingHours_TextBox.Text = _job.WorkingHours?.ToString();
                Salary_TextBox.Text = _job.Salary?.ToString();
                MinYearsOfXp_TextBox.Text = _job.MinYearsOfExperience?.ToString();

                Vacancy_TextBlock.Text = _job.Vacancy?.ToString();
                Deadline_TextBox.Text = _job.Deadline?.ToString();

                Job_ShortDesc_TextBox.Text = _job.ShortDescription;
                Job_DetailDesc_TextBox.Text = _job.DetailedDescription;
    
                NewQuestion_DropDownList.DataSource = _interviewQuestions;
                NewQuestion_DropDownList.DataBind();
            }

            JobQuestions_GridView.DataSource = _job.GetQuestions();
            JobQuestions_GridView.DataBind();

            Applications_GridView.DataSource = _hrEmployee.GetPendingJobApplications(job_title);
            Applications_GridView.DataBind();

        }

        private void FormatApplicationsGridView()
        {
            Applications_GridView.AutoGenerateColumns = false;

            Applications_GridView.DataKeyNames = new string[] { nameof(Model.JobApplication.ID) };

            Applications_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobApplication.ID),
                HeaderText = "Application ID",
                ReadOnly = true
            });

            Applications_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobApplication.ApplicantUsername),
                HeaderText = "applicant",
                ReadOnly = true
            });

            Applications_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobApplication.Score),
                HeaderText = "score",
                ReadOnly = true
            });

            Applications_GridView.Columns.Add(new ButtonField()
            {
                ShowHeader = false,
                Text = "Details",
                CommandName = "RVW",
                ButtonType = ButtonType.Button
            });
        }

        protected void Applications_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e?.CommandArgument == null) return;

            int i_app = int.Parse(e.CommandArgument.ToString());

            List<Model.JobApplication> applications = (List<Model.JobApplication>)Applications_GridView.DataSource;

            Response.Redirect("ViewJobApplication.aspx?id=" + applications[i_app].ID.ToString(), true);
        }

        protected void Save_Button_Click(object sender, EventArgs e)
        {
            if( _hrEmployee.EditJob(JobTitle_TextBox.Text,
                decimal.Parse(WorkingHours_TextBox.Text),
                decimal.Parse(Salary_TextBox.Text),
                int.Parse(MinYearsOfXp_TextBox.Text),
                int.Parse(Vacancy_TextBlock.Text),
                DateTime.Parse(Deadline_TextBox.Text),
                Job_ShortDesc_TextBox.Text, Job_DetailDesc_TextBox.Text))
            {
                Response.Write("Updated successfully!");
            }
            else
                Response.Write("Could not update job information");
        }

        private void FormatJobQuestionsGridView()
        {
            JobQuestions_GridView.AutoGenerateColumns = false;

            JobQuestions_GridView.DataKeyNames = new string[] { nameof(Model.JobInterviewQuestion.ID) };

            JobQuestions_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobInterviewQuestion.ID),
                ReadOnly = true,
                HeaderText = "ID"
            });

            JobQuestions_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobInterviewQuestion.Question),
                ReadOnly = true,
                HeaderText = "Question"
            });

            JobQuestions_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.JobInterviewQuestion.Answer),
                ReadOnly = true,
                HeaderText = "Answer"
            });

            JobQuestions_GridView.Columns.Add(new ButtonField()
            {
                ButtonType = ButtonType.Button,
                Text = "Delete",
                ShowHeader = false,
                CommandName = "RMV"
            });
        }

        protected void AddQuestion_Button_Click(object sender, EventArgs e)
        {
            // Get the selected Question as an object
            int selIndex = NewQuestion_DropDownList.SelectedIndex;
            
            Model.JobInterviewQuestion question = _interviewQuestions[selIndex];

            // Now that we have the object, we can get its id and pass it to the Hr method
            if(_hrEmployee.AddQuestionToJob(question.ID, _job.Title))
                Response.Write("Question added successfully.");
            else
                Response.Write("Could not add that question to this job");

            JobQuestions_GridView.DataSource = _job.GetQuestions();
            JobQuestions_GridView.DataBind();

            NewQuestion_DropDownList.DataSource = _interviewQuestions;
            NewQuestion_DropDownList.DataBind();
        }

        protected void JobQuestions_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e?.CommandArgument == null) return;

            int qid = int.Parse(e.CommandArgument.ToString());

            List<Model.JobInterviewQuestion> questions =
                (List<Model.JobInterviewQuestion>)JobQuestions_GridView.DataSource;

            if( _hrEmployee.DeleteQuestionFromJob(questions[qid].ID, _job.Title))
            {
                Response.Write("Question removed successfully.");

                JobQuestions_GridView.DataSource = _job.GetQuestions();
                JobQuestions_GridView.DataBind();
            }
            else
                Response.Write("Could not remove this question from the job.");

        }
    }
}