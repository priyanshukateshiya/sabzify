<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="sabzify.Admin.Dashboard" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="DashboardTitle" ContentPlaceHolderID="TitleContent" runat="server">Dashboard</asp:Content>

<asp:Content ID="DashboardHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .dash-page. --%>
    <style>
        .dash-page .dash-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 20px;
        }

        .dash-page .dash-title {
            margin: 0 0 5px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .dash-page .dash-welcome {
            margin: 0;
            font-size: 11.5px;
            color: #6B7280;
        }

        .dash-page .dash-date {
            display: inline-flex;
            align-items: center;
            flex: none;
            gap: 6px;
            padding: 5px 10px;
            border: 1px solid #E5EAE6;
            border-radius: 6px;
            background: #fff;
            font-size: 10.5px;
            line-height: 1.3;
            color: #374151;
            white-space: nowrap;
        }

        .dash-page .dash-date svg {
            width: 12px;
            height: 12px;
            color: #6B7280;
        }

        /* Stat cards --------------------------------------------------------- */
        .dash-page .dash-stats {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 14px;
            margin-bottom: 20px;
        }

        .dash-page .dash-card {
            min-width: 0;
            padding: 15px 16px;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .dash-page .stat-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
        }

        .dash-page .stat-label {
            font-size: 10px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: .05em;
            text-transform: uppercase;
            color: #6B7280;
        }

        .dash-page .stat-top svg {
            flex: none;
            width: 15px;
            height: 15px;
        }

        .dash-page .stat-value {
            margin-top: 12px;
            font-size: 24px;
            font-weight: 700;
            line-height: 1.2;
            color: #111827;
        }

        .dash-page .icon-green {
            color: #1B7A3A;
        }

        .dash-page .icon-blue {
            color: #2D6CB5;
        }

        .dash-page .icon-grey {
            color: #6B7280;
        }

        .dash-page .stat-value.is-money {
            color: #1B7A3A;
        }

        /* Bottom row ---------------------------------------------------------- */
        .dash-page .dash-row {
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .dash-page .dash-lowstock {
            flex: 0 0 36%;
        }

        .dash-page .dash-orders {
            flex: 1;
        }

        .dash-page .card-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            margin-bottom: 4px;
            padding-bottom: 12px;
            border-bottom: 1px solid #F1F3EF;
        }

        .dash-page .card-title {
            display: flex;
            align-items: center;
            gap: 7px;
            margin: 0;
            font-size: 13px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .dash-page .card-title svg {
            flex: none;
            width: 15px;
            height: 15px;
            color: #D64545;
        }

        .dash-page .card-link {
            font-size: 10.5px;
            font-weight: 600;
            color: #1B7A3A;
            text-decoration: none;
            white-space: nowrap;
        }

        .dash-page .card-link:hover {
            text-decoration: underline;
        }

        .dash-page .stock-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .dash-page .stock-list li {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: 9px 0;
            border-bottom: 1px solid #F6F7F5;
        }

        .dash-page .stock-list li:last-child {
            border-bottom: 0;
        }

        .dash-page .stock-name {
            font-size: 11px;
            color: #C0392B;
        }

        .dash-page .stock-qty {
            font-size: 10.5px;
            font-weight: 600;
            color: #374151;
            white-space: nowrap;
        }

        /* Recent orders table ------------------------------------------------- */
        .dash-page .table-wrap {
            width: 100%;
            overflow-x: auto;
        }

        .dash-page .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .dash-page .orders-table th {
            padding: 10px 0;
            border-bottom: 1px solid #F1F3EF;
            font-size: 9.5px;
            font-weight: 600;
            letter-spacing: .05em;
            text-align: left;
            text-transform: uppercase;
            color: #6B7280;
            white-space: nowrap;
        }

        .dash-page .orders-table td {
            padding: 10px 0;
            border-bottom: 1px solid #F6F7F5;
            font-size: 11px;
            color: #374151;
            white-space: nowrap;
        }

        .dash-page .orders-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .dash-page .orders-table .col-amount {
            text-align: right;
        }

        /* Keeps the left-aligned status clear of the right-aligned amount. */
        .dash-page .orders-table .col-status {
            padding-left: 24px;
        }

        .dash-page .orders-table .order-id {
            font-weight: 600;
            color: #1B7A3A;
        }

        .dash-page .orders-table .order-amount {
            font-weight: 600;
            color: #111827;
        }

        .dash-page .status {
            display: inline-block;
            padding: 3px 9px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 600;
            line-height: 1.3;
        }

        .dash-page .status-delivered {
            background: #E6F4EA;
            color: #1B7A3A;
        }

        .dash-page .status-processing {
            background: #FFF3E0;
            color: #E8871E;
        }

        @media screen and (max-width: 1100px) {
            .dash-page .dash-stats {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 900px) {
            .dash-page .dash-row {
                flex-direction: column;
                align-items: stretch;
            }

            .dash-page .dash-lowstock,
            .dash-page .dash-orders {
                flex: none;
                width: 100%;
            }
        }

        @media screen and (max-width: 600px) {
            .dash-page .dash-header {
                flex-wrap: wrap;
            }

            .dash-page .dash-stats {
                grid-template-columns: minmax(0, 1fr);
            }

            /* Scroll the table inside its card instead of squeezing it. */
            .dash-page .orders-table {
                min-width: 420px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="DashboardBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="dash-page">

        <div class="dash-header">
            <div>
                <h1 class="dash-title">Dashboard Overview</h1>
                <p class="dash-welcome">Welcome back, Admin User. Here's what's happening today.</p>
            </div>
            <span class="dash-date">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2" /><line x1="16" y1="2" x2="16" y2="6" /><line x1="8" y1="2" x2="8" y2="6" /><line x1="3" y1="10" x2="21" y2="10" />
                </svg>
                Oct 24, 2024
            </span>
        </div>

        <div class="dash-stats">
            <div class="dash-card">
                <div class="stat-top">
                    <span class="stat-label">Total Products</span>
                    <svg class="icon-green" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" /><polyline points="3.27 6.96 12 12.01 20.73 6.96" /><line x1="12" y1="22.08" x2="12" y2="12" />
                    </svg>
                </div>
                <div class="stat-value">124</div>
            </div>
            <div class="dash-card">
                <div class="stat-top">
                    <span class="stat-label">Total Orders</span>
                    <svg class="icon-blue" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" /><rect x="8" y="2" width="8" height="4" rx="1" ry="1" />
                    </svg>
                </div>
                <div class="stat-value">567</div>
            </div>
            <div class="dash-card">
                <div class="stat-top">
                    <span class="stat-label">Total Users</span>
                    <svg class="icon-grey" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" />
                    </svg>
                </div>
                <div class="stat-value">1,240</div>
            </div>
            <div class="dash-card">
                <div class="stat-top">
                    <span class="stat-label">Today's Sales</span>
                    <svg class="icon-green" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M6 3h12M6 8h12M6 13l8.5 8M6 13h3c6.67 0 6.67-10 0-10" />
                    </svg>
                </div>
                <div class="stat-value is-money">&#8377;45,230</div>
            </div>
        </div>

        <div class="dash-row">
            <section class="dash-card dash-lowstock">
                <div class="card-head">
                    <h2 class="card-title">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" />
                        </svg>
                        Low Stock Alerts
                    </h2>
                </div>
                <ul class="stock-list">
                    <li><span class="stock-name">Fresh Spinach</span><span class="stock-qty">2 bunches left</span></li>
                    <li><span class="stock-name">Fresh Broccoli</span><span class="stock-qty">1 kg left</span></li>
                    <li><span class="stock-name">Organic Carrots</span><span class="stock-qty">4 kg left</span></li>
                    <li><span class="stock-name">Red Bell Peppers</span><span class="stock-qty">3 kg left</span></li>
                </ul>
            </section>

            <section class="dash-card dash-orders">
                <div class="card-head">
                    <h2 class="card-title">Recent Orders</h2>
                    <a class="card-link" href="Orders.aspx">View All</a>
                </div>
                <div class="table-wrap">
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th scope="col">Order ID</th>
                                <th scope="col">Customer</th>
                                <th scope="col" class="col-amount">Amount</th>
                                <th scope="col" class="col-status">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="order-id">#ORD-0921</td>
                                <td>Rajesh Kumar</td>
                                <td class="col-amount order-amount">&#8377;1,250</td>
                                <td class="col-status"><span class="status status-delivered">Delivered</span></td>
                            </tr>
                            <tr>
                                <td class="order-id">#ORD-0922</td>
                                <td>Priya Sharma</td>
                                <td class="col-amount order-amount">&#8377;840</td>
                                <td class="col-status"><span class="status status-processing">Processing</span></td>
                            </tr>
                            <tr>
                                <td class="order-id">#ORD-0923</td>
                                <td>Amit Patel</td>
                                <td class="col-amount order-amount">&#8377;2,100</td>
                                <td class="col-status"><span class="status status-delivered">Delivered</span></td>
                            </tr>
                            <tr>
                                <td class="order-id">#ORD-0924</td>
                                <td>Neha Gupta</td>
                                <td class="col-amount order-amount">&#8377;450</td>
                                <td class="col-status"><span class="status status-processing">Processing</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

    </div>
</asp:Content>
