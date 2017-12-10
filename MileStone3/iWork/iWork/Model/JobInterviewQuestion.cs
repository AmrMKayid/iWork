using System.Data;
using System.Data.SqlClient;

namespace iWork.Model
{
    public class JobInterviewQuestion
    {

        public int ID { get; }

        public string Question => GetAttributeValue("question")?.ToString();

        public bool? Answer
        {
            get
            {
                object value = GetAttributeValue("answer");

                bool ans = false;

                if (value == null || !bool.TryParse(value.ToString(), out ans))
                    return null;
                else
                    return ans;
            }
        }

        public JobInterviewQuestion(int id) => ID = id;

        private object GetAttributeValue(string attribute_name)
        {
            SqlConnection sql = new SqlConnection(DbHelper.GetConnectionString());

            SqlCommand sqlCmd = new SqlCommand($"SELECT {attribute_name} FROM Questions WHERE id = {ID}", sql);

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

        public override string ToString() => $"{ID} - {Question} - {Answer}";

    }
}