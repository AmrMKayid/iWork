using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iWork.Staff_Member.HR_Employee.Attendance
{
    public partial class EmployeeOfTheMonth : System.Web.UI.Page
    {

        private Model.HrEmployee _hrEmployee = null;

        protected void Page_Load(object sender, EventArgs e)
        {

            if(!IsPostBack)
            {
                FormatAchieversGridView();
            }

            string hrUsername = Session["Username"]?.ToString();

            if (hrUsername == null || !Model.HrEmployee.IsHrEmployee(hrUsername))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is accessible only to HR employees."
                    + "If you are an HR, please make sure you are logged in.";
                Response.Write(Response.StatusDescription);
                return;
            }
            else
                _hrEmployee = new Model.HrEmployee(hrUsername);

            if(!IsPostBack)
            {
                DateTime dateToday = DateTime.Now;

                Year_TextBox.Text = dateToday.Year.ToString();
                Month_DropDownList.SelectedValue = dateToday.Month.ToString();
            }

        }

        protected List<Model.MonthTopAchiever> GetTopEmployees()
        {
            DateTime dateToday = DateTime.Now;

            int month = dateToday.Month, year = dateToday.Year;

            int.TryParse(Month_DropDownList.SelectedValue, out month);
            int.TryParse(Year_TextBox.Text, out year);

            return _hrEmployee.GetTopThreeRegularEmployees(month, year);
        }

        protected void View_Button_Click(object sender, EventArgs e)
        {
            List<Model.MonthTopAchiever> achievers = GetTopEmployees();

            TopAchievers_GridView.DataSource = achievers;
            TopAchievers_GridView.DataBind();

            Congratulate_Button.Visible = achievers != null && achievers.Count > 0;
        }

        private void FormatAchieversGridView()
        {
            TopAchievers_GridView.AutoGenerateColumns = false;

            TopAchievers_GridView.DataKeyNames = new string[] { nameof(Model.MonthTopAchiever.Username) };

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.Username),
                HeaderText = "Username"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.WorkHours),
                HeaderText = "Total Hours"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.FirstName),
                HeaderText = "First Name"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.LastName),
                HeaderText = "Last Name"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.YearsOfExperience),
                HeaderText = "Years of Experience"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.Age),
                HeaderText = "Age"
            });

            TopAchievers_GridView.Columns.Add(new BoundField()
            {
                DataField = nameof(Model.MonthTopAchiever.DayOff),
                HeaderText = "Day off"
            });
        }

        protected void Congratulate_Button_Click(object sender, EventArgs e)
        {
            List<Model.MonthTopAchiever> achievers = GetTopEmployees();

            if( _hrEmployee.CongratulateTopAchievers(achievers))
            {
                Response.Write("Congratulations email sent successfully!! :)");
            }
            else
            {
                Response.Write("Could not send email to congratulate. :|");
            }
        }
    }
}