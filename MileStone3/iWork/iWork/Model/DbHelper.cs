using System;
using System.Configuration;

namespace iWork.Model
{
    class DbHelper
    {

        public static string GetConnectionString()
        {
            string connStr = null;

            //connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //connStr = @"Server=SHADOLIO\SQLEXPRESS; Database=iWork; Trusted_Connection=Yes;";

            connStr = @"Data Source=(localdb)\ProjectsV13;Initial Catalog=iWork;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            //connStr = @"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017";

            return connStr;
        }

    }
}