using System;
using System.Configuration;

namespace iWork.Model
{
    class DbHelper
    {

        public static string GetConnectionString()
        {
            string connStr = null;

            connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //connStr = @"Server=SHADOLIO\SQLEXPRESS; Database=iWork; Trusted_Connection=Yes;";

            //connStr = @"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017";

            return connStr;
        }

    }
}