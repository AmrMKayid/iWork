using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class Request
    {

        public string Username { get; }
        public string Replacer => GetReplacingUsername();

        public DateTime StartDate { get; }
        public DateTime? EndDate { get; }

        public int TotalLeaveDays => int.Parse(GetAttributeValue("leave_days")?.ToString());

        public DateTime? RequestDate { get; }

        public string ManagerUsername { get; private set; }
        public ReviewStatusEnum ManagerResponse { get; private set; }
        public string ManagerReason { get; private set; }

        public Request(string username, DateTime start_date, DateTime? end_date, DateTime? request_date,
            ReviewStatusEnum mang_response, string mang_username, string mang_reason)
        {
            Username = username;
            StartDate = start_date;

            EndDate = end_date;
            RequestDate = request_date;

            ManagerUsername = mang_username;
            ManagerResponse = mang_response;
            ManagerReason = mang_reason;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Requests WHERE " +
                $"username = '{Username}' AND start_date = '{StartDate.ToString("yyyy-MM-dd")}'", sql);

            try
            {
                sql.Open();

                return sqlCmd.ExecuteScalar();
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        public string GetReplacingUsername()
        {
            string replace_table_name =
                HrEmployee.IsHrEmployee(Username) ? "Request_Hr_Replace" :
                Manager.IsManager(Username) ? "Request_Manager_Replace" :
                RegularEmployee.IsRegularEmployee(Username) ? "Request_Regular_Employee_Replace" : null;

            if (replace_table_name == null) return null;

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT username_replacing FROM {replace_table_name} WHERE " +
                $"username = '{Username}' AND start_date = '{StartDate.ToString("yyyy-MM-dd")}'", sql);

            try
            {
                sql.Open();

                return sqlCmd.ExecuteScalar()?.ToString();
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

    }
}