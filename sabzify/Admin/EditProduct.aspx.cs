using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sabzify.Admin
{
    public partial class EditProduct : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireAdminAuth(this);

            if (!IsPostBack)
            {
                // Resolve the id once and remember it, so btnSaveProduct_Click updates exactly
                // the record this form rendered - a bad or unknown ?id no longer loads product 1
                // and then saves nothing.
                int prodId;
                if (!int.TryParse(Request.QueryString["id"], out prodId) || ProductRepository.GetById(prodId) == null)
                {
                    prodId = 1;
                }

                ViewState["ProdId"] = prodId;

                var product = ProductRepository.GetById(prodId);
                if (product != null)
                {
                    litProductName.Text = Server.HtmlEncode(product.Name);
                    txtProductName.Text = product.Name;
                    txtDescription.Text = product.Description;
                    txtPrice.Text = product.Price.ToString("0.##");

                    string unitVal = (product.Unit ?? string.Empty).Trim();
                    if (string.Equals(unitVal, "GM", StringComparison.OrdinalIgnoreCase) ||
                        string.Equals(unitVal, "g", StringComparison.OrdinalIgnoreCase) ||
                        string.Equals(unitVal, "gram", StringComparison.OrdinalIgnoreCase) ||
                        string.Equals(unitVal, "grams", StringComparison.OrdinalIgnoreCase))
                    {
                        ddlUnit.SelectedValue = "GM";
                    }
                    else
                    {
                        ddlUnit.SelectedValue = "KG";
                    }

                    txtStock.Text = product.StockQuantity.ToString();

                    var catItem = ddlCategory.Items.FindByValue(product.Category);
                    if (catItem != null)
                    {
                        ddlCategory.SelectedValue = product.Category;
                    }

                    txtImageUrl.Text = product.ImageUrl;
                    imgPreview.ImageUrl = ResolveUrl("~/" + product.ImageUrl);

                    bool isActive = string.Equals(product.Status, "Active", StringComparison.OrdinalIgnoreCase);
                    rbStatusActive.Checked = isActive;
                    rbStatusDraft.Checked = !isActive;
                }
            }
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int prodId = Convert.ToInt32(ViewState["ProdId"] ?? 1);

            var product = ProductRepository.GetById(prodId);
            if (product == null)
            {
                cvSaveError.IsValid = false;
                return;
            }

            // The photo is resolved into a local first. ProductRepository.GetById hands back the
            // stored instance, so writing to it before the upload is accepted would leave a
            // half-applied edit behind an error message.
            string imageUrl = product.ImageUrl;
            if (fuProductImage.HasFile)
            {
                // Only image extensions are accepted, and the stored name is built from the
                // posted one rather than trusted, so nothing executable can be written under
                // the application directory.
                string ext = Path.GetExtension(fuProductImage.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif" && ext != ".webp")
                {
                    cvImage.Text = "Upload a .jpg, .png, .gif or .webp image";
                    cvImage.IsValid = false;
                    return;
                }

                var posted = fuProductImage.PostedFile;
                if (posted == null || posted.ContentLength == 0 || posted.ContentLength > 2 * 1024 * 1024)
                {
                    cvImage.Text = "Choose an image of 2 MB or smaller";
                    cvImage.IsValid = false;
                    return;
                }

                string fileName = SafeImageName(Path.GetFileNameWithoutExtension(fuProductImage.FileName)) + ext;
                try
                {
                    string savePath = Server.MapPath("~/Content/Images/" + fileName);
                    fuProductImage.SaveAs(savePath);
                    imageUrl = "Content/Images/" + fileName;
                }
                catch
                {
                    // Never keep the old photo silently - say the upload failed instead.
                    cvImage.Text = "The image could not be saved - try another file";
                    cvImage.IsValid = false;
                    return;
                }
            }
            else if (!string.IsNullOrWhiteSpace(txtImageUrl.Text))
            {
                imageUrl = txtImageUrl.Text.Trim();
            }

            product.Name = txtProductName.Text.Trim();
            product.Description = txtDescription.Text.Trim();

            if (decimal.TryParse(txtPrice.Text.Trim(), out decimal price))
            {
                product.Price = price;
            }

            product.Unit = ddlUnit.SelectedValue;

            if (int.TryParse(txtStock.Text.Trim(), out int stock))
            {
                product.StockQuantity = stock;
            }

            product.Category = ddlCategory.SelectedValue;
            product.Status = rbStatusActive.Checked ? "Active" : "Inactive";
            product.ImageUrl = imageUrl;

            ProductRepository.UpdateProduct(product);

            Response.Redirect("~/Admin/Products.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        // Keeps the posted file name recognisable but limits it to characters that are safe
        // in a URL and accepted by revImageUrl.
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
