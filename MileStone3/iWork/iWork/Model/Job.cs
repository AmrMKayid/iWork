using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class Job
    {

        public string Title { get; }
        public string DepartmentCode { get; }
        public string CompanyDomain { get; }

        public decimal? WorkingHours
        {
            get
            {
                object value = GetAttributeValue("working_hours");
                decimal workingHours = 0;

                if (value == null || !decimal.TryParse(value.ToString(), out workingHours))
                    return null;
                else
                    return workingHours;
            }
        }
        public decimal? Salary
        {
            get
            {
                object value = GetAttributeValue("salary");
                decimal salary = 0;

                if (value == null || !decimal.TryParse(value.ToString(), out salary))
                    return null;
                else
                    return salary;
            }
        }

        public int? MinYearsOfExperience
        {
            get
            {
                object value = GetAttributeValue("min_years_of_experience");
                int minYearsOfExp = 0;

                if (value == null || !int.TryParse(value.ToString(), out minYearsOfExp))
                    return null;
                else
                    return minYearsOfExp;
            }
        }
        public int? Vacancy
        {
            get
            {
                object value = GetAttributeValue("vacancy");
                int vacancy = 0;

                if (value == null || !int.TryParse(value.ToString(), out vacancy))
                    return null;
                else
                    return vacancy;
            }
        }

        public DateTime? Deadline
        {
            get
            {
                object value = GetAttributeValue("deadline");
                DateTime deadline = DateTime.MinValue;

                if (value == null || !DateTime.TryParse(value.ToString(), out deadline))
                    return null;
                else
                    return deadline;
            }
        }

        public string ShortDescription => GetAttributeValue("short_description")?.ToString();
        public string DetailedDescription => GetAttributeValue("detailed_description")?.ToString();

        public Job(string title, string department, string company)
        {
            Title = title;
            DepartmentCode = department;
            CompanyDomain = company;
        }

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Jobs WHERE " +
                $"title = '{Title}' AND department = '{DepartmentCode}' AND company = '{CompanyDomain}'", sql);

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

        public List<JobInterviewQuestion> GetQuestions()
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand("SELECT question FROM Job_has_Questions WHERE "
                + $"title = '{Title}' AND department = '{DepartmentCode}' AND company = '{CompanyDomain}'", sql);

            SqlDataReader sqlDataReader = null;

            try
            {
                sql.Open();

                sqlDataReader = sqlCmd.ExecuteReader();

                List<JobInterviewQuestion> questions = new List<JobInterviewQuestion>();

                while (sqlDataReader.Read())
                    questions.Add(new JobInterviewQuestion(sqlDataReader.GetInt32(0)));

                return questions;
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