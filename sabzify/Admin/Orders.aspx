<%@ Page Title="Orders & Reports" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="sabzify.Admin.Orders" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" Culture="en-US" %>

<%-- Culture="en-US": the CompareValidators (Type="Date") parse dates in the page
     culture. The server default here is en-IN (dd/mm/yyyy), which would reject
     the mm/dd/yyyy format this form asks for. --%>

<asp:Content ID="OrdersTitle" ContentPlaceHolderID="TitleContent" runat="server">Orders &amp; Reports</asp:Content>

<asp:Content ID="OrdersHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .orders-page {
            color: #111827;
        }

        .orders-page .page-title {
            margin: 0 0 16px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.3;
            color: #111827;
        }

        /* Cards -------------------------------------------------------------------- */
        .orders-page .card {
            background: #fff;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04), 0 1px 2px rgba(17, 24, 39, .03);
        }

        .orders-page .panel {
            overflow: hidden;
        }

        .orders-page .panel-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: 13px 16px;
            border-bottom: 1px solid #EDF1F5;
        }

        .orders-page .panel-title {
            margin: 0;
            font-size: 13px;
            font-weight: 600;
            line-height: 1.35;
            color: #111827;
        }

        .orders-page .panel-link {
            font-size: 10px;
            font-weight: 600;
            color: #1B7A3A;
            text-decoration: none;
        }

        .orders-page .panel-link:hover {
            text-decoration: underline;
        }

        .orders-page .alert-icon {
            flex: none;
            width: 15px;
            height: 15px;
            color: #D64545;
        }

        /* Filter bar --------------------------------------------------------------- */
        .orders-page .filter-card {
            margin-bottom: 16px;
            padding: 14px 16px;
        }

        /* Rows align from the top; the button sits under an invisible label-sized
           spacer so it lines up with the inputs. Errors then grow downward inside
           their own field and never move the button. */
        .orders-page .filter-row {
            display: flex;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 14px;
        }

        .orders-page .of-field {
            width: 130px;
        }

        .orders-page .of-field label,
        .orders-page .of-spacer {
            display: block;
            margin-bottom: 5px;
            font-size: 10px;
            font-weight: 600;
            line-height: 1.3;
            color: #374151;
        }

        .orders-page .of-spacer {
            visibility: hidden;
        }

        .orders-page .of-field input[type="text"] {
            display: block;
            width: 130px;
            height: 30px;
            padding: 0 10px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 10.5px;
            color: #111827;
            box-sizing: border-box;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .orders-page .of-field input[type="text"]::placeholder {
            color: #9CA3AF;
        }

        .orders-page .of-field input[type="text"]:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .14);
        }

        .orders-page .of-action {
            flex: none;
        }

        .orders-page .btn-filter {
            display: block;
            height: 30px;
            padding: 0 16px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .orders-page .btn-filter:hover {
            background: #166631;
        }

        .orders-page .field-error {
            display: block;
            margin-top: 3px;
            font-size: 9.5px;
            line-height: 1.35;
            color: #C0392B;
        }

        .orders-page .field-error:not([style*="display:none"]):not([style*="display: none"]) {
            display: block !important;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variant is more specific than the plain :focus rule, so the green
           ring cannot override the red border. */
        .orders-page .of-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"] {
            border-color: #C0392B;
        }

        .orders-page .of-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        .orders-page .summary-error {
            margin-top: 10px;
            font-size: 10px;
            line-height: 1.4;
            color: #C0392B;
        }

        .orders-page .summary-error:empty {
            display: none;
        }

        /* Main grid ---------------------------------------------------------------- */
        .orders-page .orders-grid {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 215px;
            grid-template-areas:
                "recent side"
                "top    side";
            grid-template-rows: auto 1fr;
            gap: 16px;
            align-items: start;
        }

        .orders-page .area-recent {
            grid-area: recent;
        }

        .orders-page .area-top {
            grid-area: top;
        }

        .orders-page .orders-side {
            grid-area: side;
            display: flex;
            flex-direction: column;
            gap: 16px;
            min-width: 0;
        }

        /* Tables ------------------------------------------------------------------- */
        .orders-page .table-scroll {
            width: 100%;
        }

        .orders-page table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-page .data-table th {
            padding: 9px 16px;
            background: #F7F9F4;
            border-bottom: 1px solid #EDF1F5;
            font-size: 9px;
            font-weight: 600;
            line-height: 1.3;
            color: #6B7280;
            text-align: left;
            white-space: nowrap;
        }

        .orders-page .data-table td {
            padding: 12px 16px;
            border-bottom: 1px solid #F3F5F1;
            font-size: 10px;
            line-height: 1.4;
            vertical-align: middle;
        }

        .orders-page .data-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .orders-page .data-table .num {
            text-align: right;
        }

        /* Recent orders */
        .orders-page .col-order {
            font-weight: 600;
            color: #111827;
            white-space: nowrap;
        }

        /* Widths include the 32px cell padding (the admin shell is border-box):
           ~44px of text, so names and dates wrap to two lines as in the design. */
        .orders-page .col-customer {
            width: 76px;
            color: #374151;
        }

        .orders-page .col-date {
            width: 76px;
            color: #6B7280;
        }

        .orders-page .col-amount {
            font-size: 11px;
            font-weight: 700;
            line-height: 1.3;
            color: #1B7A3A;
        }

        .orders-page .col-amount span {
            display: block;
        }

        .orders-page .status-select {
            height: 24px;
            padding: 0 6px;
            border: 1px solid #E1E6EA;
            border-radius: 5px;
            background: #fff;
            font-family: inherit;
            font-size: 9.5px;
            color: #374151;
            cursor: pointer;
            outline: none;
        }

        .orders-page .status-select:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .14);
        }

        /* Top selling products */
        .orders-page .top-table td {
            padding: 11px 16px;
        }

        .orders-page .col-rank,
        .orders-page .col-category {
            color: #6B7280;
        }

        .orders-page .col-product,
        .orders-page .col-units {
            font-weight: 600;
            color: #111827;
        }

        /* Side panels */
        .orders-page .mini-table th {
            padding: 9px 14px;
            border-bottom: 1px solid #EDF1F5;
            font-size: 9px;
            font-weight: 600;
            line-height: 1.3;
            color: #6B7280;
            text-align: left;
        }

        .orders-page .mini-table td {
            padding: 9px 14px;
            border-bottom: 1px solid #F6F7F5;
            font-size: 9.5px;
            line-height: 1.4;
            color: #374151;
        }

        .orders-page .mini-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .orders-page .mini-table .num {
            text-align: right;
        }

        .orders-page .sales-table .col-count {
            font-weight: 600;
            color: #111827;
        }

        .orders-page .stock-table th {
            padding: 8px 14px;
            border-bottom-color: #F1F3EF;
            font-size: 8.5px;
            color: #9CA3AF;
        }

        .orders-page .stock-table .col-stock {
            font-weight: 600;
            color: #C0392B;
        }

        /* Status toast (UI only) --------------------------------------------------- */
        .orders-page .status-toast {
            position: fixed;
            right: 20px;
            bottom: 20px;
            z-index: 50;
            display: flex;
            align-items: center;
            gap: 7px;
            padding: 9px 14px;
            border-radius: 7px;
            background: #1B7A3A;
            box-shadow: 0 6px 18px rgba(17, 24, 39, .18);
            font-size: 11px;
            font-weight: 600;
            color: #fff;
            opacity: 0;
            transform: translateY(8px);
            pointer-events: none;
            transition: opacity .2s ease, transform .2s ease;
        }

        .orders-page .status-toast svg {
            width: 14px;
            height: 14px;
        }

        .orders-page .status-toast.is-shown {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive --------------------------------------------------------------- */
        @media screen and (max-width: 1100px) {
            .orders-page .orders-grid {
                grid-template-columns: minmax(0, 1fr);
                grid-template-areas:
                    "recent"
                    "side"
                    "top";
                grid-template-rows: auto;
            }

            .orders-page .orders-side {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                align-items: start;
            }
        }

        @media screen and (max-width: 900px) {
            /* Dates share one row; the button drops below them. */
            .orders-page .of-action {
                flex-basis: 100%;
            }

            .orders-page .of-spacer {
                display: none;
            }
        }

        @media screen and (max-width: 700px) {
            .orders-page .table-scroll {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .orders-page .table-scroll > table {
                min-width: 560px;
            }

            .orders-page .orders-side {
                grid-template-columns: minmax(0, 1fr);
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .orders-page) {
                padding: 18px 14px;
            }

            .orders-page .of-field {
                flex: 1 1 100%;
                width: 100%;
            }

            .orders-page .of-field input[type="text"] {
                width: 100%;
            }

            .orders-page .btn-filter {
                width: 100%;
            }

            .orders-page .status-toast {
                right: 14px;
                left: 14px;
                justify-content: center;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="OrdersBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="orders-page">
        <h1 class="page-title">Order Management &amp; Reports</h1>

        <%-- A) Date filter ------------------------------------------------------------ --%>
        <div class="card filter-card">
            <div class="filter-row">
                <div class="of-field">
                    <asp:Label ID="lblStartDate" runat="server" AssociatedControlID="txtStartDate">Start Date</asp:Label>
                    <asp:TextBox ID="txtStartDate" runat="server" placeholder="mm/dd/yyyy" />
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="txtStartDate"
                        ErrorMessage="Start date is required" ValidationGroup="OrderFilter" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:CompareValidator ID="cvStartDateFormat" runat="server" ControlToValidate="txtStartDate"
                        Operator="DataTypeCheck" Type="Date"
                        ErrorMessage="Use mm/dd/yyyy" ValidationGroup="OrderFilter" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>

                <div class="of-field">
                    <asp:Label ID="lblEndDate" runat="server" AssociatedControlID="txtEndDate">End Date</asp:Label>
                    <asp:TextBox ID="txtEndDate" runat="server" placeholder="mm/dd/yyyy" />
                    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="txtEndDate"
                        ErrorMessage="End date is required" ValidationGroup="OrderFilter" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:CompareValidator ID="cvEndDateFormat" runat="server" ControlToValidate="txtEndDate"
                        Operator="DataTypeCheck" Type="Date"
                        ErrorMessage="Use mm/dd/yyyy" ValidationGroup="OrderFilter" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:CompareValidator ID="cvEndAfterStart" runat="server" ControlToValidate="txtEndDate"
                        ControlToCompare="txtStartDate" Operator="GreaterThanEqual" Type="Date"
                        ErrorMessage="End date must be on or after the start date" ValidationGroup="OrderFilter" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>

                <div class="of-action">
                    <span class="of-spacer" aria-hidden="true">&nbsp;</span>
                    <asp:Button ID="btnFilter" runat="server" Text="Filter Results" CssClass="btn-filter"
                        ValidationGroup="OrderFilter" />
                </div>
            </div>

            <asp:ValidationSummary ID="vsOrderFilter" runat="server" ValidationGroup="OrderFilter"
                DisplayMode="SingleParagraph" HeaderText="" ShowMessageBox="false" CssClass="summary-error" />
        </div>

        <div class="orders-grid">
            <%-- Recent Orders ----------------------------------------------------------- --%>
            <section class="card panel area-recent">
                <div class="panel-head">
                    <h2 class="panel-title">Recent Orders</h2>
                    <%-- Placeholder: no full orders list page exists yet. --%>
                    <a class="panel-link" href="#">View All</a>
                </div>
                <div class="table-scroll">
                    <table class="data-table orders-table">
                        <thead>
                            <tr>
                                <th scope="col">Order No</th>
                                <th scope="col">Customer</th>
                                <th scope="col">Date</th>
                                <th scope="col">Amount</th>
                                <th scope="col">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="col-order">ORD001</td>
                                <td class="col-customer">Kiran Patel</td>
                                <td class="col-date">Oct 24, 2024</td>
                                <td class="col-amount"><span>&#8377;</span><span>450</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus1" runat="server" CssClass="status-select" AutoPostBack="false" aria-label="Status for ORD001">
                                        <asp:ListItem Text="Confirmed" Value="Confirmed" Selected="True" />
                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                                        <asp:ListItem Text="Delivered" Value="Delivered" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-order">ORD002</td>
                                <td class="col-customer">Rajesh Mehta</td>
                                <td class="col-date">Oct 24, 2024</td>
                                <td class="col-amount"><span>&#8377;</span><span>820</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus2" runat="server" CssClass="status-select" AutoPostBack="false" aria-label="Status for ORD002">
                                        <asp:ListItem Text="Confirmed" Value="Confirmed" />
                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" Selected="True" />
                                        <asp:ListItem Text="Delivered" Value="Delivered" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-order">ORD003</td>
                                <td class="col-customer">Bhavna Joshi</td>
                                <td class="col-date">Oct 23, 2024</td>
                                <td class="col-amount"><span>&#8377;</span><span>310</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus3" runat="server" CssClass="status-select" AutoPostBack="false" aria-label="Status for ORD003">
                                        <asp:ListItem Text="Confirmed" Value="Confirmed" />
                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                                        <asp:ListItem Text="Delivered" Value="Delivered" Selected="True" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="col-order">ORD004</td>
                                <td class="col-customer">Amit Desai</td>
                                <td class="col-date">Oct 23, 2024</td>
                                <td class="col-amount"><span>&#8377;</span><span>1,250</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus4" runat="server" CssClass="status-select" AutoPostBack="false" aria-label="Status for ORD004">
                                        <asp:ListItem Text="Confirmed" Value="Confirmed" />
                                        <asp:ListItem Text="Out for Delivery" Value="Out for Delivery" />
                                        <asp:ListItem Text="Delivered" Value="Delivered" />
                                        <asp:ListItem Text="Pending" Value="Pending" Selected="True" />
                                        <asp:ListItem Text="Cancelled" Value="Cancelled" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <%-- Right column ------------------------------------------------------------ --%>
            <div class="orders-side">
                <section class="card panel">
                    <div class="panel-head">
                        <h2 class="panel-title">Daily Sales Overview</h2>
                    </div>
                    <table class="mini-table sales-table">
                        <thead>
                            <tr>
                                <th scope="col">Date</th>
                                <th scope="col" class="num">Orders</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Oct 24, 2024</td>
                                <td class="num col-count">142</td>
                            </tr>
                            <tr>
                                <td>Oct 23, 2024</td>
                                <td class="num col-count">128</td>
                            </tr>
                            <tr>
                                <td>Oct 22, 2024</td>
                                <td class="num col-count">156</td>
                            </tr>
                        </tbody>
                    </table>
                </section>

                <section class="card panel">
                    <div class="panel-head">
                        <h2 class="panel-title">Low Stock Alerts</h2>
                        <svg class="alert-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" />
                        </svg>
                    </div>
                    <table class="mini-table stock-table">
                        <thead>
                            <tr>
                                <th scope="col">Product</th>
                                <th scope="col" class="num">Stock (kg)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Organic Tomatoes</td>
                                <td class="num col-stock">5</td>
                            </tr>
                            <tr>
                                <td>Fresh Spinach</td>
                                <td class="num col-stock">2</td>
                            </tr>
                            <tr>
                                <td>Local Potatoes</td>
                                <td class="num col-stock">8</td>
                            </tr>
                        </tbody>
                    </table>
                </section>
            </div>

            <%-- Top Selling Products ------------------------------------------------------ --%>
            <section class="card panel area-top">
                <div class="panel-head">
                    <h2 class="panel-title">Top Selling Products (This Week)</h2>
                </div>
                <div class="table-scroll">
                    <table class="data-table top-table">
                        <thead>
                            <tr>
                                <th scope="col">Rank</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Category</th>
                                <th scope="col" class="num">Units Sold (kg)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="col-rank">1</td>
                                <td class="col-product">Organic Potatoes</td>
                                <td class="col-category">Root Vegetables</td>
                                <td class="num col-units">450</td>
                            </tr>
                            <tr>
                                <td class="col-rank">2</td>
                                <td class="col-product">Desi Tomatoes</td>
                                <td class="col-category">Fruiting Vegetables</td>
                                <td class="num col-units">320</td>
                            </tr>
                            <tr>
                                <td class="col-rank">3</td>
                                <td class="col-product">Fresh Coriander</td>
                                <td class="col-category">Leafy Greens</td>
                                <td class="num col-units">280</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <div class="status-toast" id="statusToast" role="status" aria-live="polite">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <polyline points="20 6 9 17 4 12" />
            </svg>
            <span>Status updated</span>
        </div>
    </div>

    <%-- UI only: the status dropdowns never post back; a change just flashes the toast. --%>
    <script>
        (function () {
            var toast = document.getElementById('statusToast');
            var timer;
            var selects = document.querySelectorAll('.orders-page .status-select');
            Array.prototype.forEach.call(selects, function (select) {
                select.addEventListener('change', function () {
                    toast.classList.add('is-shown');
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        toast.classList.remove('is-shown');
                    }, 2000);
                });
            });
        })();
    </script>
</asp:Content>
