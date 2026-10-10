using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabzify.Admin
{
    public partial class AddCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);
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
