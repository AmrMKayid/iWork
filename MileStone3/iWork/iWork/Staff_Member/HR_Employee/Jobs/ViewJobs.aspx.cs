using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Jobs
{
    public partial class ViewJobs : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            SubmitJob_Status_Label.Text = "";

            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;
            usernameUpperRight_Label.Text = username;

            if (string.IsNullOrWhiteSpace(username)|| !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "You have to be an HR Employee to view this page.";

                NewJob_Panel.Visible = false;
                ViewJobs_Panel.Visible = false;
                NotHR_Panel.Visible = true;
                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);

                NotHR_Panel.Visible = false;
                ViewJobs_Panel.Visible = true;
                NewJob_Panel.Visible = true;
            }

            if (!IsPostBack)
                FormatJobsGridView();

            Jobs_GridView.DataSource = _hrEmployee.GetJobsInDepartment();
            Jobs_GridView.DataBind();
        }

        private void FormatJobsGridView()
        {
            Jobs_GridView.AutoGenerateColumns = false;

            Jobs_GridView.DataKeyNames = new string[]
            {
                nameof(Model.Job.Title), nameof(Model.Job.DepartmentCode), nameof(Model.Job.CompanyDomain)
            };

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.Title),
                HeaderText = "title"
            });

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.MinYearsOfExperience),
                HeaderText = "minimum years of experience"
            });

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.Vacancy),
                HeaderText = "vacancy"
            });

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.Salary),
                HeaderText = "salary"
            });

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.WorkingHours),
                HeaderText = "working hours"
            });

            Jobs_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Job.Deadline),
                HeaderText = "app deadline"
            });

            Jobs_GridView.Columns.Add(new ButtonField()
            {
                Text = "View/Edit",
                ShowHeader = false,
                ButtonType = ButtonType.Button
            });

        }

        protected void Jobs_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e?.CommandArgument == null) return;

            int i_job = int.Parse(e.CommandArgument.ToString());
            string job_title = ((List<Model.Job>)Jobs_GridView.DataSource)[i_job].Title;

            Response.Redirect("EditJob.aspx?title=" + System.Net.WebUtility.UrlEncode(job_title), true);
        }

        protected void Submit_Button_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrWhiteSpace(JobTitle_TextBox.Text))
            {
                SubmitJob_Status_Label.Text = "Please provide job title";
                return;
            }

            // Prepare job title
            string title = JobRole_DropdownList.SelectedValue + " - " + JobTitle_TextBox.Text;

            // Prepare working hours
            decimal working_hours = 0;

            if (!decimal.TryParse(WorkingHours_TextBox.Text, out working_hours))
            {
                SubmitJob_Status_Label.Text = "Please provide valid working hours";
                return;
            }

            decimal salary = 0;

            if (!decimal.TryParse(Salary_TextBox.Text, out salary))
            {
                SubmitJob_Status_Label.Text = "Please provide valid salary";
                return;
            }

            int min_years_exp = 0;

            if(!int.TryParse(MinYearsOfXp_TextBox.Text, out min_years_exp))
            {
                SubmitJob_Status_Label.Text = "Please provide valid minimum years of experience";
                return;
            }

            int vacancy = 0;

            if(!int.TryParse(Vacancy_TextBlock.Text, out vacancy))
            {
                SubmitJob_Status_Label.Text = "Please provide valid number of vacanies";
                return;
            }

            DateTime deadline = DateTime.MinValue;

            if(DateTime.TryParse(Deadline_TextBox.Text, out deadline))
            {
                SubmitJob_Status_Label.Text = "Please provide valid deadline date";
                return;
            }

            if (_hrEmployee.AddJob(title, working_hours, min_years_exp, salary,
                Job_ShortDesc_TextBox.Text, Job_DetailDesc_TextBox.Text, deadline, vacancy))
            {
                SubmitJob_Status_Label.Text = "Job created successfully!";
                Response.Redirect("EditJob.aspx?title=" + System.Net.WebUtility.UrlEncode(title), true);
            }
            else
            {
                SubmitJob_Status_Label.Text = "Could not create this job";
            }
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