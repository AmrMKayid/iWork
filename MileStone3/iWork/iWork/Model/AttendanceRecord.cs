using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class AttendanceRecord
    {

        public string Username { get; }
        public DateTime Date { get; }

        public string StartTime => GetAttributeValue("time_of_start")?.ToString();
        public string EndTime => GetAttributeValue("time_of_leave")?.ToString();

        public decimal? Duration
        {
            get
            {
                object value = GetAttributeValue("duration");

                decimal duration = 0;

                if (value == null || !decimal.TryParse(value.ToString(), out duration))
                    return null;
                else
                    return duration;
            }
        }

        public decimal? MissingHours
        {
            get
            {
                object value = GetAttributeValue("missing_hours");

                decimal missing_hours = 0;

                if (value == null || !decimal.TryParse(value.ToString(), out missing_hours))
                    return null;
                else
                    return missing_hours;
            }
        }

        public AttendanceRecord(string staff_username, DateTime attendance_date)
        {
            Username = staff_username;
            Date = attendance_date;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Attendance_Records WHERE " +
                $"username = '{Username}' AND attendance_date = '{Date.ToString("yyyy-MM-dd")}'", sql);

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