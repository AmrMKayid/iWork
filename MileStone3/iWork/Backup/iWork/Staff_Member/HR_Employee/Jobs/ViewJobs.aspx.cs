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
            if (!IsPostBack)
                FormatJobsGridView();

            string username = Session["Username"]?.ToString();

            if (username == null || !Model.HrEmployee.IsHrEmployee(username))
            {
                // TODO: Status Code -> Forbidden 403
                Response.StatusCode = 403;
                Response.StatusDescription = "You have to be an HR Employee to view this page.";
                Response.Redirect("../../../Default.aspx", true);
            }
            else _hrEmployee = new Model.HrEmployee(username);

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
            // Prepare job title
            string title = JobRole_DropdownList.SelectedValue + " - " + JobTitle_TextBox.Text;

            // Prepare working hours
            decimal working_hours = decimal.Parse(WorkingHours_TextBox.Text);
            decimal salary = decimal.Parse(Salary_TextBox.Text);
            int min_years_exp = int.Parse(MinYearsOfXp_TextBox.Text);
            int vacancy = int.Parse(MinYearsOfXp_TextBox.Text);

            DateTime deadline = DateTime.Parse(Deadline_TextBox.Text);

            if(_hrEmployee.AddJob(title, working_hours, min_years_exp, salary,
                Job_ShortDesc_TextBox.Text, Job_DetailDesc_TextBox.Text, deadline, vacancy))
            {
                Response.Redirect("EditJob.aspx?title=" + System.Net.WebUtility.UrlEncode(title), true);
            }
            else
            {
                Response.Write("Could not create this job");
            }
        }
    }
}