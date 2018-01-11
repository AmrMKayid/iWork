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
            UpdateJob_Status_Label.Text = "";
            AddQuestion_Status_Label.Text = "";

            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;
            usernameUpperRight_Label.Text = username;

            if (string.IsNullOrWhiteSpace(username)|| !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is available for HR employees only.";

                EditJob_Panel.Visible = false;
                NotHR_Panel.Visible = true;
                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);

                NotHR_Panel.Visible = false;
                EditJob_Panel.Visible = true;
            }

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

                FormatJobQuestionsGridView();
                FormatApplicationsGridView();

                JobQuestions_GridView.DataSource = _job.GetQuestions();
                JobQuestions_GridView.DataBind();

                NewQuestion_DropDownList.DataSource = _interviewQuestions;
                NewQuestion_DropDownList.DataBind();

                List<Model.JobApplication> applications = _hrEmployee.GetPendingJobApplications(job_title);
                Applications_GridView.DataSource = _hrEmployee.GetPendingJobApplications(job_title);
                Applications_GridView.DataBind();
                NoNewApplications_Label.Visible = applications.Count == 0;
            }

        }

        protected void Save_Button_Click(object sender, EventArgs e)
        {

            decimal working_hours = 0;

            if(!decimal.TryParse(WorkingHours_TextBox.Text, out working_hours))
            {
                UpdateJob_Status_Label.Text = "Please provide valid working hours";
                return;
            }

            decimal salary = 0;

            if (!decimal.TryParse(Salary_TextBox.Text, out salary))
            {
                UpdateJob_Status_Label.Text = "Please provide valid salary";
                return;
            }

            int minYearsOfXp = 0;

            if (!int.TryParse(MinYearsOfXp_TextBox.Text, out minYearsOfXp))
            {
                UpdateJob_Status_Label.Text = "Please provide valid minimum years of experience";
                return;
            }

            int vacancy = 0;

            if (!int.TryParse(Vacancy_TextBlock.Text, out vacancy))
            {
                UpdateJob_Status_Label.Text = "Please provide valid number of vacanies";
                return;
            }

            DateTime deadline = DateTime.MinValue;

            if (!DateTime.TryParse(Deadline_TextBox.Text, out deadline))
            {
                UpdateJob_Status_Label.Text = "Please provide valid deadline";
                return;
            }

            if (_hrEmployee.EditJob(JobTitle_TextBox.Text,
                working_hours,
                salary,
                minYearsOfXp,
                vacancy,
                deadline,
                Job_ShortDesc_TextBox.Text, Job_DetailDesc_TextBox.Text))

                UpdateJob_Status_Label.Text = "Updated successfully!";

            else
                UpdateJob_Status_Label.Text = "Could not update job information";
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

        protected void JobQuestions_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e?.CommandArgument == null) return;

            int qid = int.Parse(e.CommandArgument.ToString());

            List<Model.JobInterviewQuestion> questions = _job.GetQuestions();

            if (_hrEmployee.DeleteQuestionFromJob(questions[qid].ID, _job.Title))
            {
                AddQuestion_Status_Label.Text = "Question removed successfully.";

                JobQuestions_GridView.DataSource = _job.GetQuestions();
                JobQuestions_GridView.DataBind();
            }
            else
                AddQuestion_Status_Label.Text = "Could not remove this question from the job.";

        }

        protected void AddQuestion_Button_Click(object sender, EventArgs e)
        {
            // Get the selected Question as an object
            int selIndex = NewQuestion_DropDownList.SelectedIndex;
            
            Model.JobInterviewQuestion question = _interviewQuestions[selIndex];

            // Now that we have the object, we can get its id and pass it to the Hr method
            if(_hrEmployee.AddQuestionToJob(question.ID, _job.Title))
                AddQuestion_Status_Label.Text = "Question added successfully.";
            else
                AddQuestion_Status_Label.Text = "Could not add that question to this job";

            JobQuestions_GridView.DataSource = _job.GetQuestions();
            JobQuestions_GridView.DataBind();

            NewQuestion_DropDownList.DataSource = _interviewQuestions;
            NewQuestion_DropDownList.DataBind();
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

            List<Model.JobApplication> applications = _hrEmployee.GetPendingJobApplications(_job.Title);

            Response.Redirect("ViewJobApplication.aspx?id=" + applications[i_app].ID.ToString(), true);
        }

        protected void LoginFirst_Button_Click(object sender, EventArgs e)
            => Response.Redirect("../../../Default.aspx", true);

        protected void LogOut_LinkButton_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("../../../Default.aspx", true);
        }

    }
}