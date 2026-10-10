using System;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;

namespace sabzify
{
    public static class PdfInvoiceHelper
    {
        public static byte[] GenerateInvoicePdf(Order order)
        {
            if (order == null)
            {
                throw new ArgumentNullException(nameof(order));
            }

            using (var doc = new PdfDocument())
            {
                doc.Info.Title = $"Sabzify Bill - {order.OrderId}";
                doc.Info.Subject = "Vegetable Purchase Invoice";
                doc.Info.Author = "Sabzify";

                var page = doc.AddPage();
                page.Width = XUnit.FromPoint(595); // A4 width
                page.Height = XUnit.FromPoint(842); // A4 height

                using (var gfx = XGraphics.FromPdfPage(page))
                {
                    var greenBrush = new XSolidBrush(XColor.FromArgb(27, 122, 58));
                    var lightGreenBrush = new XSolidBrush(XColor.FromArgb(234, 247, 238));
                    var darkBrush = new XSolidBrush(XColor.FromArgb(17, 24, 39));
                    var grayBrush = new XSolidBrush(XColor.FromArgb(107, 114, 128));
                    var linePen = new XPen(XColor.FromArgb(229, 231, 235), 1);
                    var greenPen = new XPen(XColor.FromArgb(27, 122, 58), 1.5);

                    var fontBrand = new XFont("Arial", 22, XFontStyle.Bold);
                    var fontTagline = new XFont("Arial", 9, XFontStyle.Regular);
                    var fontHeading = new XFont("Arial", 14, XFontStyle.Bold);
                    var fontSubhead = new XFont("Arial", 11, XFontStyle.Bold);
                    var fontBody = new XFont("Arial", 9.5, XFontStyle.Regular);
                    var fontBodyBold = new XFont("Arial", 9.5, XFontStyle.Bold);
                    var fontSmall = new XFont("Arial", 8.5, XFontStyle.Regular);

                    double left = 40;
                    double right = 555;
                    double y = 40;

                    // Brand & Invoice title
                    gfx.DrawString("Sabzify", fontBrand, greenBrush, left, y + 20);
                    gfx.DrawString("Fresh Vegetables Delivered in Rajkot", fontTagline, grayBrush, left, y + 34);

                    gfx.DrawString("TAX INVOICE / BILL", fontHeading, darkBrush, new XRect(left, y, right - left, 20), XStringFormats.TopRight);
                    gfx.DrawString($"Invoice #: {order.OrderId}", fontBodyBold, greenBrush, new XRect(left, y + 22, right - left, 15), XStringFormats.TopRight);
                    gfx.DrawString($"Date: {order.OrderDate}", fontSmall, grayBrush, new XRect(left, y + 36, right - left, 15), XStringFormats.TopRight);

                    y += 58;
                    gfx.DrawLine(greenPen, left, y, right, y);
                    y += 18;

                    // Customer & Order Information Box
                    double colWidth = (right - left) / 2 - 10;

                    // Left Column: Customer Details
                    gfx.DrawString("Billed To / Customer Details", fontSubhead, greenBrush, left, y);
                    y += 16;
                    gfx.DrawString($"Customer Name: {order.CustomerName}", fontBodyBold, darkBrush, left, y);
                    y += 14;
                    gfx.DrawString($"Email: {order.CustomerEmail}", fontBody, darkBrush, left, y);
                    y += 14;
                    gfx.DrawString($"Phone: {order.CustomerPhone}", fontBody, darkBrush, left, y);
                    y += 14;
                    gfx.DrawString($"Address: {order.DeliveryAddress}", fontBody, darkBrush, left, y);

                    // Right Column: Order Details
                    double rightColX = left + colWidth + 20;
                    double ry = y - 58;
                    gfx.DrawString("Order Information", fontSubhead, greenBrush, rightColX, ry);
                    ry += 16;
                    gfx.DrawString($"Order ID: {order.OrderId}", fontBodyBold, darkBrush, rightColX, ry);
                    ry += 14;
                    gfx.DrawString($"Status: {order.Status}", fontBody, darkBrush, rightColX, ry);
                    ry += 14;
                    gfx.DrawString($"Payment Method: {order.PaymentMethod}", fontBodyBold, darkBrush, rightColX, ry);
                    ry += 14;
                    gfx.DrawString("Delivery: Standard Same-Day", fontBody, darkBrush, rightColX, ry);

                    y += 30;

                    // Table Header
                    gfx.DrawRectangle(lightGreenBrush, left, y, right - left, 22);
                    gfx.DrawRectangle(linePen, left, y, right - left, 22);

                    double thY = y + 15;
                    gfx.DrawString("#", fontBodyBold, greenBrush, left + 8, thY);
                    gfx.DrawString("Item Description", fontBodyBold, greenBrush, left + 35, thY);
                    gfx.DrawString("Unit", fontBodyBold, greenBrush, left + 260, thY);
                    gfx.DrawString("Qty", fontBodyBold, greenBrush, left + 320, thY);
                    gfx.DrawString("Price (Rs.)", fontBodyBold, greenBrush, left + 380, thY);
                    gfx.DrawString("Total (Rs.)", fontBodyBold, greenBrush, new XRect(left + 450, y, (right - (left + 450) - 8), 22), XStringFormats.CenterRight);

                    y += 22;

                    // Table Rows
                    int index = 1;
                    foreach (var item in order.Items)
                    {
                        double rowH = 20;
                        if (index % 2 == 0)
                        {
                            gfx.DrawRectangle(new XSolidBrush(XColor.FromArgb(249, 250, 251)), left, y, right - left, rowH);
                        }
                        gfx.DrawRectangle(linePen, left, y, right - left, rowH);

                        double cellY = y + 14;
                        gfx.DrawString(index.ToString(), fontSmall, grayBrush, left + 8, cellY);
                        gfx.DrawString(item.ProductName, fontBody, darkBrush, left + 35, cellY);
                        gfx.DrawString(item.Unit, fontSmall, grayBrush, left + 260, cellY);
                        gfx.DrawString(item.Quantity.ToString(), fontBody, darkBrush, left + 325, cellY);
                        gfx.DrawString(item.Price.ToString("0.00"), fontBody, darkBrush, left + 380, cellY);
                        gfx.DrawString(item.Total.ToString("0.00"), fontBodyBold, darkBrush, new XRect(left + 450, y, (right - (left + 450) - 8), rowH), XStringFormats.CenterRight);

                        y += rowH;
                        index++;
                    }

                    y += 16;

                    // Totals Box
                    double totalsWidth = 220;
                    double totalsLeft = right - totalsWidth;

                    gfx.DrawString("Subtotal:", fontBody, darkBrush, totalsLeft, y);
                    gfx.DrawString($"Rs. {order.Subtotal:0.00}", fontBody, darkBrush, new XRect(totalsLeft, y - 10, totalsWidth, 14), XStringFormats.TopRight);
                    y += 15;

                    gfx.DrawString("Delivery Charge:", fontBody, darkBrush, totalsLeft, y);
                    gfx.DrawString($"Rs. {order.DeliveryCharge:0.00}", fontBody, darkBrush, new XRect(totalsLeft, y - 10, totalsWidth, 14), XStringFormats.TopRight);
                    y += 15;

                    if (order.Discount > 0)
                    {
                        gfx.DrawString("Discount:", fontBody, greenBrush, totalsLeft, y);
                        gfx.DrawString($"- Rs. {order.Discount:0.00}", fontBody, greenBrush, new XRect(totalsLeft, y - 10, totalsWidth, 14), XStringFormats.TopRight);
                        y += 15;
                    }

                    gfx.DrawLine(linePen, totalsLeft, y - 4, right, y - 4);
                    y += 4;

                    gfx.DrawRectangle(lightGreenBrush, totalsLeft - 5, y - 4, totalsWidth + 5, 24);
                    gfx.DrawRectangle(greenPen, totalsLeft - 5, y - 4, totalsWidth + 5, 24);
                    gfx.DrawString("Grand Total:", fontSubhead, greenBrush, totalsLeft, y + 13);
                    gfx.DrawString($"Rs. {order.TotalAmount:0.00}", fontHeading, greenBrush, new XRect(totalsLeft, y - 2, totalsWidth - 4, 22), XStringFormats.CenterRight);

                    // Payment method stamp
                    y += 40;
                    gfx.DrawRectangle(new XSolidBrush(XColor.FromArgb(243, 244, 246)), left, y, 240, 44);
                    gfx.DrawRectangle(linePen, left, y, 240, 44);
                    gfx.DrawString("Payment Method:", fontSmall, grayBrush, left + 10, y + 15);
                    gfx.DrawString(order.PaymentMethod, fontBodyBold, greenBrush, left + 10, y + 31);

                    // Footer message
                    double footerY = page.Height.Point - 45;
                    gfx.DrawLine(linePen, left, footerY - 10, right, footerY - 10);
                    gfx.DrawString("Thank you for choosing Sabzify! Farm-fresh vegetables delivered directly to your doorstep in Rajkot.", fontSmall, grayBrush, new XRect(left, footerY, right - left, 14), XStringFormats.Center);
                    gfx.DrawString("For questions or support, contact support@sabzify.com | Tel: +91 98765 43210", fontSmall, grayBrush, new XRect(left, footerY + 14, right - left, 14), XStringFormats.Center);
                }

                using (var ms = new MemoryStream())
                {
                    doc.Save(ms, false);
                    return ms.ToArray();
                }
            }
        }
    }
}
