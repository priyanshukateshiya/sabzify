using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabzify.Admin
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Last step of the admin reset flow. Nothing used to tie this request to
            // the two steps before it, so the form was directly addressable with no
            // email entered and no code verified. The verified address is held in this
            // visitor's own session, so the browser cannot supply it.
            if (AuthHelper.GetVerifiedResetEmail(true, Session) == null)
            {
                Response.Redirect("~/Admin/ForgotPassword.aspx", true);
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Only the account whose code was verified in this session may be reset,
            // and the typed password used to be discarded entirely.
            string email = AuthHelper.GetVerifiedResetEmail(true, Session);
            if (string.IsNullOrEmpty(email) || !AuthHelper.ResetAdminPassword(email, txtNewPassword.Text))
            {
                lblResetError.Text = "Your reset session has expired. Please start again.";
                lblResetError.Visible = true;
                return;
            }

            // Single use: the verified request must not survive the password change.
            AuthHelper.ClearResetRequest(Session);

            Response.Redirect("~/Admin/Login.aspx");
        }
    }
}
