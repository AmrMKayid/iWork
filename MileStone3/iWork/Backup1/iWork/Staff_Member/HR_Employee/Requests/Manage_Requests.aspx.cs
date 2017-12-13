using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Requests
{
    public partial class Manage_Requests : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            RequestsUpdate_Status_Label.Text = "";

            string username = Session["Username"]?.ToString();

            usernameLbl.Text = username;

            if (string.IsNullOrWhiteSpace(username) || !Model.HrEmployee.IsHrEmployee(username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This is allowed only to Hr Employees";

                Requests_Panel.Visible = false;
                NotHR_Panel.Visible = true;

                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(username);

                Requests_Panel.Visible = true;
                NotHR_Panel.Visible = false;
            }

            if (!IsPostBack)
                FormatRequestsGridViews();

            FillRequestsTables();
        }

        private void FillRequestsTables()
        {
            // Load requests to the table
            Tuple<List<Model.LeaveRequest>, List<Model.BusinessTripRequest>> requests =
                _hrEmployee.GetRequestsApprovedByManagerOnly();

            // Leave requests
            Leave_Requests_GridView.DataSource = requests.Item1;
            Leave_Requests_GridView.DataBind();

            // Business Trip requests
            Business_Trip_Requests_GridView.DataSource = requests.Item2;
            Business_Trip_Requests_GridView.DataBind();
        }

        private void FormatRequestsGridViews()
        {
            FormatRequestsGridView(Leave_Requests_GridView);
            FormatRequestsGridView(Business_Trip_Requests_GridView);
        }

        private void FormatRequestsGridView(GridView requests_GridView)
        {
            requests_GridView.AutoGenerateColumns = false;

            requests_GridView.DataKeyNames =
                new string[] { nameof(Model.Request.Username), nameof(Model.Request.StartDate) };

            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.Username),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "username"
            });

            // Add "replaced by"
            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.Replacer),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "replaced by"
            });

            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.StartDate),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "start date",
                DataFormatString = "{0:d}"
            });

            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.EndDate),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "end date",
                DataFormatString = "{0:d}"
            });

            // TODO: Show "Working leave days"

            // Show "Total leave days"
            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.TotalLeaveDays),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "total days"
            });

            if (requests_GridView == Leave_Requests_GridView)
                AddLeaveTypeColumn(requests_GridView);
            else if (requests_GridView == Business_Trip_Requests_GridView)
                AddBusinessTripDestinationAndPurposeColumns(requests_GridView);

            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.RequestDate),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "request date",
                DataFormatString = "{0:F}"
            });

            requests_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.Request.ManagerUsername),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "manager approved"
            });

            requests_GridView.Columns.Add(new ButtonField()
            {
                Text = "Approve",
                ButtonType = ButtonType.Button,
                ShowHeader = false,
                CommandName = "APRV"
            });

            requests_GridView.Columns.Add(new ButtonField()
            {
                Text = "Reject",
                ButtonType = ButtonType.Button,
                ShowHeader = false,
                CommandName = "RJCT"
            });
            
        }
        
        private void AddLeaveTypeColumn(GridView gridView)
        {
            gridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.LeaveRequest.Type),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "leave type"
            });
        }

        private void AddBusinessTripDestinationAndPurposeColumns(GridView gridView)
        {
            gridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.BusinessTripRequest.Destination),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "destination"
            });

            gridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.BusinessTripRequest.Purpose),
                ReadOnly = true,
                ShowHeader = true,
                HeaderText = "purpose"
            });
        }

        protected void Requests_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Prepare Accept (Approve) or Reject
            bool accept = false;

            if (e?.CommandName == null)
                return;
            else if (e.CommandName.StartsWith("APRV"))
                accept = true;
            else if (e.CommandName.StartsWith("RJCT"))
                accept = false;
            else
                return;

            GridView gridView = null;
            if (e.CommandSource is GridView) gridView = (GridView)e.CommandSource;
            else return;

            int i = 0;
            if (!int.TryParse(e.CommandArgument.ToString(), out i)) return;

            // Prepare the Request
            Model.Request request = null;

            if (gridView.DataSource is List<Model.LeaveRequest>)
                request = ((List<Model.LeaveRequest>)gridView.DataSource)[i];

            else if (gridView.DataSource is List<Model.BusinessTripRequest>)
                request = ((List<Model.BusinessTripRequest>)gridView.DataSource)[i];

            else
                return;

            if (_hrEmployee.ReviewRequest(request.Username, request.StartDate, accept))
            {
                RequestsUpdate_Status_Label.Text = "Request and leave days of staff member are updated successfully.";

                FillRequestsTables();
            }
            else
                RequestsUpdate_Status_Label.Text = "Failed to update request.";

        }

        protected void LoginFirst_Button_Click(object sender, EventArgs e)
            => Response.Redirect("../../../Login.aspx", true);
    }
}