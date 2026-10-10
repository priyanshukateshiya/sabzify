using System;
using System.IO;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class AddProduct : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            decimal price = 0;
            decimal.TryParse(txtPrice.Text.Trim(), out price);

            int stock = 0;
            int.TryParse(txtStock.Text.Trim(), out stock);

            string imagePath = "Content/Images/tomato.png";
            if (fuImage.HasFile)
            {
                // Only image extensions are accepted, and the stored name is built from the
                // posted one rather than trusted, so nothing executable can be written under
                // the application directory.
                string ext = Path.GetExtension(fuImage.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif" && ext != ".webp")
                {
                    cvImage.Text = "Upload a .jpg, .png, .gif or .webp image";
                    cvImage.IsValid = false;
                    return;
                }

                var posted = fuImage.PostedFile;
                if (posted == null || posted.ContentLength == 0 || posted.ContentLength > 2 * 1024 * 1024)
                {
                    cvImage.Text = "Choose an image of 2 MB or smaller";
                    cvImage.IsValid = false;
                    return;
                }

                string fileName = SafeImageName(Path.GetFileNameWithoutExtension(fuImage.FileName)) + ext;
                try
                {
                    string savePath = Server.MapPath("~/Content/Images/" + fileName);
                    fuImage.SaveAs(savePath);
                    imagePath = "Content/Images/" + fileName;
                }
                catch
                {
                    // Never fall back to another product's photo silently - say so instead.
                    cvImage.Text = "The image could not be saved - try another file";
                    cvImage.IsValid = false;
                    return;
                }
            }

            var newProduct = new Product
            {
                Name = txtProductName.Text.Trim(),
                Description = txtDescription.Text.Trim(),
                Category = ddlCategory.SelectedValue,
                Price = price,
                Unit = ddlUnit.SelectedValue,
                StockQuantity = stock,
                ImageUrl = imagePath,
                Status = rbStatusActive.Checked ? "Active" : "Inactive",
                IsOrganic = chkOrganic.Checked,
                Popularity = 80
            };

            ProductRepository.AddProduct(newProduct);

            Response.Redirect("~/Admin/Products.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        // Keeps the posted file name recognisable but limits it to characters that are safe
        // in a URL and accepted by EditProduct's image-path validator.
        private static string SafeImageName(string rawName)
        {
            string source = rawName ?? string.Empty;
            char[] buffer = new char[Math.Min(source.Length, 60)];
            int length = 0;
            foreach (char c in source)
            {
                if (length == buffer.Length)
                {
                    break;
                }

                bool safe = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
                            (c >= '0' && c <= '9') || c == '-' || c == '_';
                buffer[length] = safe ? c : '_';
                length++;
            }

            string cleaned = new string(buffer, 0, length).Trim('_');
            return cleaned.Length == 0 ? "product" : cleaned;
        }
    }
}
