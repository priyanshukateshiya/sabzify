<%@ Page Title="Your Wishlist" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="sabzify.Wishlist" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="WishlistContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .site-main:has(.acct-page) {
            background: #F3F7EC;
        }

        /* Page header ------------------------------------------------------ */
        .acct-page h1.wl-title {
            margin: 0 0 6px;
            font-size: 24px;
            font-weight: 700;
            color: #111827;
        }

        .acct-page .wl-sub {
            margin: 0;
            font-size: 13px;
            color: #6B7280;
        }

        .acct-page .wl-head {
            margin-bottom: 22px;
        }

        /* Product grid inside right content panel -------------------------- */
        .acct-page .wl-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .acct-page .wl-card {
            display: flex;
            flex-direction: column;
            padding-bottom: 12px;
            border: 1px solid #EDEFEA;
            border-radius: 10px;
            background: #FFFFFF;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .06);
            transition: opacity .25s ease, transform .25s ease;
        }

        .acct-page .wl-card.is-leaving {
            opacity: 0;
            transform: scale(.96);
        }

        .acct-page .wl-media {
            position: relative;
            height: 140px;
            overflow: hidden;
            border-radius: 10px 10px 0 0;
            background: #F4F6F2;
        }

        .acct-page .wl-media img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .acct-page .wl-badge {
            position: absolute;
            top: 8px;
            left: 8px;
            padding: 3px 9px;
            border-radius: 999px;
            background: #DFF3E2;
            color: #1B6E2A;
            font-size: 10px;
            font-weight: 600;
        }

        .acct-page .wl-body {
            padding: 12px 12px 0;
        }

        .acct-page .wl-name {
            min-height: 34px;
            font-size: 13.5px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .acct-page .wl-unit {
            margin-top: 3px;
            font-size: 11px;
            color: #6B7280;
        }

        .acct-page .wl-price {
            margin-top: 8px;
            font-size: 15px;
            font-weight: 700;
            color: #1B6E2A;
        }

        .acct-page .wl-actions {
            display: flex;
            gap: 8px;
            margin-top: auto;
            padding: 12px 12px 0;
        }

        .acct-page .wl-move {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            flex: 1 1 auto;
            height: 32px;
            padding: 0 10px;
            border: none;
            border-radius: 6px;
            background: #1B6E2A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: background .15s ease;
        }

        .acct-page .wl-move:hover {
            background: #155A22;
        }

        .acct-page .wl-move svg {
            flex: none;
            width: 13px;
            height: 13px;
            fill: #FFFFFF;
        }

        .acct-page .wl-remove {
            flex: none;
            height: 32px;
            padding: 0 10px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #FFFFFF;
            color: #6B7280;
            font-family: inherit;
            font-size: 11px;
            cursor: pointer;
            transition: background .15s ease, color .15s ease, border-color .15s ease;
        }

        .acct-page .wl-remove:hover {
            border-color: #E8B4B4;
            background: #FDF3F3;
            color: #C0392B;
        }

        /* Empty state ------------------------------------------------------ */
        .acct-page .wl-empty {
            display: none;
            padding: 56px 20px;
            border: 1px dashed #D8DED4;
            border-radius: 12px;
            background: #FFFFFF;
            text-align: center;
        }

        .acct-page .wl-empty.is-shown {
            display: block;
        }

        .acct-page .wl-empty svg {
            width: 44px;
            height: 44px;
            fill: #9CA3AF;
        }

        .acct-page .wl-empty-title {
            margin-top: 12px;
            font-size: 17px;
            font-weight: 600;
            color: #111827;
        }

        .acct-page .wl-empty-text {
            margin-top: 4px;
            font-size: 12px;
            color: #6B7280;
        }

        .acct-page .wl-browse {
            display: inline-block;
            margin-top: 16px;
            padding: 0 18px;
            border-radius: 6px;
            background: #1B6E2A;
            color: #FFFFFF;
            font-size: 12px;
            font-weight: 600;
            line-height: 34px;
            text-decoration: none;
        }

        .acct-page .wl-browse:hover {
            background: #155A22;
            color: #FFFFFF;
        }

        /* Toast ------------------------------------------------------------ */
        .acct-page .wl-toast {
            position: fixed;
            right: 20px;
            bottom: 20px;
            z-index: 50;
            padding: 9px 14px;
            border-radius: 6px;
            background: #1B6E2A;
            color: #FFFFFF;
            font-size: 12px;
            opacity: 0;
            pointer-events: none;
            transition: opacity .2s ease;
        }

        .acct-page .wl-toast.is-shown {
            opacity: 1;
        }

        @media (max-width: 900px) {
            .acct-page .wl-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 540px) {
            .acct-page .wl-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="acct-page">

        <div class="pf-cols">

            <div class="pf-side">

                <div class="pf-card pf-user">
                    <div class="pf-avatar"></div>
                    <div>
                        <div class="pf-user-name"><%: CurrentUserName %></div>
                        <div class="pf-user-place">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                            </svg>
                            <%: CurrentUserLocation %>
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
                        <a class="pf-nav-item is-active" href="Wishlist.aspx">
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
                        <a class="pf-nav-item" href="PaymentMethods.aspx">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M3 5h18a1 1 0 0 1 1 1v3H2V6a1 1 0 0 1 1-1zM2 11h20v7a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-7zm3 4v2h5v-2H5z" />
                            </svg>
                            Payment Methods
                        </a>
                    </div>

                    <div class="pf-nav-divider"></div>

                    <a class="pf-nav-item pf-nav-item--logout" href="Logout.aspx">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M10 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5v-2H5V5h5zm6.6 4L15.2 8.4 17.8 11H9v2h8.8l-2.6 2.6L16.6 17 21.6 12z" />
                        </svg>
                        Logout
                    </a>
                </div>

            </div>

            <div class="pf-main">

                <div class="wl-head">
                    <h1 class="wl-title">Your Wishlist</h1>
                    <p class="wl-sub">Fresh picks waiting for you.</p>
                </div>

                <div class="wl-grid" id="wlGrid">

                    <div class="wl-card">
                        <div class="wl-media">
                            <img src="Content/Images/tomato.png" alt="Farm Fresh Tomatoes" />
                        </div>
                        <div class="wl-body">
                            <div class="wl-name">Farm Fresh Tomatoes</div>
                            <div class="wl-unit">500g</div>
                            <div class="wl-price">&#8377;45</div>
                        </div>
                        <div class="wl-actions">
                            <button type="button" class="wl-move">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" />
                                </svg>
                                Move to Cart
                            </button>
                            <button type="button" class="wl-remove">Remove</button>
                        </div>
                    </div>

                    <div class="wl-card">
                        <div class="wl-media">
                            <img src="Content/Images/carrot.png" alt="Carrots" />
                            <span class="wl-badge">Organic</span>
                        </div>
                        <div class="wl-body">
                            <div class="wl-name">Carrots</div>
                            <div class="wl-unit">1kg</div>
                            <div class="wl-price">&#8377;60</div>
                        </div>
                        <div class="wl-actions">
                            <button type="button" class="wl-move">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" />
                                </svg>
                                Move to Cart
                            </button>
                            <button type="button" class="wl-remove">Remove</button>
                        </div>
                    </div>

                    <div class="wl-card">
                        <div class="wl-media">
                            <img src="Content/Images/palak.jpg" alt="Palak" />
                        </div>
                        <div class="wl-body">
                            <div class="wl-name">Palak</div>
                            <div class="wl-unit">250g Bundle</div>
                            <div class="wl-price">&#8377;30</div>
                        </div>
                        <div class="wl-actions">
                            <button type="button" class="wl-move">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" />
                                </svg>
                                Move to Cart
                            </button>
                            <button type="button" class="wl-remove">Remove</button>
                        </div>
                    </div>

                    <div class="wl-card">
                        <div class="wl-media">
                            <img src="Content/Images/brinjal.jpg" alt="Brinjal" />
                        </div>
                        <div class="wl-body">
                            <div class="wl-name">Brinjal</div>
                            <div class="wl-unit">500g</div>
                            <div class="wl-price">&#8377;55</div>
                        </div>
                        <div class="wl-actions">
                            <button type="button" class="wl-move">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" />
                                </svg>
                                Move to Cart
                            </button>
                            <button type="button" class="wl-remove">Remove</button>
                        </div>
                    </div>

                </div>

                <div class="wl-empty" id="wlEmpty">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 20.5 4.2 13a4.8 4.8 0 0 1 0-6.8 4.8 4.8 0 0 1 6.8 0l1 1 1-1a4.8 4.8 0 0 1 6.8 0 4.8 4.8 0 0 1 0 6.8z" />
                    </svg>
                    <div class="wl-empty-title">Your wishlist is empty</div>
                    <div class="wl-empty-text">Browse vegetables to add your favourites.</div>
                    <a class="wl-browse" href="Vegetables.aspx">Browse Vegetables</a>
                </div>

                <div class="wl-toast" id="wlToast">Moved to cart</div>

            </div>

        </div>

    </div>

    <script type="text/javascript">
        (function () {
            var grid = document.getElementById('wlGrid');
            var empty = document.getElementById('wlEmpty');
            var toast = document.getElementById('wlToast');
            if (!grid) { return; }

            var toastTimer = null;
            function showToast() {
                toast.className = 'wl-toast is-shown';
                if (toastTimer) { clearTimeout(toastTimer); }
                toastTimer = setTimeout(function () {
                    toast.className = 'wl-toast';
                }, 2000);
            }

            function refreshEmpty() {
                var left = grid.querySelectorAll('.wl-card').length;
                empty.className = left ? 'wl-empty' : 'wl-empty is-shown';
                grid.style.display = left ? '' : 'none';
            }

            function dropCard(card) {
                card.className = 'wl-card is-leaving';
                setTimeout(function () {
                    if (card.parentNode) { card.parentNode.removeChild(card); }
                    refreshEmpty();
                }, 250);
            }

            grid.addEventListener('click', function (e) {
                var btn = e.target.closest ? e.target.closest('button') : null;
                if (!btn) { return; }
                var card = btn.closest('.wl-card');
                if (!card) { return; }
                if (btn.className.indexOf('wl-move') > -1) {
                    showToast();
                    dropCard(card);
                } else if (btn.className.indexOf('wl-remove') > -1) {
                    dropCard(card);
                }
            });
        })();
    </script>

</asp:Content>
