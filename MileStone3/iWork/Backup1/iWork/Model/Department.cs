using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class Department
    {

        public string CompanyDomain { get; }

        public string Code { get; }

        public string Name => GetAttributeValue("name")?.ToString();

        public Department(string code, string company_domain)
        {
            Code = code;
            CompanyDomain = company_domain;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Departments WHERE " +
                $"company = '{CompanyDomain}' AND code = '{Code}'", sql);

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

        public List<Job> GetJobs()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());
            SqlCommand sqlCmd = new SqlCommand(
                $"SELECT title FROM Jobs WHERE department = '{Code}' AND company = '{CompanyDomain}'", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<Job> jobs = new List<Job>();

                while (sqlDataReader.Read())
                    jobs.Add(new Job(sqlDataReader.GetString(0), Code, CompanyDomain));

                return jobs;
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

    }
}