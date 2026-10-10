using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSendReset_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // The typed address used to be ignored entirely: any syntactically valid
            // email walked into the code step, and nothing was carried forward, so the
            // later pages had no idea whose password was being reset.
            // IssueResetCode returns null when the address is not an administrator; we
            // redirect the same way either way so this page cannot be used to find out
            // which addresses exist.
            AuthHelper.IssueResetCode(txtEmail.Text.Trim(), true, Session);

            Response.Redirect("~/Admin/VerifyCode.aspx");
        }
    }
}
