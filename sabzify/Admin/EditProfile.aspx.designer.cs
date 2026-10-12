namespace sabzify.Admin
{


    public partial class EditProfile
    {

        protected global::System.Web.UI.WebControls.PlaceHolder phUploadTooLarge;

        protected global::System.Web.UI.WebControls.FileUpload fuPhoto;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revPhotoType;

        protected global::System.Web.UI.WebControls.CustomValidator cvPhotoSize;

        protected global::System.Web.UI.WebControls.Label lblFullName;

        protected global::System.Web.UI.WebControls.TextBox txtFullName;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvFullName;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revFullName;

        protected global::System.Web.UI.WebControls.Label lblEmail;

        protected global::System.Web.UI.WebControls.TextBox txtEmail;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEmail;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revEmail;

        protected global::System.Web.UI.WebControls.Label lblMobile;

        protected global::System.Web.UI.WebControls.TextBox txtMobile;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvMobile;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revMobile;

        protected global::System.Web.UI.WebControls.Label lblOldPassword;

        protected global::System.Web.UI.WebControls.TextBox txtOldPassword;

        protected global::System.Web.UI.WebControls.CustomValidator cvOldPassword;

        protected global::System.Web.UI.WebControls.Label lblNewPassword;

        protected global::System.Web.UI.WebControls.TextBox txtNewPassword;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revNewPassword;

        protected global::System.Web.UI.WebControls.Label lblConfirmPassword;

        protected global::System.Web.UI.WebControls.TextBox txtConfirmPassword;

        protected global::System.Web.UI.WebControls.CustomValidator cvConfirmRequired;

        protected global::System.Web.UI.WebControls.CompareValidator cmpConfirmPassword;

        protected global::System.Web.UI.WebControls.Label lblLanguage;

        protected global::System.Web.UI.WebControls.DropDownList ddlLanguage;

        protected global::System.Web.UI.WebControls.CheckBox chkEmailNotifications;

        protected global::System.Web.UI.WebControls.Label lblEmailNotifications;

        protected global::System.Web.UI.WebControls.CheckBox chkSmsAlerts;

        protected global::System.Web.UI.WebControls.Label lblSmsAlerts;


        protected global::System.Web.UI.WebControls.ValidationSummary vsAdminProfile;

        protected global::System.Web.UI.WebControls.Button btnSave;
    }
}
