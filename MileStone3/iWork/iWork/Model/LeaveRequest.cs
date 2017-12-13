using System;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class LeaveRequest : Request
    {

        public enum LeaveTypeEnum { Sick, Accidental, Annual }

        public LeaveTypeEnum Type => (LeaveTypeEnum) Enum.Parse(typeof(LeaveTypeEnum),
            GetLeaveTypeAsObject(Username, StartDate).ToString(), true);
        
        public LeaveRequest(string username, DateTime start_date, DateTime? end_date,
            DateTime? request_date, ReviewStatusEnum mang_response, string mang_username, string mang_reason)
            : base(username, start_date, end_date, request_date, mang_response, mang_username, mang_reason)
        { }

        public static bool IsLeaveRequest(string username, DateTime start_date)
            => GetLeaveTypeAsObject(username, start_date) != null;

        private static object GetLeaveTypeAsObject(string username, DateTime start_date)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("SELECT type FROM Leave_Requests WHERE username = '"
                + username + "' AND start_date = '" + start_date.ToString("yyyy-MM-dd") + "'", sql);

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

    }
}