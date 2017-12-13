using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Jobs
{
    public partial class ViewJobApplication : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;
        private Model.JobApplication _application = null;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                FormatApplicantDetailsView();
                FormatJobDetailsView();
                FormatReviewGridView();
            }

            string username = Session["Username"]?.ToString();

            if (username == null || !Model.HrEmployee.IsHrEmployee(username))
            {
                // TODO: Status code -> Forbidden 403
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is available only to HR Employees.";
                Response.Redirect("../../../Default.aspx", true);
            }
            else
                _hrEmployee = new Model.HrEmployee(username);

            if(Request.QueryString["id"] != null)
            {
                string idString = Request.QueryString["id"];

                int app_id = 0;

                if (int.TryParse(idString, out app_id) && Model.JobApplication.ApplicationExists(app_id))
                    _application = new Model.JobApplication(app_id);

            }

            if(_application != null)
            {
                Model.Job app_Job = _application.GetJob(), hrJob = _hrEmployee.GetJob();

                if(!hrJob.DepartmentCode.Equals(app_Job.DepartmentCode) || !hrJob.CompanyDomain.Equals(app_Job.CompanyDomain))
                {
                    // TODO: Status code -> Forbidden 403
                    Response.StatusCode = 403;
                    Response.StatusDescription = "You are only allowed to view applications in your department.";
                    Response.Write(Response.StatusDescription);
                    return;
                    //Response.Redirect("../../Dashboard/Index.aspx");
                }

                ApplicationID_Label.Text = _application.ID.ToString();
                Score_Label.Text = _application.Score.ToString();

                Applicant_DetailsView.DataSource = new List<Model.User>(1) { _application.Applicant };
                Applicant_DetailsView.DataBind();

                if (Model.StaffMember.IsStaffMember(_application.Applicant.Username))
                {
                    CurrentEmployment_Panel.Visible = true;
                    CurrentJob_DetailsView.DataSource = new List<Model.Job>(1)
                        { new Model.StaffMember(_application.Applicant.Username).GetJob() };
                    CurrentJob_DetailsView.DataBind();
                }
                else
                    CurrentEmployment_Panel.Visible = false;

                Applicant_PrevJobTitles_GridView.DataSource = _application.Applicant.GetPreviousJobTitles();
                Applicant_PrevJobTitles_GridView.DataBind();

                Job_DetailsView.DataSource = new List<Model.Job>(1) { app_Job };
                Job_DetailsView.DataBind();

                Response_GridView.DataSource = new List<Model.JobApplication>(1) { _application };
                Response_GridView.DataBind();
            }

        }

        private void FormatApplicantDetailsView()
        {
            Applicant_DetailsView.DataKeyNames = new string[] { nameof(Model.User.Username) };
        }

        private void FormatJobDetailsView()
        {
            string[] jobDataKeyNames = new string[]
            {
                nameof(Model.Job.Title), nameof(Model.Job.DepartmentCode), nameof(Model.Job.CompanyDomain)
            };

            Job_DetailsView.DataKeyNames = jobDataKeyNames;
            CurrentJob_DetailsView.DataKeyNames = jobDataKeyNames;
        }

        private void FormatReviewGridView()
        {
            Response_GridView.AutoGenerateColumns = false;

            Response_GridView.ShowHeader = false;
            Response_GridView.GridLines = GridLines.None;

            Response_GridView.Columns.Add(new ButtonField()
            {
                Text = "Accept",
                CommandName = "ACPT",
                ButtonType = ButtonType.Button
            });

            Response_GridView.Columns.Add(new ButtonField()
            {
                Text = "Reject",
                CommandName = "RJCT",
                ButtonType = ButtonType.Button
            });
        }

        protected void Response_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e?.CommandSource == null)
                return;

            bool accept = false;

            if (e.CommandName == "ACPT")
                accept = true;
            else if (e.CommandName == "RJCT")
                accept = false;
            else
                return;

            if(_hrEmployee.ReviewJobApplication(_application.ID, accept))
            {
                Response.Write("Review saved successfully");
                Response.Redirect("EditJob.aspx?title=" + HttpUtility.UrlEncode(_application.GetJob().Title), true);
            }
            else
            {
                Response.Write("Sorry, failed to save your response.");
            }

        }
    }
}