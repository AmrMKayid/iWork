using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class JobApplication
    {

        public int ID { get; }

        public int Score => int.Parse(GetAttributeValue("score").ToString());

        public string ApplicantUsername => GetAttributeValue("app_username").ToString();

        public User Applicant => new User(ApplicantUsername);

        public JobApplication(int id) { ID = id; }

        public static bool ApplicationExists(int id)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT id FROM Applications WHERE id = {id}", sql);

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

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Applications WHERE id = {ID}", sql);

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

        public Job GetJob()
        {
            string job_title = GetAttributeValue("job_title").ToString();
            string department = GetAttributeValue("department").ToString();
            string company = GetAttributeValue("company").ToString();

            return new Job(job_title, department, company);
        }

    }
}