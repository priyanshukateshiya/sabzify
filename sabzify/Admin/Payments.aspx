<%@ Page Title="Payments" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="sabzify.Admin.Payments" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="PaymentsTitle" ContentPlaceHolderID="TitleContent" runat="server">Payments</asp:Content>

<asp:Content ID="PaymentsHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Page header ---------------------------------------------------------- */
        .pay-page .pay-header {
            margin-bottom: 20px;
        }

        .pay-page .pay-header h1 {
            margin: 0 0 5px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .pay-page .pay-header p {
            margin: 0;
            font-size: 11px;
            color: #6B7280;
        }

        /* Stat cards ----------------------------------------------------------- */
        .pay-page .pay-stats {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 22px;
        }

        .pay-page .pay-stat {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            padding: 16px 18px;
            background: #FFFFFF;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04), 0 4px 12px rgba(17, 24, 39, .03);
        }

        .pay-page .pay-stat-body {
            min-width: 0;
        }

        .pay-page .pay-stat-label {
            margin: 0;
            font-size: 10.5px;
            color: #6B7280;
        }

        .pay-page .pay-stat-value {
            margin: 4px 0 0;
            font-size: 22px;
            font-weight: 700;
            line-height: 1.2;
            color: #111827;
            white-space: nowrap;
        }

        .pay-page .pay-stat-value.is-revenue {
            color: #1B7A3A;
        }

        .pay-page .pay-stat-value .pay-rupee {
            margin-right: 4px;
            font-size: 18px;
        }

        .pay-page .pay-stat-meta {
            display: flex;
            align-items: center;
            gap: 4px;
            margin: 8px 0 0;
            font-size: 9.5px;
            color: #6B7280;
        }

        .pay-page .pay-stat-meta.is-up {
            color: #1B7A3A;
        }

        .pay-page .pay-stat-meta svg {
            flex: 0 0 11px;
            width: 11px;
            height: 11px;
        }

        .pay-page .pay-badge {
            display: flex;
            flex: 0 0 34px;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            color: #FFFFFF;
        }

        .pay-page .pay-badge svg {
            width: 16px;
            height: 16px;
        }

        .pay-page .pay-badge.is-green {
            background: #1B7A3A;
        }

        .pay-page .pay-badge.is-mint {
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .pay-page .pay-badge.is-amber {
            background: #C97A16;
        }

        /* Transactions card ---------------------------------------------------- */
        .pay-page .pay-card {
            background: #FFFFFF;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04), 0 4px 12px rgba(17, 24, 39, .03);
        }

        .pay-page .pay-card-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 16px 18px;
        }

        .pay-page .pay-card-head h2 {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
            color: #111827;
        }

        /* Search box. The error is absolutely positioned under the input, so the
           title row height never changes when it shows. */
        .pay-page .pay-search {
            position: relative;
            width: 190px;
        }

        .pay-page .pay-search-icon {
            position: absolute;
            top: 9px;
            left: 10px;
            width: 12px;
            height: 12px;
            color: #9CA3AF;
            pointer-events: none;
        }

        .pay-page .pay-search input[type="text"] {
            display: block;
            width: 100%;
            height: 30px;
            padding: 0 10px 0 30px;
            background: #F7F9FA;
            border: 1px solid #E8EDF2;
            border-radius: 6px;
            font-family: inherit;
            font-size: 10.5px;
            color: #111827;
            box-sizing: border-box;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .pay-page .pay-search input[type="text"]::placeholder {
            color: #9CA3AF;
        }

        .pay-page .pay-search input[type="text"]:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        .pay-page .pay-search-submit {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: -1px;
            padding: 0;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }

        .pay-page .field-error {
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            right: 0;
            z-index: 2;
            padding: 4px 8px;
            background: #FFFFFF;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(17, 24, 39, .12);
            font-size: 9.5px;
            line-height: 1.35;
            color: #C0392B;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variant is more specific than the plain :focus rule, so the green
           ring cannot override the red border. */
        .pay-page .pay-search:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"] {
            border-color: #C0392B;
        }

        .pay-page .pay-search:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        /* Table -------------------------------------------------------------- */
        .pay-page .pay-table-wrap {
            width: 100%;
        }

        .pay-page .pay-table {
            width: 100%;
            border-collapse: collapse;
        }

        .pay-page .pay-table th {
            padding: 10px 18px;
            background: #F7F9F4;
            border-bottom: 1px solid #EDF1F5;
            font-size: 9.5px;
            font-weight: 600;
            color: #6B7280;
            text-align: left;
            white-space: nowrap;
        }

        .pay-page .pay-table td {
            padding: 13px 18px;
            border-bottom: 1px solid #F3F5F1;
            font-size: 10.5px;
            color: #6B7280;
            vertical-align: middle;
            white-space: nowrap;
        }

        .pay-page .pay-table tbody tr:last-child td {
            border-bottom: none;
        }

        .pay-page .pay-table th.col-action,
        .pay-page .pay-table td.col-action {
            text-align: center;
        }

        .pay-page .pay-table td.pay-txn {
            font-family: ui-monospace, SFMono-Regular, Consolas, "Liberation Mono", monospace;
            font-size: 10px;
            color: #6B7280;
        }

        .pay-page .pay-table td.pay-user {
            font-weight: 600;
            color: #111827;
        }

        .pay-page .pay-table td.pay-amount {
            font-size: 11.5px;
            font-weight: 700;
            color: #1B7A3A;
        }

        .pay-page .pay-method {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            color: #374151;
        }

        .pay-page .pay-method svg {
            width: 12px;
            height: 12px;
            color: #6B7280;
        }

        .pay-page .pay-pill {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 9.5px;
            font-weight: 600;
            line-height: 1.3;
        }

        .pay-page .pay-pill.is-completed {
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .pay-page .pay-pill.is-pending {
            background: #FFF0DC;
            color: #C97A16;
        }

        .pay-page .pay-pill.is-refunded {
            background: #FDE8E8;
            color: #C0392B;
        }

        .pay-page .pay-view {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 6px;
            color: #6B7280;
            cursor: pointer;
            transition: color .15s ease, background-color .15s ease;
        }

        .pay-page .pay-view svg {
            width: 14px;
            height: 14px;
        }

        .pay-page .pay-view:hover,
        .pay-page .pay-view[aria-expanded="true"] {
            color: #1B7A3A;
        }

        .pay-page .pay-view:focus-visible {
            outline: 2px solid #1B7A3A;
            outline-offset: 1px;
        }

        /* Inline detail row (created by the script below). */
        .pay-page .pay-table tr.pay-detail td {
            padding: 0;
            background: #F7F9FA;
        }

        .pay-page .pay-detail-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 10px 28px;
            padding: 12px 18px;
        }

        .pay-page .pay-detail-item {
            margin: 0;
        }

        .pay-page .pay-detail-item dt {
            margin: 0 0 2px;
            font-size: 9px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .04em;
            color: #9CA3AF;
        }

        .pay-page .pay-detail-item dd {
            margin: 0;
            font-size: 10.5px;
            font-weight: 600;
            color: #111827;
        }

        /* Responsive ----------------------------------------------------------- */
        @media screen and (max-width: 1100px) {
            .pay-page .pay-stats {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 900px) {
            .pay-page .pay-stats {
                grid-template-columns: minmax(0, 1fr);
            }

            .pay-page .pay-card-head {
                flex-direction: column;
                align-items: stretch;
            }

            .pay-page .pay-search {
                width: 100%;
            }
        }

        @media screen and (max-width: 700px) {
            .pay-page .pay-table-wrap {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .pay-page .pay-table {
                min-width: 780px;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .pay-page) {
                padding: 18px 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="PaymentsBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="pay-page">
        <%-- A) Page header --%>
        <div class="pay-header">
            <h1>Payment Management</h1>
            <p>Overview of all transactions and revenue.</p>
        </div>

        <%-- B) Stat cards --%>
        <div class="pay-stats">
            <div class="pay-stat">
                <div class="pay-stat-body">
                    <p class="pay-stat-label">Total Revenue</p>
                    <p class="pay-stat-value is-revenue"><span class="pay-rupee">&#8377;</span>1,24,500</p>
                    <p class="pay-stat-meta is-up">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <polyline points="22 7 13.5 15.5 8.5 10.5 2 17" />
                            <polyline points="16 7 22 7 22 13" />
                        </svg>
                        <span>+12% from last month</span>
                    </p>
                </div>
                <span class="pay-badge is-green" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M19 7V4a1 1 0 0 0-1-1H5a2 2 0 0 0 0 4h15a1 1 0 0 1 1 1v4h-3a2 2 0 0 0 0 4h3a1 1 0 0 0 1-1v-2a1 1 0 0 0-1-1" />
                        <path d="M3 5v14a2 2 0 0 0 2 2h15a1 1 0 0 0 1-1v-4" />
                    </svg>
                </span>
            </div>

            <div class="pay-stat">
                <div class="pay-stat-body">
                    <p class="pay-stat-label">Successful Transactions</p>
                    <p class="pay-stat-value">842</p>
                    <p class="pay-stat-meta">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="10" />
                            <path d="m9 12 2 2 4-4" />
                        </svg>
                        <span>98% success rate</span>
                    </p>
                </div>
                <span class="pay-badge is-mint" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10" />
                        <path d="m9 12 2 2 4-4" />
                    </svg>
                </span>
            </div>

            <div class="pay-stat">
                <div class="pay-stat-body">
                    <p class="pay-stat-label">Pending Payments</p>
                    <p class="pay-stat-value">14</p>
                    <p class="pay-stat-meta">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="10" />
                            <polyline points="12 6 12 12 16 14" />
                        </svg>
                        <span>Requires attention</span>
                    </p>
                </div>
                <span class="pay-badge is-amber" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 4h2a2 2 0 0 1 2 2v4" />
                        <path d="M8 4H6a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h4" />
                        <rect x="8" y="2" width="8" height="4" rx="1" />
                        <circle cx="16" cy="16" r="5" />
                        <path d="M16 14v2l1 1" />
                    </svg>
                </span>
            </div>
        </div>

        <%-- C) Transactions --%>
        <div class="pay-card">
            <div class="pay-card-head">
                <h2>Recent Transactions</h2>
                <%-- DefaultButton: Enter in the search box clicks the hidden button,
                     which validates only the PaySearch group. --%>
                <asp:Panel ID="pnlSearch" runat="server" CssClass="pay-search" DefaultButton="btnSearch">
                    <svg class="pay-search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="11" cy="11" r="8" />
                        <path d="m21 21-4.3-4.3" />
                    </svg>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search ID or Name" aria-label="Search by transaction ID or name" />
                    <asp:RegularExpressionValidator ID="revSearch" runat="server" ControlToValidate="txtSearch"
                        ValidationExpression="^[A-Za-z0-9#\- ]{2,40}$"
                        ErrorMessage="Enter at least 2 letters, numbers or #-" ValidationGroup="PaySearch" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="PaySearch"
                        CssClass="pay-search-submit" TabIndex="-1" aria-hidden="true" />
                </asp:Panel>
            </div>

            <div class="pay-table-wrap">
                <table class="pay-table">
                    <thead>
                        <tr>
                            <th scope="col">Transaction ID</th>
                            <th scope="col">User Name</th>
                            <th scope="col">Amount</th>
                            <th scope="col">Date &amp; Time</th>
                            <th scope="col">Payment Method</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="col-action">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="pay-txn">#TXN-9021A</td>
                            <td class="pay-user">Rahul Sharma</td>
                            <td class="pay-amount">&#8377;850</td>
                            <td>24 Oct, 10:30 AM</td>
                            <td>
                                <span class="pay-method">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><path d="M14 14h3v3h-3zM18 18h3v3h-3zM14 21h1M21 14v1" /></svg>
                                    <span>UPI</span>
                                </span>
                            </td>
                            <td><span class="pay-pill is-completed">Completed</span></td>
                            <td class="col-action">
                                <button type="button" class="pay-view" aria-expanded="false" aria-label="View details for #TXN-9021A">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" /><circle cx="12" cy="12" r="3" /></svg>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="pay-txn">#TXN-9022B</td>
                            <td class="pay-user">Priya Patel</td>
                            <td class="pay-amount">&#8377;1,200</td>
                            <td>24 Oct, 11:15 AM</td>
                            <td>
                                <span class="pay-method">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><path d="M14 14h3v3h-3zM18 18h3v3h-3zM14 21h1M21 14v1" /></svg>
                                    <span>UPI</span>
                                </span>
                            </td>
                            <td><span class="pay-pill is-pending">Pending</span></td>
                            <td class="col-action">
                                <button type="button" class="pay-view" aria-expanded="false" aria-label="View details for #TXN-9022B">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" /><circle cx="12" cy="12" r="3" /></svg>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="pay-txn">#TXN-9023C</td>
                            <td class="pay-user">Amit Kumar</td>
                            <td class="pay-amount">&#8377;450</td>
                            <td>24 Oct, 01:45 PM</td>
                            <td>
                                <span class="pay-method">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2" /><path d="M15 18H9" /><path d="M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.62l-3.48-4.35A1 1 0 0 0 17.52 8H14" /><circle cx="17" cy="18" r="2" /><circle cx="7" cy="18" r="2" /></svg>
                                    <span>COD</span>
                                </span>
                            </td>
                            <td><span class="pay-pill is-completed">Completed</span></td>
                            <td class="col-action">
                                <button type="button" class="pay-view" aria-expanded="false" aria-label="View details for #TXN-9023C">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" /><circle cx="12" cy="12" r="3" /></svg>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="pay-txn">#TXN-9024D</td>
                            <td class="pay-user">Neha Singh</td>
                            <td class="pay-amount">&#8377;2,100</td>
                            <td>24 Oct, 03:20 PM</td>
                            <td>
                                <span class="pay-method">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><path d="M14 14h3v3h-3zM18 18h3v3h-3zM14 21h1M21 14v1" /></svg>
                                    <span>UPI</span>
                                </span>
                            </td>
                            <td><span class="pay-pill is-refunded">Refunded</span></td>
                            <td class="col-action">
                                <button type="button" class="pay-view" aria-expanded="false" aria-label="View details for #TXN-9024D">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" /><circle cx="12" cy="12" r="3" /></svg>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="pay-txn">#TXN-9025E</td>
                            <td class="pay-user">Vikram Desai</td>
                            <td class="pay-amount">&#8377;680</td>
                            <td>24 Oct, 04:55 PM</td>
                            <td>
                                <span class="pay-method">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><path d="M14 14h3v3h-3zM18 18h3v3h-3zM14 21h1M21 14v1" /></svg>
                                    <span>UPI</span>
                                </span>
                            </td>
                            <td><span class="pay-pill is-completed">Completed</span></td>
                            <td class="col-action">
                                <button type="button" class="pay-view" aria-expanded="false" aria-label="View details for #TXN-9025E">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" /><circle cx="12" cy="12" r="3" /></svg>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%-- UI only: the eye button toggles an inline detail row under its transaction.
         No postback, no validation. --%>
    <script>
        (function () {
            var labels = ['Transaction ID', 'User Name', 'Amount', 'Method', 'Status'];
            var buttons = document.querySelectorAll('.pay-page .pay-view');

            function buildDetail(row) {
                var cells = row.cells;
                var values = [
                    cells[0].textContent,
                    cells[1].textContent,
                    cells[2].textContent,
                    cells[4].textContent,
                    cells[5].textContent
                ];
                var detail = document.createElement('tr');
                detail.className = 'pay-detail';
                var td = document.createElement('td');
                td.colSpan = cells.length;
                var grid = document.createElement('dl');
                grid.className = 'pay-detail-grid';
                labels.forEach(function (label, i) {
                    var item = document.createElement('div');
                    item.className = 'pay-detail-item';
                    var dt = document.createElement('dt');
                    dt.textContent = label;
                    var dd = document.createElement('dd');
                    dd.textContent = values[i].replace(/\s+/g, ' ').trim();
                    item.appendChild(dt);
                    item.appendChild(dd);
                    grid.appendChild(item);
                });
                td.appendChild(grid);
                detail.appendChild(td);
                return detail;
            }

            Array.prototype.forEach.call(buttons, function (button) {
                button.addEventListener('click', function () {
                    var row = button.closest('tr');
                    var next = row.nextElementSibling;
                    if (next && next.classList.contains('pay-detail')) {
                        next.parentNode.removeChild(next);
                        button.setAttribute('aria-expanded', 'false');
                    } else {
                        row.parentNode.insertBefore(buildDetail(row), row.nextSibling);
                        button.setAttribute('aria-expanded', 'true');
                    }
                });
            });
        })();
    </script>
</asp:Content>
