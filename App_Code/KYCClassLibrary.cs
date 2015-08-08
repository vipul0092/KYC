using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;
using System.Text.RegularExpressions;

namespace KYClib
{
        public partial class RaterInfo
        {
            public string name; public string employer; public string employerCode; public string email; public string contactNum;

            public RaterInfo(string employer, string email, string name = null, string employerCode = null, string contactNum = null)
            {
                this.name = name; this.employer = employer; this.email = email; this.employerCode = employerCode; this.contactNum = contactNum;
            }

            public bool checkEmail()
            {
                try
                {
                    return Regex.IsMatch(email,
                          @"^(?("")(""[^""]+?""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                          @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9]{2,17}))$",
                          RegexOptions.IgnoreCase);
                }
                catch
                {
                    return false;
                }
            }
        }
        public partial class StringCollection
        {
            public static string[] CRCols = new string[14] { "InterviewAtmosphere", "Recruitment", "LevelOfStress", "PhysicalCondition", "HRPractices", "SalaryBenefits", "Schedule", "Promotion", "Recognition", "SatisfactionLevel", "LifeBalance", "Recommendation", "NumReviews", "AverageRating" };
        }

}