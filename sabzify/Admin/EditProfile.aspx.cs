using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabzify.Admin
{
    public partial class EditProfile : System.Web.UI.Page
    {
        private const int MaxPhotoBytes = 2 * 1024 * 1024;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // No photo selected is valid: the admin keeps the current photo.
        protected void cvPhotoSize_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !fuPhoto.HasFile || fuPhoto.PostedFile.ContentLength <= MaxPhotoBytes;
        }

        // The current password is only needed when a new one is being set.
        protected void cvOldPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = txtNewPassword.Text.Length == 0 || txtOldPassword.Text.Length > 0;
        }

        // The confirmation is only needed when a new password is being set.
        protected void cvConfirmRequired_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = txtNewPassword.Text.Length == 0 || txtConfirmPassword.Text.Length > 0;
        }
    }
}
