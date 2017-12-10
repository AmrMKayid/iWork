using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Attendance
{
    public partial class ViewStaffAttendance : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if(!IsPostBack)
            {
                DateTime dateToday = DateTime.Now;

                AttendanceTo_TextBox.Text = dateToday.ToShortDateString();
                AttendanceFrom_TextBox.Text = dateToday.Subtract(TimeSpan.FromDays(7)).ToShortDateString();

                AttendanceOfYear_TextBox.Text = dateToday.Year.ToString();

                FormatRangeAttendanceGridView();
            }

            string hr_username = Session["Username"]?.ToString();

            if (hr_username == null || !Model.HrEmployee.IsHrEmployee(hr_username))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is accessible for HR employees only."
                    + " If you are an HR employee, please make sure you are logged in first.";
                Response.Write(Response.StatusDescription);
                return;
            }
            else
                _hrEmployee = new Model.HrEmployee(hr_username);

            if(!IsPostBack)
            {
                ChooseStaffMember_DropDownList.DataSource = _hrEmployee.GetUsernamesInDepartment();
                ChooseStaffMember_DropDownList.DataBind();
            }

        }

        protected void ChooseStaffMember_Button_Click(object sender, EventArgs e)
        {
            DisplayStaffMemberAttendanceInRange();
            DisplayStaffMemberAttendancePerMonth();
        }

        private void FormatRangeAttendanceGridView()
        {
            AttendanceInRange_GridView.AutoGenerateColumns = false;

            AttendanceInRange_GridView.DataKeyNames = new string[]
            {
                nameof(Model.AttendanceRecord.Username), nameof(Model.AttendanceRecord.Date)
            };

            AttendanceInRange_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.AttendanceRecord.Date),
                DataFormatString = "{0:d}",
                HeaderText = "Date"
            });

            AttendanceInRange_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.AttendanceRecord.StartTime),
                HeaderText = "From"
            });

            AttendanceInRange_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.AttendanceRecord.EndTime),
                HeaderText = "To"
            });

            AttendanceInRange_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.AttendanceRecord.Duration),
                HeaderText = "Duration"
            });

            AttendanceInRange_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.AttendanceRecord.MissingHours),
                HeaderText = "Missing Hours"
            });
        }

        private string GetChosenUsername()
        {
            int selI = ChooseStaffMember_DropDownList.SelectedIndex;

            return _hrEmployee.GetUsernamesInDepartment()[ChooseStaffMember_DropDownList.SelectedIndex];
        }

        private void DisplayStaffMemberAttendanceInRange()
        {
            string username = GetChosenUsername();

            DateTime endDate = DateTime.Now;
            if (!string.IsNullOrWhiteSpace(AttendanceTo_TextBox.Text))
                DateTime.TryParse(AttendanceTo_TextBox.Text, out endDate);

            DateTime startDate = endDate.Subtract(TimeSpan.FromDays(7));
            if (!string.IsNullOrWhiteSpace(AttendanceFrom_TextBox.Text))
                DateTime.TryParse(AttendanceFrom_TextBox.Text, out startDate);

            List<Model.AttendanceRecord> attendance =
                _hrEmployee.GetAttendanceOfStaffMember(username, startDate, endDate);

            AttendanceInRange_GridView.DataSource = attendance;
            AttendanceInRange_GridView.DataBind();
        }

        private void DisplayStaffMemberAttendancePerMonth()
        {
            string username = GetChosenUsername();

            int year = DateTime.Now.Year;
            if (!string.IsNullOrWhiteSpace(AttendanceOfYear_TextBox.Text))
                int.TryParse(AttendanceOfYear_TextBox.Text, out year);

            decimal?[] totalHrsPerMonth = _hrEmployee.GetTotalWorkHoursPerMonthInYear(username, year);

            string[] monthNames = 
                {"January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"};

            List<object> list = new List<object>(12);

            for (byte i = 0; i < 12; i++)
                list.Add(new { Month = monthNames[i], TotalHours = totalHrsPerMonth[i] });

            AttendanceOfYear_GridView.DataSource = list;
            AttendanceOfYear_GridView.DataBind();
        }
    }
}