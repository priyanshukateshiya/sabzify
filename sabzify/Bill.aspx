<%@ Page Title="Order Bill" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bill.aspx.cs" Inherits="sabzify.Bill" %>

<asp:Content ID="BillContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .bill-page {
            max-width: 850px;
            margin: 32px auto 60px;
            padding: 0 16px;
        }

        .bill-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .bill-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            font-weight: 500;
            color: #1B7A3A;
            text-decoration: none;
        }

        .bill-back:hover {
            text-decoration: underline;
        }

        .bill-download-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            border-radius: 8px;
            border: none;
            background: #1B7A3A;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(27, 122, 58, 0.25);
            transition: background 0.15s ease, transform 0.15s ease;
        }

        .bill-download-btn:hover {
            background: #166A32;
            transform: translateY(-1px);
        }

        .bill-card {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #E5E7EB;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
            padding: 40px;
        }

        .bill-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #E8F5E9;
            padding-bottom: 24px;
            margin-bottom: 28px;
        }

        .bill-brand-name {
            font-size: 28px;
            font-weight: 800;
            color: #1B7A3A;
            letter-spacing: -0.5px;
            margin: 0 0 4px;
        }

        .bill-brand-tagline {
            font-size: 13px;
            color: #6B7280;
            margin: 0;
        }

        .bill-invoice-meta {
            text-align: right;
        }

        .bill-invoice-title {
            font-size: 20px;
            font-weight: 700;
            color: #111827;
            margin: 0 0 4px;
        }

        .bill-invoice-num {
            font-size: 14px;
            font-weight: 600;
            color: #1B7A3A;
            margin: 0 0 2px;
        }

        .bill-invoice-date {
            font-size: 12px;
            color: #6B7280;
            margin: 0;
        }

        .bill-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            background: #F9FAFB;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 32px;
        }

        .bill-section-title {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #1B7A3A;
            margin: 0 0 8px;
        }

        .bill-info-line {
            font-size: 13px;
            color: #374151;
            margin: 0 0 4px;
        }

        .bill-info-line strong {
            color: #111827;
        }

        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }

        .bill-table th {
            background: #E8F5E9;
            color: #1B7A3A;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 14px;
            text-align: left;
        }

        .bill-table th:last-child {
            text-align: right;
        }

        .bill-table td {
            padding: 14px;
            border-bottom: 1px solid #F3F4F6;
            font-size: 13px;
            color: #374151;
        }

        .bill-table td:last-child {
            text-align: right;
            font-weight: 600;
            color: #111827;
        }

        .bill-table tbody tr:hover {
            background: #FAFAFA;
        }

        .bill-summary-wrap {
            display: flex;
            justify-content: flex-end;
            margin-top: 16px;
        }

        .bill-summary {
            width: 280px;
        }

        .bill-summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #4B5563;
            margin-bottom: 8px;
        }

        .bill-summary-row--total {
            border-top: 2px solid #E5E7EB;
            padding-top: 10px;
            font-size: 16px;
            font-weight: 700;
            color: #1B7A3A;
        }

        .bill-footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px dashed #E5E7EB;
            text-align: center;
            font-size: 12px;
            color: #6B7280;
        }

        @media (max-width: 640px) {
            .bill-card {
                padding: 24px 16px;
            }
            .bill-header {
                flex-direction: column;
                gap: 16px;
            }
            .bill-invoice-meta {
                text-align: left;
            }
            .bill-details-grid {
                grid-template-columns: 1fr;
            }
            .bill-summary {
                width: 100%;
            }
        }
    </style>

    <div class="bill-page">
        <div class="bill-toolbar">
            <a href="MyOrders.aspx" class="bill-back">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M20 11H7.8l5.6-5.6L12 4l-8 8 8 8 1.4-1.4L7.8 13H20v-2z"/></svg>
                Back to My Orders
            </a>
            <asp:Button ID="btnDownloadPdf" runat="server" Text="Download PDF" CssClass="bill-download-btn" OnClick="btnDownloadPdf_Click" />
        </div>

        <div class="bill-card">
            <div class="bill-header">
                <div>
                    <h1 class="bill-brand-name">Sabzify</h1>
                    <p class="bill-brand-tagline">Fresh vegetables delivered straight from local farms to your doorstep in Rajkot.</p>
                </div>
                <div class="bill-invoice-meta">
                    <div class="bill-invoice-title">TAX INVOICE / BILL</div>
                    <div class="bill-invoice-num">Order #<asp:Literal ID="litOrderId" runat="server" /></div>
                    <div class="bill-invoice-date">Date: <asp:Literal ID="litOrderDate" runat="server" /></div>
                </div>
            </div>

            <div class="bill-details-grid">
                <div>
                    <div class="bill-section-title">Customer Information</div>
                    <div class="bill-info-line"><strong>Name:</strong> <asp:Literal ID="litCustomerName" runat="server" /></div>
                    <div class="bill-info-line"><strong>Email:</strong> <asp:Literal ID="litCustomerEmail" runat="server" /></div>
                    <div class="bill-info-line"><strong>Phone:</strong> <asp:Literal ID="litCustomerPhone" runat="server" /></div>
                    <div class="bill-info-line"><strong>Address:</strong> <asp:Literal ID="litCustomerAddress" runat="server" /></div>
                </div>
                <div>
                    <div class="bill-section-title">Order Information</div>
                    <div class="bill-info-line"><strong>Order ID:</strong> <asp:Literal ID="litOrderId2" runat="server" /></div>
                    <div class="bill-info-line"><strong>Status:</strong> <asp:Literal ID="litStatus" runat="server" /></div>
                    <div class="bill-info-line"><strong>Payment Method:</strong> <span style="color: #1B7A3A; font-weight: 700;"><asp:Literal ID="litPaymentMethod" runat="server" /></span></div>
                    <div class="bill-info-line"><strong>Delivery:</strong> Standard Same-Day Delivery</div>
                </div>
            </div>

            <table class="bill-table">
                <thead>
                    <tr>
                        <th style="width: 40px;">#</th>
                        <th>Product Name</th>
                        <th>Unit</th>
                        <th style="text-align: center;">Qty</th>
                        <th style="text-align: right;">Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptItems" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Container.ItemIndex + 1 %></td>
                                <td><strong><%# Eval("ProductName") %></strong></td>
                                <td><%# Eval("Unit") %></td>
                                <td style="text-align: center;"><%# Eval("Quantity") %></td>
                                <td style="text-align: right;">&#8377;<%# Eval("Price") %></td>
                                <td>&#8377;<%# Eval("Total") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <div class="bill-summary-wrap">
                <div class="bill-summary">
                    <div class="bill-summary-row">
                        <span>Subtotal:</span>
                        <span>&#8377;<asp:Literal ID="litSubtotal" runat="server" /></span>
                    </div>
                    <div class="bill-summary-row">
                        <span>Delivery Fee:</span>
                        <%-- Was hardcoded "FREE" while the PDF from the Download button
                             printed the real charge, so the two disagreed on every order. --%>
                        <span style="color: #1B7A3A;"><asp:Literal ID="litDeliveryFee" runat="server" /></span>
                    </div>
                    <asp:PlaceHolder ID="phDiscount" runat="server" Visible="false">
                        <div class="bill-summary-row">
                            <span>Discount:</span>
                            <span style="color: #1B7A3A;">&#8722;&#8377;<asp:Literal ID="litDiscount" runat="server" /></span>
                        </div>
                    </asp:PlaceHolder>
                    <div class="bill-summary-row bill-summary-row--total">
                        <span>Grand Total:</span>
                        <span>&#8377;<asp:Literal ID="litGrandTotal" runat="server" /></span>
                    </div>
                </div>
            </div>

            <div class="bill-footer">
                <p>Thank you for shopping with Sabzify! For customer support, email support@sabzify.com or call +91 98765 43210.</p>
                <p>&copy; <%: DateTime.Now.Year %> Sabzify. All rights reserved.</p>
            </div>
        </div>
    </div>
</asp:Content>
