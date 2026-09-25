<%@ Page Title="Fresh Tomato" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="sabzify.ProductDetails" UnobtrusiveValidationMode="None" %>

<asp:Content ID="ProductDetailsContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .pd-page (the white page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.pd-page) {
            background: #fff;
        }

        .pd-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px 24px 56px;
            color: #111827;
        }

        /* Breadcrumb ------------------------------------------------------- */
        .pd-page .pd-crumbs {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 6px;
            margin: 0 0 20px;
            font-size: 12px;
            color: #6B7280;
        }

        .pd-page .pd-crumbs a {
            color: #6B7280;
            text-decoration: none;
        }

        .pd-page .pd-crumbs a:hover,
        .pd-page .pd-crumbs a:focus {
            color: #1B6E2A;
            text-decoration: underline;
        }

        .pd-page .pd-crumbs .is-current {
            color: #111827;
        }

        /* Product section ------------------------------------------------- */
        .pd-page .pd-product {
            display: grid;
            grid-template-columns: minmax(0, 48fr) minmax(0, 52fr);
            gap: 40px;
            padding-bottom: 40px;
            border-bottom: 1px solid #F1F1F1;
        }

        .pd-page .pd-main-img {
            position: relative;
            aspect-ratio: 1 / 1;
            border-radius: 12px;
            overflow: hidden;
            background: #F3F4F6;
        }

        .pd-page .pd-main-img img {
            display: block;
            width: 100%;
            height: 100%;
            padding: 24px;
            object-fit: contain;
            mix-blend-mode: multiply;
        }

        .pd-page .pd-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 3px 8px;
            border-radius: 4px;
            background: #F59E0B;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            color: #fff;
        }

        .pd-page .pd-thumbs {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 12px;
            margin-top: 12px;
        }

        .pd-page .pd-thumb {
            display: block;
            aspect-ratio: 1 / 1;
            width: 100%;
            padding: 0;
            border: 1px solid #E5E7EB;
            border-radius: 8px;
            overflow: hidden;
            background: #F3F4F6;
            cursor: pointer;
        }

        .pd-page .pd-thumb.is-active {
            border: 2px solid #1B6E2A;
        }

        .pd-page .pd-thumb img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .pd-page .pd-thumb--video {
            display: flex;
            align-items: center;
            justify-content: center;
            background: #E5EDF3;
        }

        .pd-page .pd-thumb--video svg {
            width: 26px;
            height: 26px;
            fill: #6B7280;
        }

        /* Info column ------------------------------------------------------- */
        .pd-page .pd-pill {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 3px 10px;
            border-radius: 999px;
            background: #E6F2E1;
            font-size: 11px;
            font-weight: 600;
            color: #1B6E2A;
        }

        .pd-page .pd-pill svg {
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        .pd-page h1.pd-title {
            margin: 10px 0 6px;
            font-size: 30px;
            font-weight: 700;
            line-height: 1.2;
            color: #111827;
        }

        .pd-page .pd-price {
            display: flex;
            align-items: baseline;
            gap: 4px;
            margin: 0;
        }

        .pd-page .pd-price-now {
            font-size: 20px;
            font-weight: 700;
            color: #111827;
        }

        .pd-page .pd-price-unit {
            font-size: 13px;
            color: #6B7280;
        }

        .pd-page .pd-price-old {
            margin-left: 8px;
            font-size: 13px;
            color: #9CA3AF;
            text-decoration: line-through;
        }

        .pd-page .pd-stock {
            display: flex;
            align-items: center;
            gap: 6px;
            margin: 12px 0 16px;
            font-size: 13px;
            color: #1B6E2A;
        }

        .pd-page .pd-stock svg {
            width: 16px;
            height: 16px;
            fill: currentColor;
            flex: none;
        }

        .pd-page .pd-desc {
            max-width: 460px;
            margin: 0;
            font-size: 14px;
            line-height: 1.7;
            color: #4B5563;
        }

        .pd-page .pd-divider {
            height: 1px;
            margin: 24px 0;
            border: 0;
            background: #F1F1F1;
            opacity: 1;
        }

        /* Action box: the validators live inside it (so :has() can see them)
           but are positioned just below its bottom edge. */
        .pd-page .action-box {
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border: 1px solid #E5E7EB;
            border-radius: 10px;
        }

        .pd-page .action-box:has(.qty-error:not([style*="display:none"]):not([style*="display: none"])) {
            border-color: #C0392B;
        }

        .pd-page .pd-stepper {
            display: flex;
            align-items: center;
            flex: none;
            height: 40px;
            padding: 0 4px;
            border-radius: 6px;
            background: #F3F6F8;
        }

        .pd-page .pd-step-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            padding: 0;
            border: 0;
            border-radius: 4px;
            background: transparent;
            font-size: 18px;
            font-weight: 600;
            line-height: 1;
            color: #1B6E2A;
            cursor: pointer;
        }

        .pd-page .pd-step-btn:hover,
        .pd-page .pd-step-btn:focus {
            background: #E6EDE9;
        }

        .pd-page .pd-qty {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 2px;
            min-width: 64px;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
        }

        .pd-page .pd-qty-unit {
            margin-left: 3px;
        }

        .pd-page input.qty-input {
            width: 26px;
            max-width: 26px;
            height: 28px;
            padding: 0;
            border: 0;
            background: transparent;
            text-align: right;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
            outline: none;
        }

        .pd-page input.pd-btn {
            flex: 1 1 0;
            min-width: 0;
            max-width: none;
            height: 40px;
            padding: 0 12px;
            border: 0;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        /* <asp:Button> renders <input type="submit">, which cannot hold an
           <svg>, so the cart icon is an inline SVG data URI. */
        .pd-page input.pd-btn--cart {
            padding-left: 30px;
            background: #E8F0EC url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='%231B6E2A' d='M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z'/%3E%3C/svg%3E") no-repeat;
            background-size: 16px 16px;
            background-position: calc(50% - 44px) center;
            color: #1B6E2A;
        }

        .pd-page input.pd-btn--cart:hover,
        .pd-page input.pd-btn--cart:focus {
            background-color: #D9E8DF;
        }

        .pd-page input.pd-btn--buy {
            background: #1B6E2A;
            color: #fff;
        }

        .pd-page input.pd-btn--buy:hover,
        .pd-page input.pd-btn--buy:focus {
            background: #155822;
        }

        .pd-page .qty-error {
            position: absolute;
            top: calc(100% + 3px);
            left: 12px;
            font-size: 12px;
            line-height: 14px;
            color: #C0392B;
            white-space: nowrap;
        }

        .pd-page .pd-benefits {
            display: flex;
            gap: 32px;
            margin-top: 20px;
            font-size: 12px;
            color: #374151;
        }

        .pd-page .pd-benefit {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .pd-page .pd-benefit-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            flex: none;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .pd-page .pd-benefit-icon svg {
            width: 15px;
            height: 15px;
            fill: #1B6E2A;
        }

        /* Pairs Well With --------------------------------------------------- */
        .pd-page .pd-pairs {
            margin-top: 48px;
        }

        .pd-page h2.pd-pairs-title {
            margin: 0 0 20px;
            font-size: 22px;
            font-weight: 700;
            color: #111827;
        }

        .pd-page .pd-pairs-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
        }

        .pd-page .pair-card {
            padding: 10px;
            border: 1px solid #F1F1F1;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 4px 14px rgba(17, 24, 39, .05);
        }

        .pd-page .pair-media {
            aspect-ratio: 1 / 1;
            border-radius: 8px;
            overflow: hidden;
            background: #F3F4F6;
        }

        .pd-page .pair-media img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .pd-page h3.pair-name {
            margin: 10px 0 0;
            font-size: 12px;
            font-weight: 600;
            line-height: 1.35;
            color: #111827;
        }

        .pd-page .pair-unit {
            margin: 2px 0 0;
            font-size: 11px;
            color: #6B7280;
        }

        .pd-page .pair-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 12px;
        }

        .pd-page .pair-price {
            font-size: 13px;
            font-weight: 700;
            color: #111827;
        }

        .pd-page .pair-add {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            padding: 0;
            border: 0;
            border-radius: 5px;
            background: #1B6E2A;
            font-size: 16px;
            font-weight: 600;
            line-height: 1;
            color: #fff;
            cursor: pointer;
        }

        .pd-page .pair-add:hover,
        .pd-page .pair-add:focus {
            background: #155822;
        }

        /* Responsive -------------------------------------------------------- */
        @media screen and (max-width: 1024px) {
            .pd-page .pd-pairs-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 768px) {
            .pd-page .pd-product {
                grid-template-columns: minmax(0, 1fr);
                gap: 28px;
            }

            .pd-page h1.pd-title {
                font-size: 24px;
            }

            .pd-page .action-box {
                flex-wrap: wrap;
            }

            .pd-page .pd-stepper {
                flex: 1 1 100%;
                justify-content: space-between;
            }

            .pd-page .pd-pairs-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 480px) {
            .pd-page {
                padding: 20px 16px 48px;
            }

            .pd-page .pd-thumbs {
                gap: 8px;
            }

            .pd-page .pd-benefits {
                flex-direction: column;
                gap: 12px;
                margin-top: 28px;
            }

            .pd-page .pd-pairs-grid {
                gap: 10px;
            }
        }
    </style>

    <div class="pd-page">

        <%-- ================= Breadcrumb ================= --%>
        <nav class="pd-crumbs" aria-label="Breadcrumb">
            <a runat="server" href="~/">Home</a>
            <span aria-hidden="true">&#8250;</span>
            <a href="Vegetables.aspx">Vegetables</a>
            <span aria-hidden="true">&#8250;</span>
            <span class="is-current" aria-current="page">Fresh Tomato</span>
        </nav>

        <%-- ================= Product ================= --%>
        <section class="pd-product">

            <div class="pd-gallery">
                <div class="pd-main-img">
                    <img id="pdMainImg" src="Content/Images/tomato.png" alt="Fresh Tomato" />
                    <span class="pd-badge">15% OFF</span>
                </div>

                <div class="pd-thumbs">
                    <button type="button" class="pd-thumb is-active" data-src="Content/Images/tomato.png" aria-label="Show photo 1">
                        <img src="Content/Images/tomato.png" alt="" />
                    </button>
                    <button type="button" class="pd-thumb" data-src="Content/Images/tomato-crate.jpg" aria-label="Show photo 2">
                        <img src="Content/Images/tomato-crate.jpg" alt="" />
                    </button>
                    <button type="button" class="pd-thumb" data-src="Content/Images/tomato-sliced.jpg" aria-label="Show photo 3">
                        <img src="Content/Images/tomato-sliced.jpg" alt="" />
                    </button>
                    <button type="button" class="pd-thumb pd-thumb--video" aria-label="Product video">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm0 2a8 8 0 1 1 0 16 8 8 0 0 1 0-16zM10 8v8l6-4-6-4z" /></svg>
                    </button>
                </div>
            </div>

            <div class="pd-info">
                <span class="pd-pill">
                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" /></svg>
                    Organic
                </span>

                <h1 class="pd-title">Fresh Tomato</h1>

                <p class="pd-price">
                    <span class="pd-price-now">&#8377;35</span>
                    <span class="pd-price-unit">/ kg</span>
                    <span class="pd-price-old">&#8377;42</span>
                </p>

                <p class="pd-stock">
                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm-1.2 14.2-4-4 1.4-1.4 2.6 2.6 5.6-5.6 1.4 1.4-7 7z" /></svg>
                    In Stock - Ready to ship
                </p>

                <p class="pd-desc">Farm-fresh, juicy red tomatoes sourced directly from local farms in Gujarat. Hand-picked at peak ripeness to ensure maximum flavor and nutritional value. Perfect for curries, salads, or fresh homemade sauces.</p>

                <hr class="pd-divider" />

                <div class="action-box">
                    <div class="pd-stepper">
                        <button type="button" class="pd-step-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                        <span class="pd-qty">
                            <asp:TextBox ID="txtQty" runat="server" Text="1" MaxLength="2" CssClass="qty-input" aria-label="Quantity in kg" /><span class="pd-qty-unit">kg</span>
                        </span>
                        <button type="button" class="pd-step-btn" data-step="1" aria-label="Increase quantity">+</button>
                    </div>

                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="pd-btn pd-btn--cart" ValidationGroup="Product" />
                    <asp:Button ID="btnBuyNow" runat="server" Text="Buy Now" CssClass="pd-btn pd-btn--buy" ValidationGroup="Product" />

                    <asp:RequiredFieldValidator ID="rfvQty" runat="server"
                        ControlToValidate="txtQty"
                        ErrorMessage="Enter quantity"
                        ValidationGroup="Product"
                        Display="Dynamic"
                        CssClass="qty-error"
                        SetFocusOnError="true" />
                    <asp:RangeValidator ID="rvQty" runat="server"
                        ControlToValidate="txtQty"
                        Type="Integer"
                        MinimumValue="1"
                        MaximumValue="10"
                        ErrorMessage="Quantity must be 1&#8211;10"
                        ValidationGroup="Product"
                        Display="Dynamic"
                        CssClass="qty-error"
                        SetFocusOnError="true" />
                </div>

                <div class="pd-benefits">
                    <div class="pd-benefit">
                        <span class="pd-benefit-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h11v9H3V6zm12 3h3.5l2.5 3v3h-6V9zM6.5 16a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm11 0a2 2 0 1 1 0 4 2 2 0 0 1 0-4z" /></svg>
                        </span>
                        Free Delivery in Rajkot
                    </div>
                    <div class="pd-benefit">
                        <span class="pd-benefit-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M17.65 6.35A8 8 0 1 0 19.73 14h-2.08A6 6 0 1 1 12 6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z" /></svg>
                        </span>
                        Easy Returns
                    </div>
                </div>
            </div>

        </section>

        <%-- ================= Pairs Well With ================= --%>
        <section class="pd-pairs">
            <h2 class="pd-pairs-title">Pairs Well With</h2>

            <div class="pd-pairs-grid">

                <article class="pair-card">
                    <div class="pair-media"><img src="Content/Images/chilli.jpg" alt="Fresh Green Chilli" /></div>
                    <h3 class="pair-name">Fresh Green Chilli</h3>
                    <p class="pair-unit">250g</p>
                    <div class="pair-row">
                        <span class="pair-price">&#8377;20</span>
                        <button type="button" class="pair-add" aria-label="Add Fresh Green Chilli">+</button>
                    </div>
                </article>

                <article class="pair-card">
                    <div class="pair-media"><img src="Content/Images/coriander.jpg" alt="Fresh Coriander Leaves" /></div>
                    <h3 class="pair-name">Fresh Coriander Leaves</h3>
                    <p class="pair-unit">1 bunch</p>
                    <div class="pair-row">
                        <span class="pair-price">&#8377;15</span>
                        <button type="button" class="pair-add" aria-label="Add Fresh Coriander Leaves">+</button>
                    </div>
                </article>

                <article class="pair-card">
                    <div class="pair-media"><img src="Content/Images/onion.png" alt="Red Onion" /></div>
                    <h3 class="pair-name">Red Onion</h3>
                    <p class="pair-unit">1kg</p>
                    <div class="pair-row">
                        <span class="pair-price">&#8377;45</span>
                        <button type="button" class="pair-add" aria-label="Add Red Onion">+</button>
                    </div>
                </article>

                <article class="pair-card">
                    <div class="pair-media"><img src="Content/Images/ginger.jpg" alt="Fresh Ginger" /></div>
                    <h3 class="pair-name">Fresh Ginger</h3>
                    <p class="pair-unit">250g</p>
                    <div class="pair-row">
                        <span class="pair-price">&#8377;30</span>
                        <button type="button" class="pair-add" aria-label="Add Fresh Ginger">+</button>
                    </div>
                </article>

            </div>
        </section>

    </div>

    <script type="text/javascript">
        // UI only: gallery thumbnails and the +/- buttons. Quantity limits are
        // enforced by the ASP.NET validators, not here.
        (function () {
            var main = document.getElementById('pdMainImg');
            var thumbs = document.querySelectorAll('.pd-page .pd-thumb[data-src]');

            for (var i = 0; i < thumbs.length; i++) {
                thumbs[i].addEventListener('click', function () {
                    main.src = this.getAttribute('data-src');
                    for (var j = 0; j < thumbs.length; j++) {
                        thumbs[j].className = thumbs[j].className.replace(/\s*\bis-active\b/g, '');
                    }
                    this.className += ' is-active';
                });
            }

            var qty = document.querySelector('.pd-page .qty-input');
            var steps = document.querySelectorAll('.pd-page .pd-step-btn');

            for (var k = 0; k < steps.length; k++) {
                steps[k].addEventListener('click', function () {
                    var step = parseInt(this.getAttribute('data-step'), 10);
                    qty.value = String((parseInt(qty.value, 10) || 0) + step);
                });
            }

            // Site.Master only highlights exact page matches; a product page
            // belongs under Vegetables.
            var nav = document.querySelectorAll('.header-nav .header-nav-link');
            for (var n = 0; n < nav.length; n++) {
                if (/vegetables(\.aspx)?$/i.test(nav[n].pathname)) {
                    nav[n].className += ' is-active';
                }
            }
        })();
    </script>

</asp:Content>
