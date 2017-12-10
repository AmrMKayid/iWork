using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class Company
    {

        public string Domain { get; }

        public string Name => GetAttributeValue("name")?.ToString();

        public string Email => GetAttributeValue("email")?.ToString();

        public string Address => GetAttributeValue("address")?.ToString();

        public string Type => GetAttributeValue("type")?.ToString();

        public string Vision => GetAttributeValue("vision")?.ToString();

        public string Specialization => GetAttributeValue("specialization")?.ToString();

        public Company(string domain)
        {
            Domain = domain;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Companies WHERE " +
                $"domain = '{Domain}'", sql);

            try
            {
                sql.Open();

                return sqlCmd.ExecuteScalar();
            }
            finally
            {
                sqlCmd.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public List<string> GetPhoneNumbers()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT phone FROM Company_Phones WHERE company = '{Domain}'", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<string> phones = new List<string>();

                while (sqlDataReader.Read())
                    phones.Add(sqlDataReader.GetString(0));

                return phones;
            }
            finally
            {
                if (!sqlDataReader?.IsClosed ?? false)
                    sqlDataReader.Close();

                sqlCmd?.Dispose();

                if (sql.State != ConnectionState.Closed)
                    sql.Close();
                sql.Dispose();
            }
        }

        public List<Department> GetDepartments()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT code FROM Departments WHERE company = '{Domain}'", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<Department> departments = new List<Department>();

                while (sqlDataReader.Read())
                    departments.Add(new Department(sqlDataReader.GetString(0), Domain));

                return departments;
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