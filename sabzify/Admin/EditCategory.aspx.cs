using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class EditCategory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);

            if (!IsPostBack)
            {
                string catName = Request.QueryString["name"];
                if (!string.IsNullOrEmpty(catName))
                {
                    txtCategoryName.Text = catName;
                }

                // The description and the Status selection are deliberately left as the markup
                // renders them: only the name arrives from Categories.aspx, and there is no
                // category store to read the real values from. Inventing a description here
                // showed text that contradicted the one listed on Categories.aspx.
            }
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            Response.Redirect("~/Admin/Categories.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
