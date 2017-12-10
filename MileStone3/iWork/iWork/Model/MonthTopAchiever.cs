namespace iWork.Model
{
    public class MonthTopAchiever : RegularEmployee
    {

        public int Month { get; }

        public decimal? WorkHours { get; }

        public MonthTopAchiever(string username, int month, decimal? work_hours) : base(username)
        {
            Month = month;
            WorkHours = work_hours;
        }

    }
}