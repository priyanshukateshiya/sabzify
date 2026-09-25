<%@ Page Title="Your Wishlist" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="sabzify.Wishlist" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="WishlistContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .wl-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.wl-page) {
            background: #FFFFFF;
        }

        .wl-page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 36px 24px 56px;
            color: #111827;
        }

        /* Page header ------------------------------------------------------ */
        .wl-page h1.wl-title {
            margin: 0 0 6px;
            font-size: 30px;
            font-weight: 700;
            color: #111827;
        }

        .wl-page .wl-sub {
            margin: 0;
            font-size: 13px;
            color: #6B7280;
        }

        .wl-page .wl-head {
            margin-bottom: 28px;
        }

        /* Product grid ----------------------------------------------------- */
        .wl-page .wl-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }

        .wl-page .wl-card {
            display: flex;
            flex-direction: column;
            padding-bottom: 12px;
            border: 1px solid #EDEFEA;
            border-radius: 10px;
            background: #FFFFFF;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .06);
            transition: opacity .25s ease, transform .25s ease;
        }

        .wl-page .wl-card.is-leaving {
            opacity: 0;
            transform: scale(.96);
        }

        .wl-page .wl-media {
            position: relative;
            height: 150px;
            overflow: hidden;
            border-radius: 10px 10px 0 0;
            background: #F4F6F2;
        }

        .wl-page .wl-media img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .wl-page .wl-badge {
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

        .wl-page .wl-body {
            padding: 12px 12px 0;
        }

        .wl-page .wl-name {
            min-height: 36px;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .wl-page .wl-unit {
            margin-top: 3px;
            font-size: 11px;
            color: #6B7280;
        }

        .wl-page .wl-price {
            margin: 10px 0 14px;
            font-size: 17px;
            font-weight: 700;
            color: #111827;
        }

        /* Card buttons ----------------------------------------------------- */
        .wl-page .wl-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: auto;
            padding: 0 12px;
        }

        .wl-page .wl-move {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            height: 34px;
            padding: 0;
            border: none;
            border-radius: 6px;
            background: #1B6E2A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
        }

        .wl-page .wl-move:hover {
            background: #155A22;
        }

        .wl-page .wl-move svg {
            flex: none;
            width: 13px;
            height: 13px;
            fill: currentColor;
        }

        .wl-page .wl-remove {
            width: 100%;
            height: 30px;
            padding: 0;
            border: 1px solid #E1E6DE;
            border-radius: 6px;
            background: #FFFFFF;
            color: #6B7280;
            font-family: inherit;
            font-size: 12px;
            cursor: pointer;
        }

        .wl-page .wl-remove:hover {
            border-color: #C9CFC6;
            color: #374151;
        }

        /* Empty state ------------------------------------------------------ */
        .wl-page .wl-empty {
            display: none;
            padding: 56px 24px;
            text-align: center;
        }

        .wl-page .wl-empty.is-shown {
            display: block;
        }

        .wl-page .wl-empty svg {
            width: 40px;
            height: 40px;
            fill: none;
            stroke: #9CA3AF;
            stroke-width: 1.6;
        }

        .wl-page .wl-empty-title {
            margin-top: 12px;
            font-size: 16px;
            font-weight: 600;
            color: #111827;
        }

        .wl-page .wl-empty-text {
            margin-top: 4px;
            font-size: 12px;
            color: #6B7280;
        }

        .wl-page .wl-browse {
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

        .wl-page .wl-browse:hover {
            background: #155A22;
            color: #FFFFFF;
        }

        /* Toast ------------------------------------------------------------ */
        .wl-page .wl-toast {
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

        .wl-page .wl-toast.is-shown {
            opacity: 1;
        }

        /* Responsive ------------------------------------------------------- */
        @media (max-width: 1024px) {
            .wl-page .wl-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .wl-page .wl-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .wl-page h1.wl-title {
                font-size: 24px;
            }
        }

        @media (max-width: 480px) {
            .wl-page .wl-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
            }

            .wl-page .wl-media {
                height: 120px;
            }

            .wl-page .wl-move {
                height: 32px;
            }

            .wl-page .wl-remove {
                height: 28px;
            }

            .wl-page .wl-name {
                font-size: 13px;
            }
        }
    </style>

    <div class="wl-page">

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

    <%-- UI-only behaviour: removing a card and the toast. No validation here,
         and the buttons are type="button" so nothing posts back. --%>
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
