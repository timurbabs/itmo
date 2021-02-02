using System;

namespace Banks
{
    public class Client
    {
        public Guid Id;
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Address { get; set; }
        public string PassNum { get; set; }
        public bool Doubtful;

        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}