using System.ComponentModel.DataAnnotations;
using System;

namespace iWork.Models
{
    public class User
    {
        public string username { get; set; }

        public string password { get; set; }

        public string email { get; set; }

        public string first_name { get; set; }

        public string middle_name { get; set; }

        public string last_name { get; set; }

        public DateTime birth_date { get; set; }

        public int years_of_experience { get; set; }

        public User()
        {
            

        }
    }


    public class StaffMembers : User
    {
        
        public string company_email { get; set; }

        public double salary { get; set; }

        public string day_off { get; set; }

        public int annual_leaves { get; set; }

        public string job_title { get; set; }

        public string department { get; set; }

        public string company { get; set; }

        public StaffMembers()
        {


        }
    }


    public class Applicant : User
    {
        public Applicant()
        {


        }
    }
}
