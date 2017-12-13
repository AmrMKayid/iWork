using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class User
    {

        public string Username { get; }

        public string FirstName => GetAttributeValue("first_name").ToString();
        public string MiddleName => GetAttributeValue("middle_name")?.ToString();
        public string LastName => GetAttributeValue("last_name").ToString();

        public string Email => GetAttributeValue("email").ToString();

        public int Age => int.Parse(GetAttributeValue("age").ToString());
        public DateTime BirthDate => DateTime.Parse(GetAttributeValue("birth_date").ToString());

        public int YearsOfExperience => int.Parse(GetAttributeValue("years_of_experience").ToString());

        public User(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
                throw new ArgumentNullException(nameof(username));

            Username = username;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Users WHERE username = '{Username}'", sql);

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

        public List<string> GetPreviousJobTitles()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand(
                $"SELECT title FROM User_Previous_Job_Titles WHERE username = '{Username}'", sql);

            SqlDataReader sqlDataReader = null;

            List<string> titles = new List<string>();

            try
            {
                sql.Open();
                
                sqlDataReader = sqlCmd.ExecuteReader();

                while(sqlDataReader.Read())
                    titles.Add(sqlDataReader.GetString(0));

                return titles;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader?.Close();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();

                sqlCmd.Dispose();
            }
        }

        public static bool Register(string username, string password, string email,
            string first_name, string middle_name, string last_name, DateTime birth_date, int years_of_experience = 0)
        {

            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("register", sql);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar)).Value = username;
            sqlCmd.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = password;
            sqlCmd.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = email;
            sqlCmd.Parameters.Add(new SqlParameter("@firstname", SqlDbType.VarChar)).Value = first_name;
            sqlCmd.Parameters.Add(new SqlParameter("@middlename", SqlDbType.VarChar)).Value = middle_name;
            sqlCmd.Parameters.Add(new SqlParameter("@lastname", SqlDbType.VarChar)).Value = last_name;
            sqlCmd.Parameters.Add(new SqlParameter("@birthdate", SqlDbType.DateTime)).Value = birth_date;
            sqlCmd.Parameters.Add(new SqlParameter("@yearsofexp", SqlDbType.Int)).Value = years_of_experience;

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

    }
}