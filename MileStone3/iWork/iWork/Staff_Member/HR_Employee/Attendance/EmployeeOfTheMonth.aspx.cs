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
            CongratulationsSent_Status_Label.Text = "";

            string hrUsername = Session["Username"]?.ToString();

            usernameLbl.Text = hrUsername;
            usernameUpperRight_Label.Text = hrUsername;

            if (string.IsNullOrWhiteSpace(hrUsername) || !Model.HrEmployee.IsHrEmployee(hrUsername))
            {
                Response.StatusCode = 403;
                Response.StatusDescription = "This page is accessible only to HR employees."
                    + "If you are an HR, please make sure you are logged in.";

                TopEmployees_Panel.Visible = false;
                NotHR_Panel.Visible = true;
                return;
            }
            else
            {
                _hrEmployee = new Model.HrEmployee(hrUsername);

                NotHR_Panel.Visible = false;
                TopEmployees_Panel.Visible = true;
            }

            if (!IsPostBack) {

                FormatAchieversGridView();

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
                //Response.Write("Emails sent successfully!! :)");
                CongratulationsSent_Status_Label.Text = "Emails sent successfully!! :)";
            }
            else
            {
                //Response.Write("Could not send emails. :|");
                CongratulationsSent_Status_Label.Text = "Could not send emails. :|";
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