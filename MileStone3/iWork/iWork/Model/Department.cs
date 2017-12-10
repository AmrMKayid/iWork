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

        private List<Job> GetJobs()
        {
            throw new NotImplementedException();
        }

    }
}