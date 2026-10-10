using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabzify.Admin
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);
        }

        protected void btnCreateUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string mobile = txtMobile.Text.Trim();
            // revMobile accepts a space or hyphen, so canonicalise to the 10 digits
            // before the number is stored or used to build the fallback e-mail key.
            mobile = new string(mobile.Where(char.IsDigit).ToArray());
            string password = txtPassword.Text;
            string street = txtStreet.Text.Trim();
            string city = txtCity.Text.Trim();
            string state = txtState.Text.Trim();
            string pincode = txtPincode.Text.Trim();

            string firstName = fullName;
            string lastName = "";
            int spaceIdx = fullName.IndexOf(' ');
            if (spaceIdx > 0)
            {
                firstName = fullName.Substring(0, spaceIdx).Trim();
                lastName = fullName.Substring(spaceIdx + 1).Trim();
            }

            var newUser = new User
            {
                FullName = fullName,
                FirstName = firstName,
                LastName = lastName,
                Email = string.IsNullOrEmpty(email) ? $"{mobile}@sabzify.com" : email,
                Mobile = mobile,
                Password = password,
                Address = street,
                City = city,
                State = state,
                Pincode = pincode,
                IsActive = chkStatus.Checked
            };

            if (!AuthHelper.Register(newUser, null))
            {
                cvDuplicateEmail.IsValid = false;
                return;
            }

            Response.Redirect("~/Admin/Users.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
