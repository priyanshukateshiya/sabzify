<%@ Page Title="Saved Addresses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SavedAddresses.aspx.cs" Inherits="sabzify.SavedAddresses" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="SavedAddressesContent" ContentPlaceHolderID="MainContent" runat="server">

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

        /* Sidebar (shared with Profile / PaymentMethods) ------------------- */
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
        .acct-page .sa-content {
            padding: 24px;
        }

        .acct-page .sa-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .acct-page h1.sa-title {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
            color: #111827;
        }

        .acct-page .sa-add {
            display: inline-flex;
            flex: none;
            align-items: center;
            gap: 6px;
            height: 30px;
            padding: 0 14px;
            border: none;
            border-radius: 999px;
            background: #1B7A3A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
        }

        .acct-page .sa-add:hover {
            background: #166A32;
            color: #FFFFFF;
        }

        .acct-page .sa-add svg {
            width: 11px;
            height: 11px;
            fill: currentColor;
        }

        /* Address grid ------------------------------------------------------ */
        .acct-page .sa-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .acct-page .sa-card {
            position: relative;
            padding: 16px;
            border: 1px solid #E6EBE2;
            border-radius: 10px;
            transition: opacity .25s ease;
        }

        .acct-page .sa-card.is-leaving {
            opacity: 0;
        }

        .acct-page .sa-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }

        .acct-page .sa-type {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .acct-page .sa-type svg {
            flex: none;
            width: 13px;
            height: 13px;
            fill: #1B6E2A;
        }

        .acct-page .sa-pill {
            flex: none;
            padding: 3px 9px;
            border-radius: 999px;
            background: #DFF3E2;
            color: #1B6E2A;
            font-size: 9.5px;
            font-weight: 600;
        }

        .acct-page .sa-name {
            margin-top: 10px;
            font-size: 11.5px;
            font-weight: 600;
            color: #374151;
        }

        .acct-page .sa-lines {
            margin-top: 4px;
            font-size: 11px;
            line-height: 1.6;
            color: #6B7280;
        }

        .acct-page .sa-foot {
            display: flex;
            gap: 18px;
            margin-top: 14px;
            padding-top: 12px;
            border-top: 1px solid #F1F3EF;
        }

        .acct-page .sa-link {
            padding: 0;
            border: none;
            background: none;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
        }

        .acct-page .sa-link:hover {
            text-decoration: underline;
        }

        .acct-page .sa-edit {
            color: #1B6E2A;
        }

        .acct-page .sa-delete {
            color: #C0392B;
        }

        .acct-page .sa-default {
            color: #6B7280;
        }

        /* Inline delete confirmation ---------------------------------------- */
        .acct-page .sa-confirm {
            display: none;
            align-items: center;
            gap: 10px;
            margin-top: 14px;
            padding-top: 12px;
            border-top: 1px solid #F1F3EF;
        }

        .acct-page .sa-confirm.is-shown {
            display: flex;
        }

        .acct-page .sa-card.is-confirming .sa-foot {
            display: none;
        }

        .acct-page .sa-confirm-text {
            font-size: 11px;
            color: #374151;
        }

        .acct-page .sa-yes {
            height: 24px;
            padding: 0 10px;
            border: none;
            border-radius: 6px;
            background: #C0392B;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            cursor: pointer;
        }

        .acct-page .sa-yes:hover {
            background: #A93226;
        }

        .acct-page .sa-no {
            height: 24px;
            padding: 0 10px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #FFFFFF;
            color: #374151;
            font-family: inherit;
            font-size: 10.5px;
            cursor: pointer;
        }

        .acct-page .sa-no:hover {
            background: #F6F8F4;
        }

        /* Empty state -------------------------------------------------------- */
        .acct-page .sa-empty {
            display: none;
            padding: 48px 24px;
            text-align: center;
        }

        .acct-page .sa-empty.is-shown {
            display: block;
        }

        .acct-page .sa-empty svg {
            width: 34px;
            height: 34px;
            fill: none;
            stroke: #9CA3AF;
            stroke-width: 1.6;
        }

        .acct-page .sa-empty-title {
            margin: 10px 0 14px;
            font-size: 14px;
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

        @media (max-width: 700px) {
            .acct-page .sa-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .acct-page {
                padding: 20px 16px;
            }

            .acct-page h1.sa-title {
                font-size: 18px;
            }

            .acct-page .sa-head {
                display: block;
            }

            .acct-page .sa-add {
                justify-content: center;
                width: 100%;
                margin-top: 12px;
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
                        <a class="pf-nav-item is-active" href="SavedAddresses.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                            </svg>
                            Saved Addresses
                        </a>
                        <a class="pf-nav-item" href="PaymentMethods.aspx">
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
                <div class="pf-card sa-content">

                    <div class="sa-head">
                        <h1 class="sa-title">Saved Addresses</h1>
                        <a class="sa-add" href="AddAddress.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M11 5h2v6h6v2h-6v6h-2v-6H5v-2h6z" />
                            </svg>
                            Add Address
                        </a>
                    </div>

                    <div class="sa-grid" id="saGrid">

                        <div class="sa-card" id="saHome">
                            <div class="sa-card-top">
                                <span class="sa-type">
                                    <svg viewBox="0 0 24 24" aria-hidden="true">
                                        <path d="M12 3 3 10.5V21h6v-6h6v6h6V10.5z" />
                                    </svg>
                                    Home
                                </span>
                                <span class="sa-pill">Default</span>
                            </div>
                            <div class="sa-name">Pratik Nakum</div>
                            <div class="sa-lines">Near Sanskar Park Society<br />Rajkot - 360001</div>
                            <div class="sa-foot">
                                <button type="button" class="sa-link sa-edit">Edit</button>
                                <button type="button" class="sa-link sa-delete">Delete</button>
                            </div>
                            <div class="sa-confirm">
                                <span class="sa-confirm-text">Delete this address?</span>
                                <button type="button" class="sa-yes">Yes</button>
                                <button type="button" class="sa-no">No</button>
                            </div>
                        </div>

                        <div class="sa-card" id="saOffice">
                            <div class="sa-card-top">
                                <span class="sa-type">
                                    <svg viewBox="0 0 24 24" aria-hidden="true">
                                        <path d="M9 3h6a1 1 0 0 1 1 1v2h4a1 1 0 0 1 1 1v13H3V7a1 1 0 0 1 1-1h4V4a1 1 0 0 1 1-1zm1 2v1h4V5z" />
                                    </svg>
                                    Office
                                </span>
                            </div>
                            <div class="sa-name">Pratik Nakum</div>
                            <div class="sa-lines">IT Park, Kalawad Road<br />Rajkot - 360005</div>
                            <div class="sa-foot">
                                <button type="button" class="sa-link sa-edit">Edit</button>
                                <button type="button" class="sa-link sa-delete">Delete</button>
                                <button type="button" class="sa-link sa-default">Set as Default</button>
                            </div>
                            <div class="sa-confirm">
                                <span class="sa-confirm-text">Delete this address?</span>
                                <button type="button" class="sa-yes">Yes</button>
                                <button type="button" class="sa-no">No</button>
                            </div>
                        </div>

                    </div>

                    <div class="sa-empty" id="saEmpty">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7z" />
                            <circle cx="12" cy="9" r="2.5" />
                        </svg>
                        <div class="sa-empty-title">No saved addresses</div>
                        <a class="sa-add" href="AddAddress.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M11 5h2v6h6v2h-6v6h-2v-6H5v-2h6z" />
                            </svg>
                            Add Address
                        </a>
                    </div>

                </div>
            </div>

        </div>

    </div>

    <%-- UI-only behaviour: the inline delete confirmation, moving the Default
         pill and the Edit link. No validation here, and every control is
         type="button" or a link, so nothing posts back. --%>
    <script type="text/javascript">
        (function () {
            var grid = document.getElementById('saGrid');
            var empty = document.getElementById('saEmpty');
            if (!grid) { return; }

            function refreshEmpty() {
                var left = grid.querySelectorAll('.sa-card').length;
                empty.className = left ? 'sa-empty' : 'sa-empty is-shown';
                grid.style.display = left ? '' : 'none';
            }

            grid.addEventListener('click', function (e) {
                var btn = e.target.closest ? e.target.closest('button') : null;
                if (!btn) { return; }
                var card = btn.closest('.sa-card');
                if (!card) { return; }
                var cls = btn.className;

                if (cls.indexOf('sa-delete') > -1) {
                    card.className = 'sa-card is-confirming';
                    card.querySelector('.sa-confirm').className = 'sa-confirm is-shown';
                } else if (cls.indexOf('sa-no') > -1) {
                    card.className = 'sa-card';
                    card.querySelector('.sa-confirm').className = 'sa-confirm';
                } else if (cls.indexOf('sa-yes') > -1) {
                    card.className = 'sa-card is-leaving';
                    setTimeout(function () {
                        if (card.parentNode) { card.parentNode.removeChild(card); }
                        refreshEmpty();
                    }, 250);
                } else if (cls.indexOf('sa-default') > -1) {
                    // Move the pill to this card and give the other one the
                    // "Set as Default" button instead.
                    var cards = grid.querySelectorAll('.sa-card');
                    for (var i = 0; i < cards.length; i++) {
                        var pill = cards[i].querySelector('.sa-pill');
                        if (pill) { pill.parentNode.removeChild(pill); }
                        var setBtn = cards[i].querySelector('.sa-default');
                        if (cards[i] !== card && !setBtn) {
                            var b = document.createElement('button');
                            b.type = 'button';
                            b.className = 'sa-link sa-default';
                            b.appendChild(document.createTextNode('Set as Default'));
                            cards[i].querySelector('.sa-foot').appendChild(b);
                        }
                    }
                    var span = document.createElement('span');
                    span.className = 'sa-pill';
                    span.appendChild(document.createTextNode('Default'));
                    card.querySelector('.sa-card-top').appendChild(span);
                    btn.parentNode.removeChild(btn);
                } else if (cls.indexOf('sa-edit') > -1) {
                    window.location.href = 'AddAddress.aspx';
                }
            });
        })();
    </script>

</asp:Content>
