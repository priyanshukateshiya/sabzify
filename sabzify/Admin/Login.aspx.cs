using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (AuthHelper.IsAdminLoggedIn(Session))
                {
                    Response.Redirect("~/Admin/Dashboard.aspx", true);
                }
            }
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (AuthHelper.AdminLogin(email, password, Session))
            {
                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrEmpty(returnUrl) &&
                    (returnUrl.StartsWith("/") || returnUrl.StartsWith("~/")) &&
                    !returnUrl.StartsWith("//"))
                {
                    Response.Redirect(returnUrl, true);
                }
                else
                {
                    Response.Redirect("~/Admin/Dashboard.aspx", true);
                }
            }
            else
            {
                lblError.Text = "Invalid admin email or password. Please check your credentials.";
                lblError.Visible = true;
            }
        }
    }
}
