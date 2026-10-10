using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class Products : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);

            if (!IsPostBack)
            {
                BindProducts();
            }
        }

        public static string FormatUnit(object unitObj)
        {
            string unit = unitObj?.ToString()?.Trim();
            if (string.IsNullOrEmpty(unit)) return "KG";
            if (string.Equals(unit, "GM", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(unit, "g", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(unit, "gram", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(unit, "grams", StringComparison.OrdinalIgnoreCase))
            {
                return "GM";
            }
            return "KG";
        }

        private void BindProducts()
        {
            var list = ProductRepository.GetAllProducts();
            rptProducts.DataSource = list;
            rptProducts.DataBind();
            litCount.Text = $"Showing 1–{list.Count} of {list.Count} Products";
        }
    }
}
