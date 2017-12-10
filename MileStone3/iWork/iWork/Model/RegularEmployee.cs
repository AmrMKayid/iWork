using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class RegularEmployee : StaffMember
    {

        public RegularEmployee(string username) : base(username)
        {
            if (!IsRegularEmployee(username))
                throw new Exception("Not registered as a Regular Employee in database.");
        }

        public static bool IsRegularEmployee(string username)
        {
            if (username == null)
                throw new ArgumentNullException(nameof(username));

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand(
                $"SELECT username FROM Regular_Employees WHERE username = '{username}'", sql);

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
    }
}