using System;

namespace sabzify
{
    [Serializable]
    public class User
    {
        public string FullName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Password { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }

        // Admin/AddUser.aspx collects both of these and used to throw them away:
        // the Pincode box was never read, and the Active/Inactive switch had no
        // effect on the account it created.
        public string Pincode { get; set; }
        public bool IsActive { get; set; } = true;

        public string DisplayName
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(FullName))
                    return FullName;
                if (!string.IsNullOrWhiteSpace(FirstName) || !string.IsNullOrWhiteSpace(LastName))
                    return $"{FirstName} {LastName}".Trim();
                if (!string.IsNullOrWhiteSpace(Email))
                    return Email;
                return "User";
            }
        }

        public string Location
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(City) && !string.IsNullOrWhiteSpace(State))
                    return $"{City}, {State}";
                if (!string.IsNullOrWhiteSpace(City))
                    return City;
                return "Rajkot, Gujarat";
            }
        }
    }
}
