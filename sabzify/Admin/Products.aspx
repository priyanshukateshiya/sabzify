<%@ Page Title="Products" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="sabzify.Admin.Products" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="ProductsTitle" ContentPlaceHolderID="TitleContent" runat="server">Products</asp:Content>

<asp:Content ID="ProductsHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .prod-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        .prod-page .prod-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 16px;
        }

        .prod-page .prod-title {
            margin: 0 0 5px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .prod-page .prod-sub {
            margin: 0;
            font-size: 11.5px;
            color: #6B7280;
        }

        .prod-page .prod-add {
            display: inline-flex;
            align-items: center;
            flex: none;
            gap: 6px;
            height: 32px;
            padding: 0 16px;
            border-radius: 6px;
            background: #1B7A3A;
            font-size: 11.5px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            white-space: nowrap;
            transition: background-color .15s ease;
        }

        .prod-page .prod-add:hover,
        .prod-page .prod-add:focus {
            background: #166A32;
        }

        .prod-page .prod-add svg {
            width: 12px;
            height: 12px;
        }

        /* Toolbar -------------------------------------------------------------- */
        .prod-page .prod-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 14px;
        }

        .prod-page .prod-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .prod-page .filter-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            height: 30px;
            padding: 0 12px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 11px;
            color: #374151;
            cursor: pointer;
            transition: border-color .15s ease;
        }

        .prod-page .filter-btn:hover,
        .prod-page .filter-btn:focus {
            border-color: #1B7A3A;
        }

        .prod-page .filter-btn svg {
            width: 13px;
            height: 13px;
            color: #6B7280;
        }

        .prod-page .prod-count {
            font-size: 11px;
            color: #6B7280;
            white-space: nowrap;
        }

        /* Table card ----------------------------------------------------------- */
        .prod-page .prod-card {
            overflow: hidden;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .prod-page .prod-table-wrap {
            width: 100%;
        }

        .prod-page .prod-table {
            width: 100%;
            border-collapse: collapse;
        }

        .prod-page .prod-table th {
            padding: 11px 16px;
            border-bottom: 1px solid #EDF1F5;
            background: #F7F9F4;
            font-size: 10px;
            font-weight: 600;
            text-align: left;
            color: #6B7280;
            white-space: nowrap;
        }

        .prod-page .prod-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #F3F5F1;
            font-size: 11.5px;
            vertical-align: middle;
            white-space: nowrap;
        }

        .prod-page .prod-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .prod-page .prod-table .col-check {
            width: 44px;
            padding-right: 0;
        }

        .prod-page .prod-table .col-center {
            text-align: center;
        }

        .prod-page .prod-table input[type="checkbox"] {
            display: block;
            width: 14px;
            height: 14px;
            margin: 0;
            accent-color: #1B7A3A;
            cursor: pointer;
        }

        .prod-page .prod-name {
            font-size: 12px;
            font-weight: 600;
            color: #111827;
            text-decoration: none;
        }

        .prod-page .prod-name:hover,
        .prod-page .prod-name:focus {
            color: #1B7A3A;
            text-decoration: underline;
        }

        /* Row hover: tint the row and reveal the pencil. The pencil's box is
           always laid out (fixed width) and only its colour changes, so
           nothing moves or grows when it appears. */
        .prod-page .prod-table tbody tr {
            transition: background-color .15s ease;
        }

        .prod-page .prod-table tbody tr:hover {
            background: #FAFBF9;
        }

        .prod-page .prod-edit-ico {
            display: inline-block;
            width: 12px;
            height: 12px;
            margin-left: 6px;
            vertical-align: -1px;
            line-height: 0;
            color: transparent;
            transition: color .15s ease;
        }

        .prod-page .prod-edit-ico svg {
            display: block;
            width: 12px;
            height: 12px;
        }

        .prod-page .prod-table tbody tr:hover .prod-edit-ico {
            color: #9CA3AF;
        }

        .prod-page .prod-muted {
            color: #6B7280;
        }

        .prod-page .prod-table .prod-price {
            font-size: 12.5px;
            font-weight: 700;
            color: #1B7A3A;
        }

        .prod-page .prod-stock {
            color: #374151;
        }

        .prod-page .prod-stock.is-zero {
            font-weight: 600;
            color: #C0392B;
        }

        .prod-page .pill {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 9.5px;
            font-weight: 600;
            line-height: 1.3;
        }

        .prod-page .pill-active {
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .prod-page .pill-out {
            background: #FDE8E8;
            color: #C0392B;
        }

        @media screen and (max-width: 900px) {
            .prod-page .prod-header,
            .prod-page .prod-toolbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .prod-page .prod-header {
                gap: 12px;
            }

            .prod-page .prod-toolbar {
                gap: 10px;
            }
        }

        @media screen and (max-width: 700px) {
            .prod-page .prod-table-wrap {
                overflow-x: auto;
            }

            .prod-page .prod-table {
                min-width: 720px;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .prod-page) {
                padding: 18px 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="ProductsBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="prod-page">

        <div class="prod-header">
            <div>
                <h1 class="prod-title">Product Management</h1>
                <p class="prod-sub">Manage your catalog, inventory, and pricing.</p>
            </div>
            <a class="prod-add" href="AddProduct.aspx">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" />
                </svg>
                Add New Product
            </a>
        </div>

        <div class="prod-toolbar">
            <div class="prod-filters">
                <button type="button" class="filter-btn">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" />
                    </svg>
                    All Categories
                </button>
                <button type="button" class="filter-btn">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /><polyline points="3.27 6.96 12 12.01 20.73 6.96" /><line x1="12" y1="22.08" x2="12" y2="12" />
                    </svg>
                    Stock Status
                </button>
            </div>
            <span class="prod-count">Showing 1&#8211;10 of 156 Products</span>
        </div>

        <div class="prod-card">
            <div class="prod-table-wrap">
                <table class="prod-table">
                    <thead>
                        <tr>
                            <th scope="col" class="col-check"><input type="checkbox" id="chkAllProducts" aria-label="Select all products" /></th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Category</th>
                            <th scope="col" class="col-center">Price (&#8377;)</th>
                            <th scope="col" class="col-center">Unit</th>
                            <th scope="col" class="col-center">Stock Qty</th>
                            <th scope="col" class="col-center">Status</th>
                        </tr>
                    </thead>
                    <tbody id="prodRows">
                        <tr>
                            <td class="col-check"><input type="checkbox" class="row-check" aria-label="Select Fresh Tomato" /></td>
                            <td><a class="prod-name" href="EditProduct.aspx">Fresh Tomato</a><span class="prod-edit-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg></span></td>
                            <td class="prod-muted">Vegetables</td>
                            <td class="col-center prod-price">&#8377;35</td>
                            <td class="col-center prod-muted">kg</td>
                            <td class="col-center prod-stock">50</td>
                            <td class="col-center"><span class="pill pill-active">Active</span></td>
                        </tr>
                        <tr>
                            <td class="col-check"><input type="checkbox" class="row-check" aria-label="Select Fresh Spinach" /></td>
                            <td><a class="prod-name" href="EditProduct.aspx">Fresh Spinach</a><span class="prod-edit-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg></span></td>
                            <td class="prod-muted">Leafy Greens</td>
                            <td class="col-center prod-price">&#8377;25</td>
                            <td class="col-center prod-muted">bunch</td>
                            <td class="col-center prod-stock is-zero">0</td>
                            <td class="col-center"><span class="pill pill-out">Out of Stock</span></td>
                        </tr>
                        <tr>
                            <td class="col-check"><input type="checkbox" class="row-check" aria-label="Select Organic Carrots" /></td>
                            <td><a class="prod-name" href="EditProduct.aspx">Organic Carrots</a><span class="prod-edit-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9" /><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg></span></td>
                            <td class="prod-muted">Root Vegetables</td>
                            <td class="col-center prod-price">&#8377;45</td>
                            <td class="col-center prod-muted">kg</td>
                            <td class="col-center prod-stock">120</td>
                            <td class="col-center"><span class="pill pill-active">Active</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <%-- UI only (no validation, no postback): select-all and row checkboxes. --%>
    <script>
        (function () {
            var all = document.getElementById('chkAllProducts');
            var rows = document.querySelectorAll('.prod-page .row-check');

            all.addEventListener('change', function () {
                Array.prototype.forEach.call(rows, function (box) {
                    box.checked = all.checked;
                });
            });

            Array.prototype.forEach.call(rows, function (box) {
                box.addEventListener('change', function () {
                    all.checked = Array.prototype.every.call(rows, function (b) { return b.checked; });
                });
            });
        })();
    </script>
</asp:Content>
