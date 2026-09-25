<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="sabzify.MyOrders" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="MyOrdersContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .orders-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.orders-page) {
            background: #FAFCF5;
        }

        .orders-page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 24px 56px;
            color: #111827;
        }

        /* Page header ------------------------------------------------------ */
        .orders-page .orders-head {
            margin-bottom: 26px;
        }

        .orders-page h1.orders-title {
            margin: 0 0 6px;
            font-size: 30px;
            font-weight: 700;
            color: #111827;
        }

        .orders-page .orders-sub {
            margin: 0;
            font-size: 13px;
            color: #6B7280;
        }

        /* Two-column shell ------------------------------------------------- */
        .orders-page .orders-cols {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }

        .orders-page .orders-main {
            flex: 1 1 auto;
            min-width: 0;
        }

        .orders-page .orders-side {
            display: flex;
            flex: 0 0 330px;
            flex-direction: column;
            gap: 16px;
            min-width: 0;
        }

        .orders-page .orders-card {
            border: 1px solid #EEF1EC;
            border-radius: 10px;
            background: #FFFFFF;
        }

        /* Status pills ----------------------------------------------------- */
        .orders-page .orders-pill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 10px;
            font-weight: 600;
        }

        .orders-page .orders-pill svg {
            flex: none;
            width: 11px;
            height: 11px;
            fill: currentColor;
        }

        .orders-page .orders-pill--pending {
            background: #FFF3E0;
            color: #E8871E;
        }

        .orders-page .orders-pill--shipping {
            background: #E8F1FB;
            color: #2D6CB5;
        }

        .orders-page .orders-pill--done {
            background: #E6F4EA;
            color: #1B7A3A;
        }

        .orders-page .orders-pill--cancelled {
            background: #F3F4F6;
            color: #6B7280;
        }

        /* Featured order card ---------------------------------------------- */
        .orders-page .orders-featured {
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .06);
            transition: opacity .25s ease;
        }

        .orders-page .orders-featured.is-cancelled {
            opacity: .6;
        }

        .orders-page .orders-featured-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            padding: 18px 20px;
        }

        .orders-page .orders-featured-no {
            margin: 10px 0 4px;
            font-size: 19px;
            font-weight: 600;
            color: #111827;
        }

        .orders-page .orders-featured-date {
            margin: 0;
            font-size: 11px;
            color: #6B7280;
        }

        .orders-page .orders-featured-money {
            flex: none;
            text-align: right;
        }

        .orders-page .orders-featured-total {
            font-size: 19px;
            font-weight: 700;
            color: #111827;
        }

        .orders-page .orders-featured-count {
            margin-top: 4px;
            font-size: 11px;
            color: #6B7280;
        }

        /* Item chips -------------------------------------------------------- */
        .orders-page .orders-items {
            display: flex;
            gap: 12px;
            padding: 0 20px 18px;
        }

        .orders-page .orders-chip {
            display: flex;
            align-items: center;
            gap: 10px;
            min-width: 150px;
            padding: 8px 12px;
            border: 1px solid #EEF1EC;
            border-radius: 8px;
        }

        .orders-page .orders-chip-thumb {
            flex: none;
            width: 30px;
            height: 30px;
            overflow: hidden;
            border-radius: 6px;
            background: #F4F6F2;
        }

        .orders-page .orders-chip-thumb img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .orders-page .orders-chip-name {
            font-size: 11px;
            font-weight: 600;
            color: #111827;
        }

        .orders-page .orders-chip-unit {
            margin-top: 2px;
            font-size: 10px;
            color: #6B7280;
        }

        .orders-page .orders-divider {
            height: 1px;
            background: #F1F3EF;
        }

        /* Featured footer --------------------------------------------------- */
        .orders-page .orders-featured-foot {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            padding: 14px 20px;
        }

        .orders-page .orders-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 32px;
            padding: 0 16px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #FFFFFF;
            color: #374151;
            font-family: inherit;
            font-size: 12px;
            cursor: pointer;
        }

        .orders-page .orders-btn:hover {
            background: #F6F8F4;
        }

        .orders-page .orders-btn--cancel {
            border-color: #E8B4B4;
            color: #C0392B;
        }

        .orders-page .orders-btn--cancel:hover {
            background: #FDF3F3;
        }

        /* Inline confirm row ------------------------------------------------ */
        .orders-page .orders-confirm {
            display: none;
            align-items: center;
            gap: 10px;
        }

        .orders-page .orders-confirm.is-shown {
            display: flex;
        }

        .orders-page .orders-confirm-text {
            font-size: 12px;
            color: #374151;
        }

        .orders-page .orders-confirm-yes {
            height: 28px;
            padding: 0 12px;
            border: none;
            border-radius: 6px;
            background: #C0392B;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
        }

        .orders-page .orders-confirm-yes:hover {
            background: #A93226;
        }

        .orders-page .orders-confirm-no {
            height: 28px;
            padding: 0 12px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #FFFFFF;
            color: #374151;
            font-family: inherit;
            font-size: 11px;
            cursor: pointer;
        }

        .orders-page .orders-confirm-no:hover {
            background: #F6F8F4;
        }

        /* Side cards -------------------------------------------------------- */
        .orders-page .orders-side .orders-card {
            padding: 16px;
        }

        .orders-page .orders-side-no {
            margin: 10px 0 4px;
            font-size: 15px;
            font-weight: 600;
            color: #111827;
        }

        .orders-page .orders-side-date {
            margin: 0;
            font-size: 10px;
            color: #6B7280;
        }

        .orders-page .orders-side-row {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            gap: 12px;
            margin-top: 12px;
        }

        .orders-page .orders-side-total {
            font-size: 17px;
            font-weight: 700;
            color: #111827;
        }

        .orders-page .orders-side-note {
            font-size: 10px;
            color: #6B7280;
            text-align: right;
        }

        .orders-page .orders-side-btn {
            display: block;
            width: 100%;
            height: 34px;
            margin-top: 14px;
            padding: 0;
            border: 1px solid #1B3A6B;
            border-radius: 6px;
            background: #FFFFFF;
            color: #1B3A6B;
            font-family: inherit;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
        }

        .orders-page .orders-side-btn:hover {
            background: #F4F7FB;
        }

        /* Delivered card ---------------------------------------------------- */
        .orders-page .orders-done-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
        }

        .orders-page .orders-done-total {
            flex: none;
            font-size: 15px;
            font-weight: 700;
            color: #111827;
        }

        .orders-page .orders-done-no {
            margin: 12px 0 4px;
            font-size: 15px;
            font-weight: 600;
            color: #111827;
        }

        .orders-page .orders-link {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            margin-top: 14px;
            padding: 0;
            border: none;
            background: none;
            color: #1B7A3A;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
        }

        .orders-page .orders-link:hover {
            text-decoration: underline;
        }

        /* Responsive -------------------------------------------------------- */
        @media (max-width: 1024px) {
            .orders-page .orders-side {
                flex-basis: 300px;
            }
        }

        @media (max-width: 768px) {
            .orders-page .orders-cols {
                display: block;
            }

            .orders-page .orders-side {
                margin-top: 16px;
            }

            .orders-page h1.orders-title {
                font-size: 24px;
            }

            .orders-page .orders-items {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .orders-page .orders-featured-top {
                display: block;
            }

            .orders-page .orders-featured-money {
                margin-top: 12px;
                text-align: left;
            }

            .orders-page .orders-items {
                display: block;
            }

            .orders-page .orders-chip {
                min-width: 0;
            }

            .orders-page .orders-chip + .orders-chip {
                margin-top: 12px;
            }

            .orders-page .orders-featured-foot {
                display: block;
            }

            .orders-page .orders-featured-foot .orders-btn {
                width: 100%;
            }

            .orders-page .orders-featured-foot .orders-btn + .orders-btn {
                margin-top: 8px;
            }

            .orders-page .orders-confirm {
                flex-wrap: wrap;
            }
        }
    </style>

    <div class="orders-page">

        <div class="orders-head">
            <h1 class="orders-title">My Orders</h1>
            <p class="orders-sub">Review your recent purchases and their delivery status.</p>
        </div>

        <div class="orders-cols">

            <div class="orders-main">
                <div class="orders-card orders-featured" id="ordFeatured">

                    <div class="orders-featured-top">
                        <div>
                            <span class="orders-pill orders-pill--pending" id="ordPill">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm1 5v5.3l3.7 2.2-1 1.6-4.7-2.8V7z" />
                                </svg>
                                <span id="ordPillText">Pending</span>
                            </span>
                            <h2 class="orders-featured-no">Order #ORD003</h2>
                            <p class="orders-featured-date">Placed on Oct 24, 2023</p>
                        </div>
                        <div class="orders-featured-money">
                            <div class="orders-featured-total">&#8377;1,240</div>
                            <div class="orders-featured-count">3 items</div>
                        </div>
                    </div>

                    <div class="orders-items">
                        <div class="orders-chip">
                            <div class="orders-chip-thumb">
                                <img src="Content/Images/palak.jpg" alt="Fresh Spinach" />
                            </div>
                            <div>
                                <div class="orders-chip-name">Fresh Spinach</div>
                                <div class="orders-chip-unit">500g</div>
                            </div>
                        </div>
                        <div class="orders-chip">
                            <div class="orders-chip-thumb">
                                <img src="Content/Images/tomato.png" alt="Farm Tomatoes" />
                            </div>
                            <div>
                                <div class="orders-chip-name">Farm Tomatoes</div>
                                <div class="orders-chip-unit">1kg</div>
                            </div>
                        </div>
                    </div>

                    <div class="orders-divider"></div>

                    <div class="orders-featured-foot">
                        <button type="button" class="orders-btn orders-view">View Details</button>
                        <button type="button" class="orders-btn orders-btn--cancel" id="ordCancel">Cancel Order</button>
                        <div class="orders-confirm" id="ordConfirm">
                            <span class="orders-confirm-text">Cancel this order?</span>
                            <button type="button" class="orders-confirm-yes" id="ordYes">Yes, cancel</button>
                            <button type="button" class="orders-confirm-no" id="ordNo">Keep order</button>
                        </div>
                    </div>

                </div>
            </div>

            <div class="orders-side">

                <div class="orders-card">
                    <span class="orders-pill orders-pill--shipping">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M3 5h11v10H3zm12 3h3.5l2.5 3v4h-6zM7 16a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm11 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4z" />
                        </svg>
                        Out for Delivery
                    </span>
                    <div class="orders-side-no">Order #ORD002</div>
                    <p class="orders-side-date">Placed on Oct 23, 2023</p>
                    <div class="orders-side-row">
                        <span class="orders-side-total">&#8377;850</span>
                        <span class="orders-side-note">Expected today by 6 PM</span>
                    </div>
                    <button type="button" class="orders-side-btn orders-view">View Details</button>
                </div>

                <div class="orders-card">
                    <div class="orders-done-top">
                        <span class="orders-pill orders-pill--done">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm-1 14.4-4-4L8.4 11l2.6 2.6L15.6 9 17 10.4z" />
                            </svg>
                            Delivered
                        </span>
                        <span class="orders-done-total">&#8377;2,100</span>
                    </div>
                    <div class="orders-done-no">Order #ORD001</div>
                    <p class="orders-side-date">Delivered on Oct 20, 2023</p>
                    <button type="button" class="orders-link orders-view">View Details &#8594;</button>
                </div>

            </div>

        </div>

    </div>

    <%-- UI-only behaviour: the inline cancel confirmation and the View Details
         links. No validation here, and every button is type="button" so
         nothing posts back. --%>
    <script type="text/javascript">
        (function () {
            var cancelBtn = document.getElementById('ordCancel');
            var confirmRow = document.getElementById('ordConfirm');
            var card = document.getElementById('ordFeatured');
            var pill = document.getElementById('ordPill');
            var pillText = document.getElementById('ordPillText');

            if (cancelBtn) {
                cancelBtn.onclick = function () {
                    cancelBtn.style.display = 'none';
                    confirmRow.className = 'orders-confirm is-shown';
                };
                document.getElementById('ordNo').onclick = function () {
                    confirmRow.className = 'orders-confirm';
                    cancelBtn.style.display = '';
                };
                document.getElementById('ordYes').onclick = function () {
                    confirmRow.className = 'orders-confirm';
                    pill.className = 'orders-pill orders-pill--cancelled';
                    pillText.textContent = 'Cancelled';
                    card.className = 'orders-card orders-featured is-cancelled';
                };
            }

            var views = document.querySelectorAll('.orders-view');
            for (var i = 0; i < views.length; i++) {
                views[i].onclick = function () {
                    window.location.href = 'TrackOrder.aspx';
                };
            }
        })();
    </script>

</asp:Content>
