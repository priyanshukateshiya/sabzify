namespace sabzify.Admin
{


    public partial class EditProduct
    {
        protected global::System.Web.UI.WebControls.Button btnCancel;

        protected global::System.Web.UI.WebControls.Button btnSaveProduct;

        protected global::System.Web.UI.WebControls.ValidationSummary vsProduct;

        protected global::System.Web.UI.WebControls.Literal litProductName;

        protected global::System.Web.UI.WebControls.CustomValidator cvSaveError;

        protected global::System.Web.UI.WebControls.Label lblProductImage;
        protected global::System.Web.UI.WebControls.Image imgPreview;
        protected global::System.Web.UI.WebControls.FileUpload fuProductImage;
        protected global::System.Web.UI.WebControls.TextBox txtImageUrl;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revImageUrl;
        protected global::System.Web.UI.WebControls.CustomValidator cvImage;

        protected global::System.Web.UI.WebControls.Label lblProductName;

        protected global::System.Web.UI.WebControls.TextBox txtProductName;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvProductName;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revProductName;

        protected global::System.Web.UI.WebControls.Label lblDescription;

        protected global::System.Web.UI.WebControls.TextBox txtDescription;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvDescription;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revDescription;

        protected global::System.Web.UI.WebControls.Label lblPrice;

        protected global::System.Web.UI.WebControls.TextBox txtPrice;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPrice;

        protected global::System.Web.UI.WebControls.RegularExpressionValidator revPrice;

        protected global::System.Web.UI.WebControls.RangeValidator rvPrice;

        protected global::System.Web.UI.WebControls.Label lblUnit;

        protected global::System.Web.UI.WebControls.DropDownList ddlUnit;

        protected global::System.Web.UI.WebControls.Label lblStock;

        protected global::System.Web.UI.WebControls.TextBox txtStock;

        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvStock;

        protected global::System.Web.UI.WebControls.RangeValidator rvStock;

        protected global::System.Web.UI.WebControls.Label lblCategory;

        protected global::System.Web.UI.WebControls.DropDownList ddlCategory;

        protected global::System.Web.UI.WebControls.RadioButton rbStatusActive;

        protected global::System.Web.UI.WebControls.RadioButton rbStatusDraft;
    }
}
