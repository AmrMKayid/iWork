using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class Manager : StaffMember
    {
        public Manager(string username) : base(username)
        {
            if (!IsManager(username))
                throw new Exception("Not a Manager in database.");
        }

        public static bool IsManager(string username)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT username FROM Managers WHERE username = '{username}'", sql);

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