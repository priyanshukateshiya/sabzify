<%@ Page Title="Payment Methods" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaymentMethods.aspx.cs" Inherits="sabzify.PaymentMethods" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="PaymentMethodsContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .acct-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.acct-page) {
            background: #F3F7EC;
        }

        .acct-page {
            max-width: 1040px;
            margin: 0 auto;
            padding: 32px 24px 56px;
            color: #111827;
        }

        /* Sidebar (shared with Profile / SavedAddresses) ------------------- */
        .acct-page .pf-cols {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }

        .acct-page .pf-side {
            display: flex;
            flex: 0 0 240px;
            flex-direction: column;
            gap: 14px;
            min-width: 0;
        }

        .acct-page .pf-main {
            flex: 1 1 auto;
            min-width: 0;
        }

        .acct-page .pf-card {
            border: 1px solid #EDEFEA;
            border-radius: 10px;
            background: #FFFFFF;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .06);
        }

        .acct-page .pf-user {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 18px;
        }

        .acct-page .pf-avatar {
            flex: none;
            width: 44px;
            height: 44px;
            border: 1px solid #D8DED4;
            border-radius: 50%;
            background: #FFFFFF;
        }

        .acct-page .pf-user-name {
            font-size: 15px;
            font-weight: 600;
            line-height: 1.25;
            color: #111827;
        }

        .acct-page .pf-user-place {
            display: flex;
            align-items: center;
            gap: 4px;
            margin-top: 4px;
            font-size: 11px;
            color: #6B7280;
        }

        .acct-page .pf-user-place svg {
            flex: none;
            width: 11px;
            height: 11px;
            fill: #1B6E2A;
        }

        .acct-page .pf-nav {
            padding: 8px;
        }

        .acct-page .pf-nav-heading {
            padding: 14px 14px 10px;
            margin-bottom: 8px;
            border-bottom: 1px solid #EFF1ED;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .acct-page .pf-nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            box-sizing: border-box;
            width: 100%;
            padding: 10px 12px;
            border: none;
            border-radius: 8px;
            background: none;
            color: #374151;
            font-family: inherit;
            font-size: 12.5px;
            text-align: left;
            text-decoration: none;
            cursor: pointer;
        }

        .acct-page .pf-nav-item svg {
            flex: none;
            width: 15px;
            height: 15px;
            fill: #6B7280;
        }

        .acct-page .pf-nav-item:hover {
            background: #F5F7F3;
            color: #374151;
        }

        .acct-page .pf-nav-item.is-active {
            background: #E9F3E4;
            color: #1B6E2A;
            font-weight: 600;
        }

        .acct-page .pf-nav-item.is-active svg {
            fill: #1B6E2A;
        }

        .acct-page .pf-nav-divider {
            height: 1px;
            margin: 8px 0;
            background: #EFF1ED;
        }

        .acct-page .pf-nav-item--logout {
            color: #C0392B;
            font-weight: 600;
        }

        .acct-page .pf-nav-item--logout svg {
            fill: #C0392B;
        }

        .acct-page .pf-nav-item--logout:hover {
            background: #FDF3F3;
            color: #C0392B;
        }

        /* Content card ------------------------------------------------------ */
        .acct-page .pm-content {
            min-height: 240px;
            padding: 24px;
        }

        .acct-page h1.pm-title {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            color: #111827;
        }

        .acct-page .pm-sub {
            max-width: 300px;
            margin: 6px 0 0;
            font-size: 11.5px;
            line-height: 1.6;
            color: #6B7280;
        }

        .acct-page .pm-method {
            box-sizing: border-box;
            max-width: 200px;
            margin-top: 26px;
            padding: 16px;
            border: 1px solid #D6E7EB;
            border-radius: 10px;
            background: #EAF5F7;
        }

        .acct-page .pm-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: #FFFFFF;
            color: #1B6E2A;
            font-size: 13px;
            font-weight: 600;
        }

        .acct-page .pm-name {
            margin-top: 16px;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        /* Responsive ---------------------------------------------------------- */
        @media (max-width: 900px) {
            .acct-page .pf-cols {
                display: block;
            }

            .acct-page .pf-side {
                margin-bottom: 14px;
            }

            .acct-page .pf-nav-list {
                display: flex;
                gap: 8px;
                overflow-x: auto;
            }

            .acct-page .pf-nav-list .pf-nav-item {
                flex: none;
                width: auto;
                white-space: nowrap;
            }
        }

        @media (max-width: 480px) {
            .acct-page {
                padding: 20px 16px;
            }

            .acct-page h1.pm-title {
                font-size: 16px;
            }

            .acct-page .pm-method {
                max-width: none;
            }
        }
    </style>

    <div class="acct-page">

        <div class="pf-cols">

            <div class="pf-side">

                <div class="pf-card pf-user">
                    <div class="pf-avatar"></div>
                    <div>
                        <div class="pf-user-name">Pratik Nakum</div>
                        <div class="pf-user-place">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                            </svg>
                            Rajkot, Gujarat
                        </div>
                    </div>
                </div>

                <div class="pf-card pf-nav">
                    <div class="pf-nav-heading">My Account</div>
                    <div class="pf-nav-list">
                        <a class="pf-nav-item" href="Profile.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0 2c-4.4 0-8 2.2-8 5v1h16v-1c0-2.8-3.6-5-8-5z" />
                            </svg>
                            Profile Information
                        </a>
                        <a class="pf-nav-item" href="MyOrders.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M4 4h16v3H4zm1 5h14v11H5zm3 3v1.6h8V12zm0 4v1.6h5V16z" />
                            </svg>
                            My Orders
                        </a>
                        <a class="pf-nav-item" href="Wishlist.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 20.5 4.2 13a4.8 4.8 0 0 1 0-6.8 4.8 4.8 0 0 1 6.8 0l1 1 1-1a4.8 4.8 0 0 1 6.8 0 4.8 4.8 0 0 1 0 6.8z" />
                            </svg>
                            Wishlist
                        </a>
                        <a class="pf-nav-item" href="SavedAddresses.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                            </svg>
                            Saved Addresses
                        </a>
                        <a class="pf-nav-item is-active" href="PaymentMethods.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M3 5h18a1 1 0 0 1 1 1v3H2V6a1 1 0 0 1 1-1zM2 11h20v7a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-7zm3 4v2h5v-2H5z" />
                            </svg>
                            Payment Methods
                        </a>
                    </div>

                    <div class="pf-nav-divider"></div>

                    <a class="pf-nav-item pf-nav-item--logout" href="Login.aspx">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M10 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5v-2H5V5h5zm6.6 4L15.2 8.4 17.8 11H9v2h8.8l-2.6 2.6L16.6 17 21.6 12z" />
                        </svg>
                        Logout
                    </a>
                </div>

            </div>

            <div class="pf-main">
                <div class="pf-card pm-content">

                    <h1 class="pm-title">Payment Methods</h1>
                    <p class="pm-sub">Manage your saved cards and UPI accounts for faster checkout.</p>

                    <div class="pm-method">
                        <div class="pm-badge">&#8377;</div>
                        <div class="pm-name">Cash On Delivery</div>
                    </div>

                </div>
            </div>

        </div>

    </div>

</asp:Content>
