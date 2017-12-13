using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace iWork.Model
{
    class DbHelper
    {

        public static string GetConnectionString()
        {
            string connStr = null;

            //connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            connStr = @"Server=SHADOLIO\SQLEXPRESS; Database=iWork; Trusted_Connection=Yes;";

            //connStr = @"Server=localhost;Database=iWork;User Id=sa;Password=KayidServer@2017";

            return connStr;
        }

    }
}