using System;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class StaffMember : User
    {

        public string DayOff => GetAttributeValue("day_off")?.ToString();

        public StaffMember(string username) : base(username)
        {
            if (!IsStaffMember(username))
                throw new Exception("Not a Staff Member in database.");
        }

        public static bool IsStaffMember(string username)
        {
            if (username == null)
                throw new ArgumentNullException(nameof(username));

            object result = null;

            SqlConnection sqlConnection = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand(
                "SELECT username FROM Staff_Members WHERE username = '" + username + "';", sqlConnection);

            try
            {
                sqlConnection.Open();
                result = sqlCmd.ExecuteScalar();
            }
            finally
            {
                if (sqlConnection?.State != ConnectionState.Closed)
                    sqlConnection?.Close();

                sqlConnection?.Dispose();
                sqlConnection = null;

                sqlCmd?.Dispose();
                sqlCmd = null;
            }

            return result != null;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Staff_Members WHERE " +
                $"username = '{Username}'", sql);

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

        public static object[] GetRequests()
        {
            throw new NotImplementedException();
        }

        public Job GetJob() => new Job(
            GetAttributeValue("job_title").ToString(),
            GetAttributeValue("department").ToString(),
            GetAttributeValue("company").ToString());

        protected int CreateEmailMessage(string subject, string body, int? reply_to = null)
        {
            if (string.IsNullOrEmpty(subject))
                throw new ArgumentNullException(nameof(subject));
            if (string.IsNullOrEmpty(body))
                throw new ArgumentNullException(nameof(body));
            if (reply_to != null && reply_to < 0)
                throw new ArgumentOutOfRangeException(nameof(reply_to));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Create_Email", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@subject", SqlDbType.VarChar)).Value = subject;
            sqlCmd.Parameters.Add(new SqlParameter("@body", SqlDbType.VarChar)).Value = body;

            if (reply_to != null)
                sqlCmd.Parameters.Add(new SqlParameter("@reply_to", SqlDbType.Int)).Value = reply_to.Value;

            SqlParameter emailId_sqlParam = new SqlParameter("@id", SqlDbType.Int);
            emailId_sqlParam.Direction = ParameterDirection.Output;
            sqlCmd.Parameters.Add(emailId_sqlParam);

            try
            {
                sql.Open();

                sqlCmd.ExecuteNonQuery();

                return int.Parse(emailId_sqlParam.Value.ToString());
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
            
        }

        public bool SendEmail(string subject, string body, string[] recipient_usernames)
        {
            if (recipient_usernames == null)
                throw new ArgumentNullException(nameof(recipient_usernames));
            else if (recipient_usernames.Length == 0)
                throw new ArgumentException("At least one recipient must be specified.", nameof(recipient_usernames));

            int email_id = CreateEmailMessage(subject, body);

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("Send_Email_in_Company", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@sender", SqlDbType.VarChar)).Value = Username;
            sqlCmd.Parameters.Add(new SqlParameter("@email_id", SqlDbType.Int)).Value = email_id;

            SqlParameter recipient_sqlParam = sqlCmd.Parameters.Add(new SqlParameter("@receiver", SqlDbType.VarChar));

            try
            {
                sql.Open();

                foreach (string rec in recipient_usernames)
                {
                    recipient_sqlParam.Value = rec;

                    if (sqlCmd.ExecuteNonQuery() == 0)
                        return false;
                }

                return true;
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

    }
}