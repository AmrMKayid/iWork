using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class HrEmployee : StaffMember
    {

        public HrEmployee(string username) : base(username)
        {
            if (!IsHrEmployee(username))
                throw new Exception("Not an HR Employee in the database.");
        }

        public static bool IsHrEmployee(string username)
        {
            if (username == null)
                throw new ArgumentNullException(nameof(username));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand(
                "SELECT username FROM Hr_Employees WHERE username = '" + username + "';", sql);

            try
            {
                sql.Open();

                return sqlCmd.ExecuteScalar() != null;
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        public bool PostAnnouncement(string title, string type, string description)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Post_Announcement", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            // @hr_username VARCHAR(50), @type VARCHAR(50), @title VARCHAR(50), @description VARCHAR(max)
            sqlCmd.Parameters.Add("@hr_username", SqlDbType.Char, 50).Value = Username;
            sqlCmd.Parameters.Add("@type", SqlDbType.Char, 50).Value = type;
            sqlCmd.Parameters.Add("@title", SqlDbType.Char, 50).Value = title;
            sqlCmd.Parameters.Add("@description", SqlDbType.VarChar).Value = description;

            try
            {
                sql.Open();

                int nRowsAffected = sqlCmd.ExecuteNonQuery();

                return nRowsAffected > 0;
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();

                sql.Dispose();

                sqlCmd.Dispose();
            }

        }

        public Tuple<List<LeaveRequest>, List<BusinessTripRequest>> GetRequestsApprovedByManagerOnly()
        {
            SqlConnection connection = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("View_Requests_approved_by_Manager_only", connection);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@hr_username", SqlDbType.VarChar, 50).Value = Username;

            SqlDataReader sqlDataReader = null;

            try
            {
                connection.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                if (sqlDataReader.FieldCount <= 0) return null;

                List<LeaveRequest> leave_requests = new List<LeaveRequest>();
                List<BusinessTripRequest> business_trip_requests = new List<BusinessTripRequest>();

                Tuple<List<LeaveRequest>, List<BusinessTripRequest>> tuple =
                    new Tuple<List<LeaveRequest>, List<BusinessTripRequest>>(leave_requests, business_trip_requests);

                if (!sqlDataReader.HasRows) return tuple;

                while (sqlDataReader.Read())
                {
                    // start_date
                    DateTime start_date = sqlDataReader.GetDateTime(0);
                    // username
                    string username = sqlDataReader.GetSqlString(1).Value;
                    // request_date
                    DateTime? request_date = null;
                    if(!sqlDataReader.IsDBNull(2))
                        request_date = sqlDataReader.GetDateTime(2);
                    // end_date
                    DateTime? end_date = null;
                    if(!sqlDataReader.IsDBNull(3))
                        end_date = sqlDataReader.GetDateTime(3);
                    // manager_username
                    string manager_username = sqlDataReader.GetSqlString(9).Value;

                    if (LeaveRequest.IsLeaveRequest(username, start_date))
                        leave_requests.Add(new LeaveRequest(username, start_date, end_date, request_date,
                            ReviewStatusEnum.ACCEPTED, manager_username, null));

                    else if (BusinessTripRequest.IsBusinessTripRequest(username, start_date))
                        business_trip_requests.Add(new BusinessTripRequest(username, start_date, end_date,
                            request_date, ReviewStatusEnum.ACCEPTED, manager_username, null));

                }

                return tuple;
                
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader?.Close();

                if (connection.State != ConnectionState.Closed)
                    connection.Close();
                connection.Dispose();

                sqlCmd.Dispose();
            }

        }

        public bool ReviewRequest(string req_username, DateTime start_date, bool accept)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Respond_to_Request_HR", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@hr_username", SqlDbType.VarChar, 50)).Value = Username;
            sqlCmd.Parameters.Add(new SqlParameter("@req_username", SqlDbType.VarChar, 50)).Value = req_username;
            sqlCmd.Parameters.Add(new SqlParameter("@req_start_date", SqlDbType.Date)).Value = start_date;
            sqlCmd.Parameters.Add(new SqlParameter("@accept", SqlDbType.Bit)).Value = accept;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 2;
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }

        }

        public List<Job> GetJobsInDepartment()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            Job myJob = GetJob();
            string department = myJob.DepartmentCode, company = myJob.CompanyDomain;

            SqlCommand sqlCmd = new SqlCommand("SELECT title FROM Jobs WHERE " +
                $"department = '{department}' AND company = '{company}'", sql);

            SqlDataReader reader = null;

            try
            {
                sql.Open();

                reader = sqlCmd.ExecuteReader();

                List<Job> jobsInDepartment = new List<Job>();

                while (reader.Read())
                    jobsInDepartment.Add(new Job(reader.GetString(0), department, company));

                return jobsInDepartment;

            }
            finally
            {
                if (!reader?.IsClosed ?? false)
                    reader.Close();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        public bool ReviewJobApplication(int app_id, bool accept)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Respond_to_Job_Application_HR", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@hr_username", SqlDbType.VarChar, 50).Value = Username;
            sqlCmd.Parameters.Add("@app_id", SqlDbType.Int).Value = app_id;
            sqlCmd.Parameters.Add("@accept", SqlDbType.Bit).Value = accept;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 1;
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        public List<JobApplication> GetPendingJobApplications(string job_title)
        {
            if (string.IsNullOrWhiteSpace(job_title))
                throw new ArgumentNullException(nameof(job_title));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("View_new_Applications_for_Job_in_Department", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@hr_username", SqlDbType.VarChar, 50).Value = Username;
            sqlCmd.Parameters.Add("@job_title", SqlDbType.VarChar, 50).Value = job_title;

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<JobApplication> jobApplications = new List<JobApplication>();

                while(sqlDataReader.Read())
                    jobApplications.Add(new JobApplication(sqlDataReader.GetInt32(0)));

                return jobApplications;
            }
            finally
            {
                sqlDataReader?.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public bool EditJob(string job_title, decimal working_hours, decimal salary, int min_yrs_xp,
            int vacancy, DateTime deadline, string short_desc, string detail_desc)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Edit_Job_in_Department", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@hr_username", SqlDbType.VarChar).Value = Username;
            sqlCmd.Parameters.Add("@job_title", SqlDbType.VarChar).Value = job_title;
            sqlCmd.Parameters.Add("@short_desc", SqlDbType.VarChar).Value = short_desc;
            sqlCmd.Parameters.Add("@detail_desc", SqlDbType.VarChar).Value = detail_desc;
            sqlCmd.Parameters.Add("@working_hrs", SqlDbType.Decimal).Value = working_hours;
            sqlCmd.Parameters.Add("@min_yrs_exp", SqlDbType.Int).Value = min_yrs_xp;
            sqlCmd.Parameters.Add("@salary", SqlDbType.Decimal).Value = salary;
            sqlCmd.Parameters.Add("@vacancy", SqlDbType.Int).Value = vacancy;
            sqlCmd.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 1;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public bool AddJob(string title, decimal working_hrs, int min_yrs_xp, decimal salary,
            string short_desc, string detail_desc, DateTime deadline, int vacancy = 1)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Add_Job", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@hr_username", SqlDbType.VarChar).Value = Username;
            sqlCmd.Parameters.Add("@title", SqlDbType.VarChar).Value = title;
            sqlCmd.Parameters.Add("@department", SqlDbType.VarChar).Value = GetJob().DepartmentCode;
            sqlCmd.Parameters.Add("@company", SqlDbType.VarChar).Value = GetJob().CompanyDomain;

            sqlCmd.Parameters.Add("@short_desc", SqlDbType.VarChar).Value = short_desc;
            sqlCmd.Parameters.Add("@detail_desc", SqlDbType.VarChar).Value = detail_desc;

            sqlCmd.Parameters.Add("@working_hrs", SqlDbType.Decimal).Value = working_hrs;
            sqlCmd.Parameters.Add("@min_yrs_exp", SqlDbType.Int).Value = min_yrs_xp;
            sqlCmd.Parameters.Add("@salary", SqlDbType.Decimal).Value = salary;
            sqlCmd.Parameters.Add("@deadline", SqlDbType.DateTime).Value = deadline;
            sqlCmd.Parameters.Add("@vacancy", SqlDbType.Int).Value = vacancy;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 2;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }

        }

        public bool AddNewQuestionToLibrary(string question, bool answer)
        {
            if (string.IsNullOrWhiteSpace(question))
                throw new ArgumentNullException(nameof(question));
            else if (question.Length > 100)
                throw new ArgumentException(nameof(question));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Create_Question", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@question", SqlDbType.VarChar).Value = question;
            sqlCmd.Parameters.Add("@answer", SqlDbType.VarChar).Value = answer;
            sqlCmd.Parameters.Add("@qid", SqlDbType.Int).Direction = ParameterDirection.Output;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 1;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public List<JobInterviewQuestion> ViewInterviewQuestionsLibrary()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("SELECT id FROM Questions", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<JobInterviewQuestion> questions = new List<JobInterviewQuestion>();

                while (sqlDataReader.Read())
                    questions.Add(new JobInterviewQuestion(sqlDataReader.GetInt32(0)));

                return questions;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public bool AddQuestionToJob(int question_id, string job_title)
        {
            if (string.IsNullOrWhiteSpace(job_title))
                throw new ArgumentNullException(nameof(job_title));

            Model.Job hrJob = GetJob();
            string department = hrJob.DepartmentCode, company = hrJob.CompanyDomain;

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Add_Job_Question_to_Job", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@qid", SqlDbType.Int).Value = question_id;
            sqlCmd.Parameters.Add("@job_title", SqlDbType.VarChar).Value = job_title;
            sqlCmd.Parameters.Add("@department", SqlDbType.VarChar).Value = department;
            sqlCmd.Parameters.Add("@company", SqlDbType.VarChar).Value = company;

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 1;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }

        }

        public bool DeleteQuestionFromJob(int question_id, string job_title)
        {
            if (string.IsNullOrWhiteSpace(job_title))
                throw new ArgumentNullException(nameof(job_title));

            Model.Job hrJob = GetJob();
            string department = hrJob.DepartmentCode, company = hrJob.CompanyDomain;

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"DELETE FROM Job_has_Questions WHERE question = {question_id}"
                + $" AND title = '{job_title}' AND department = '{department}' AND company = '{company}'", sql);

            try
            {
                sql.Open();

                return sqlCmd.ExecuteNonQuery() >= 1;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public List<string> GetUsernamesInDepartment()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("SELECT S2.username FROM Staff_Members Me INNER JOIN Staff_Members S2 "
                + $"ON Me.username = '{Username}' "
                + "AND S2.department = Me.department AND S2.company = Me.company", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<string> usernames = new List<string>();

                while (sqlDataReader.Read())
                    usernames.Add(sqlDataReader.GetString(0));

                return usernames;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }

        }

        public List<AttendanceRecord> GetAttendanceOfStaffMember(
            string staff_username, DateTime start_date, DateTime end_date)
        {
            if (string.IsNullOrWhiteSpace(staff_username))
                throw new ArgumentNullException(nameof(staff_username));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("View_Attendance_of_Staff_Member", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@staff_username", SqlDbType.VarChar)).Value = staff_username;
            sqlCmd.Parameters.Add(new SqlParameter("@from", SqlDbType.DateTime)).Value = start_date;
            sqlCmd.Parameters.Add(new SqlParameter("@to", SqlDbType.DateTime)).Value = end_date;
            sqlCmd.Parameters.Add(new SqlParameter("@hr_username", SqlDbType.VarChar)).Value = Username;

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<AttendanceRecord> staff_attendance = new List<AttendanceRecord>();

                while(sqlDataReader.Read())
                    staff_attendance.Add(new AttendanceRecord(staff_username, sqlDataReader.GetDateTime(1)));

                return staff_attendance;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public decimal?[] GetTotalWorkHoursPerMonthInYear(string staff_username, int year)
        {
            if (string.IsNullOrWhiteSpace(staff_username))
                throw new ArgumentNullException(nameof(staff_username));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("view_totalhours_of_staff", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@hr", SqlDbType.VarChar)).Value = Username;
            sqlCmd.Parameters.Add(new SqlParameter("@staff", SqlDbType.VarChar)).Value = staff_username;
            sqlCmd.Parameters.Add(new SqlParameter("@year", SqlDbType.Int)).Value = year;

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                decimal?[] totals = new decimal?[12];

                while (sqlDataReader.Read())
                {
                    if(!sqlDataReader.IsDBNull(2))
                        totals[sqlDataReader.GetInt32(1) - 1] = sqlDataReader.GetDecimal(2);
                }

                return totals;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public List<MonthTopAchiever> GetTopThreeRegularEmployees(int month, int year)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Top_3_RegEmp_for_Month", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@month", SqlDbType.Int)).Value = month;
            sqlCmd.Parameters.Add(new SqlParameter("@year", SqlDbType.Int)).Value = year;
            sqlCmd.Parameters.Add(new SqlParameter("@hr_username", SqlDbType.VarChar)).Value = Username;

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<MonthTopAchiever> achievers = new List<MonthTopAchiever>(3);

                while(sqlDataReader.Read())
                {
                    decimal? workHours = null;
                    if (!sqlDataReader.IsDBNull(1))
                        workHours = sqlDataReader.GetDecimal(1);

                    achievers.Add(new MonthTopAchiever(sqlDataReader.GetString(0), month, workHours));
                }

                return achievers;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public bool CongratulateTopAchievers(List<MonthTopAchiever> achievers)
        {
            if (achievers == null)
                throw new ArgumentNullException(nameof(achievers));
            else if (achievers.Count == 0)
                throw new ArgumentException("You have to specify at least one employee to send to.");

            Job hrJob = GetJob();

            string subject = "Thanks for your commitement!! :D";

            string body_format = "Dear Most-Valued Member, {0} {1},\n\nCongratulations! "
                + "You have made it to the TOP 3 of the list of Regular Employees of the whole company in {2} "
                + "by working for {3} hours so far that month.\n\n"
                //TODO: + $"Thanks again for you passion and dedication towards {hrJob.CompanyDomain}.\n\n"
                + $"Thanks again for you passion and dedication towards the company.\n\n"
                + "Best wishes ;)\n\n--------------------------------"
                + $"\n{FirstName} {LastName}\n{hrJob.Title}\nDepartment: {hrJob.DepartmentCode}";

            string[] monthsNames = new string[] { "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"};

            foreach (MonthTopAchiever achiever in achievers)
            {
                string body = string.Format(body_format, achiever.FirstName, achiever.LastName,
                    monthsNames[achiever.Month - 1], achiever.WorkHours);

                if (!SendEmail(subject, body, new string[] { achiever.Username }))
                    return false;
            }

            return true;
        }

    }
}