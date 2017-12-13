using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class BusinessTripRequest : Request
    {

        public string Destination => GetAttributeValue("destination")?.ToString();
        public string Purpose => GetAttributeValue("purpose")?.ToString();

        public BusinessTripRequest(string username, DateTime start_date, DateTime? end_date, DateTime? request_date,
            ReviewStatusEnum mang_response, string mang_username, string mang_reason)
            : base(username, start_date, end_date, request_date, mang_response, mang_username, mang_reason)
        { }

        public static bool IsBusinessTripRequest(string username, DateTime start_date)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("SELECT * FROM Business_Trips WHERE username = '" + username
                + "' AND start_date = '" + start_date.ToString("yyyy-MM-dd") + "'", sql);

            try
            {
                sql.Open();
                object firstValue = sqlCmd.ExecuteScalar();

                return firstValue != null;
            }
            finally
            {
                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Business_Trips WHERE " +
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

    }
}