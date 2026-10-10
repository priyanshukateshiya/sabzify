using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class VerifyCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This step is only reachable after Admin/ForgotPassword issued a code.
            // Without this guard the page was directly addressable, so the OTP gate
            // could simply be walked around.
            if (!AuthHelper.HasPendingResetRequest(true, Session))
            {
                Response.Redirect("~/Admin/ForgotPassword.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnVerifyCode_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string code = string.Concat(
                txtCode1.Text.Trim(), txtCode2.Text.Trim(), txtCode3.Text.Trim(),
                txtCode4.Text.Trim(), txtCode5.Text.Trim(), txtCode6.Text.Trim());

            // The six boxes used to be read by nobody: the validators only proved each
            // box held one digit, so 000000 opened the reset step exactly like the real
            // code. Now they are compared with the code issued to this session, which
            // is single-use, expires, and is rate-limited.
            if (!AuthHelper.VerifyResetCode(code, true, Session))
            {
                lblCodeError.Text = "That code is not correct, or it has expired. Please request a new one.";
                lblCodeError.Visible = true;
                return;
            }

            Response.Redirect("~/Admin/ResetPassword.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
