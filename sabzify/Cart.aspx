<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="sabzify.Cart" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="CartContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .cart-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.cart-page) {
            background: #F1F7EA;
        }

        .cart-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px 64px;
            color: #111827;
        }

        /* Page header ------------------------------------------------------ */
        .cart-page .cart-head {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 28px;
        }

        .cart-page h1.cart-title {
            margin: 0 0 8px;
            font-size: 36px;
            font-weight: 700;
            line-height: 1.15;
            color: #2E7D32;
        }

        .cart-page .cart-location {
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0;
            font-size: 13px;
            color: #374151;
        }

        .cart-page .cart-location svg {
            width: 13px;
            height: 13px;
            fill: #374151;
        }

        .cart-page .cart-continue {
            font-size: 13px;
            font-weight: 600;
            color: #1B6E2A;
            text-decoration: none;
            white-space: nowrap;
        }

        .cart-page .cart-continue:hover,
        .cart-page .cart-continue:focus {
            color: #155822;
            text-decoration: underline;
        }

        /* Two columns ------------------------------------------------------- */
        .cart-page .cart-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 360px;
            gap: 24px;
            align-items: start;
        }

        .cart-page .cart-items {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        /* Item card: a small grid so the pieces can be rearranged on phones. */
        .cart-page .cart-item {
            position: relative;
            display: grid;
            grid-template-columns: 72px minmax(0, 1fr) auto auto;
            grid-template-areas:
                "thumb name  badge   side"
                "thumb unit  .       side"
                "thumb price stepper side";
            column-gap: 16px;
            padding: 14px 16px;
            border-radius: 10px;
            background: #fff;
        }

        .cart-page .item-thumb {
            grid-area: thumb;
            align-self: center;
            width: 72px;
            height: 72px;
            border-radius: 8px;
            overflow: hidden;
            background: #F3F4F6;
        }

        .cart-page .item-thumb img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .cart-page h3.item-name {
            grid-area: name;
            margin: 0;
            font-size: 16px;
            font-weight: 500;
            line-height: 1.35;
            color: #111827;
        }

        .cart-page .item-unit {
            grid-area: unit;
            margin: 2px 0 14px;
            font-size: 12px;
            color: #6B7280;
        }

        .cart-page .item-price {
            grid-area: price;
            align-self: center;
            margin: 0;
            font-size: 17px;
            font-weight: 700;
            color: #111827;
        }

        .cart-page .item-old {
            margin-left: 4px;
            font-size: 12px;
            font-weight: 400;
            color: #9CA3AF;
            text-decoration: line-through;
        }

        .cart-page .item-badge {
            grid-area: badge;
            justify-self: center;
            align-self: start;
            padding: 4px 10px;
            border-radius: 999px;
            background: #F59E0B;
            font-size: 10px;
            font-weight: 700;
            line-height: 1.2;
            color: #fff;
            white-space: nowrap;
        }

        .cart-page .item-side {
            grid-area: side;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            min-width: 64px;
            text-align: right;
        }

        .cart-page .item-remove {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            padding: 0;
            border: 0;
            border-radius: 4px;
            background: none;
            color: #6B7280;
            cursor: pointer;
        }

        .cart-page .item-remove:hover,
        .cart-page .item-remove:focus {
            color: #C0392B;
        }

        .cart-page .item-remove svg {
            width: 18px;
            height: 18px;
            fill: currentColor;
        }

        .cart-page .item-sub-label {
            margin-top: 10px;
            font-size: 11px;
            color: #6B7280;
        }

        .cart-page .item-sub {
            font-size: 15px;
            color: #374151;
        }

        /* Stepper pill; the validators sit inside it so :has() can see them,
           but are positioned under it so the card never changes height. */
        .cart-page .qty-pill {
            grid-area: stepper;
            align-self: center;
            position: relative;
            display: flex;
            align-items: center;
            gap: 14px;
            height: 30px;
            padding: 0 10px;
            border: 1px solid #D6E2EA;
            border-radius: 999px;
            background: #E8F0F5;
        }

        .cart-page .qty-pill:has(.qty-error:not([style*="display:none"]):not([style*="display: none"])) {
            border-color: #C0392B;
        }

        .cart-page .qty-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 16px;
            height: 22px;
            padding: 0;
            border: 0;
            background: none;
            font-size: 14px;
            line-height: 1;
            color: #374151;
            cursor: pointer;
        }

        .cart-page .qty-btn:hover,
        .cart-page .qty-btn:focus {
            color: #1B6E2A;
        }

        .cart-page input.qty-input {
            width: 20px;
            max-width: 20px;
            height: 22px;
            padding: 0;
            border: 0;
            background: transparent;
            text-align: center;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
            outline: none;
        }

        .cart-page .qty-error {
            position: absolute;
            top: calc(100% + 1px);
            right: 0;
            font-size: 11px;
            line-height: 13px;
            text-align: right;
            color: #C0392B;
            white-space: nowrap;
        }

        /* Out of stock ------------------------------------------------------- */
        .cart-page .cart-item.is-out {
            background: #F8FBF5;
        }

        .cart-page .cart-item.is-out h3.item-name,
        .cart-page .cart-item.is-out .item-price {
            color: #4B5563;
        }

        .cart-page .cart-item.is-out .item-name {
            font-weight: 400;
        }

        .cart-page .item-out-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1;
            padding: 2px 6px;
            border-radius: 4px;
            background: #D64545;
            font-size: 10px;
            font-weight: 600;
            line-height: 1.3;
            color: #fff;
            white-space: nowrap;
        }

        /* Empty state -------------------------------------------------------- */
        .cart-page .cart-empty {
            display: none;
            padding: 48px 24px;
            border-radius: 12px;
            background: #fff;
            text-align: center;
        }

        .cart-page.is-empty .cart-empty {
            display: block;
        }

        .cart-page.is-empty .cart-layout {
            display: none;
        }

        .cart-page .cart-empty-title {
            margin: 0 0 16px;
            font-size: 18px;
            font-weight: 600;
            color: #111827;
        }

        .cart-page .cart-empty-btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 6px;
            background: #2E7D32;
            font-size: 14px;
            font-weight: 500;
            color: #fff;
            text-decoration: none;
        }

        .cart-page .cart-empty-btn:hover,
        .cart-page .cart-empty-btn:focus {
            background: #256A2A;
            color: #fff;
        }

        /* Order summary ------------------------------------------------------ */
        .cart-page .cart-summary {
            position: sticky;
            top: 24px;
            padding: 20px;
            border-radius: 12px;
            background: #fff;
        }

        .cart-page h2.summary-title {
            margin: 0 0 16px;
            padding-bottom: 14px;
            border-bottom: 1px solid #E5E7EB;
            font-size: 20px;
            font-weight: 500;
            color: #111827;
        }

        .cart-page .summary-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
            font-size: 13px;
            color: #374151;
        }

        .cart-page .summary-row strong {
            font-weight: 600;
            color: #111827;
        }

        .cart-page .summary-row--discount,
        .cart-page .summary-row--discount strong {
            color: #2E7D32;
        }

        .cart-page .summary-row--discount span {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .cart-page .summary-row--discount svg {
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        .cart-page .summary-divider {
            height: 1px;
            margin: 18px 0;
            border: 0;
            background: #E5E7EB;
            opacity: 1;
        }

        .cart-page .summary-total {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }

        .cart-page .summary-total-label {
            margin-top: 6px;
            font-size: 17px;
            font-weight: 600;
            color: #111827;
        }

        .cart-page .summary-total-value {
            text-align: right;
        }

        .cart-page .summary-total-amount {
            display: block;
            font-size: 30px;
            font-weight: 400;
            line-height: 1.1;
            color: #111827;
        }

        .cart-page .summary-tax {
            display: block;
            font-size: 10px;
            color: #6B7280;
        }

        .cart-page .summary-error {
            margin-top: 12px;
            font-size: 12px;
            line-height: 1.35;
            text-align: center;
            color: #C0392B;
        }

        .cart-page input.checkout-btn {
            display: block;
            width: 100%;
            max-width: none;
            height: 44px;
            margin-top: 22px;
            border: 0;
            border-radius: 6px;
            background: #2E7D32;
            font-size: 15px;
            font-weight: 500;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .cart-page .summary-error + input.checkout-btn {
            margin-top: 12px;
        }

        .cart-page input.checkout-btn:hover,
        .cart-page input.checkout-btn:focus {
            background: #256A2A;
        }

        .cart-page .summary-secure {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            margin: 14px 0 0;
            font-size: 11px;
            color: #6B7280;
        }

        .cart-page .summary-secure svg {
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        /* Responsive --------------------------------------------------------- */
        @media screen and (max-width: 1024px) {
            .cart-page .cart-layout {
                grid-template-columns: minmax(0, 1fr) 300px;
            }
        }

        @media screen and (max-width: 768px) {
            .cart-page .cart-layout {
                grid-template-columns: minmax(0, 1fr);
            }

            .cart-page .cart-summary {
                position: static;
            }

            .cart-page .cart-head {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .cart-page h1.cart-title {
                font-size: 28px;
            }
        }

        @media screen and (max-width: 480px) {
            .cart-page {
                padding: 28px 16px 48px;
            }

            .cart-page .cart-item {
                grid-template-columns: 60px minmax(0, 1fr) auto;
                grid-template-areas:
                    "thumb name    side"
                    "thumb badge   side"
                    "thumb unit    side"
                    "thumb price   side"
                    "thumb stepper side";
                column-gap: 12px;
                padding: 12px;
            }

            .cart-page .item-thumb {
                align-self: start;
                width: 60px;
                height: 60px;
            }

            .cart-page .item-badge {
                justify-self: start;
                margin-top: 4px;
            }

            .cart-page .item-unit {
                margin-bottom: 8px;
            }

            .cart-page .qty-pill {
                justify-self: start;
                margin: 10px 0 14px;
            }

            .cart-page .qty-error {
                left: 0;
                right: auto;
                text-align: left;
            }
        }
    </style>

    <div class="cart-page" id="cartPage">

        <%-- ================= Page header ================= --%>
        <div class="cart-head">
            <div>
                <h1 class="cart-title">Your Cart</h1>
                <p class="cart-location">
                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" /></svg>
                    Delivering to Rajkot
                </p>
            </div>
            <a class="cart-continue" href="Vegetables.aspx">Continue Shopping &#8594;</a>
        </div>

        <div class="cart-layout">

            <%-- ================= Items ================= --%>
            <div class="cart-items" id="cartItems">

                <article class="cart-item" data-price="40">
                    <div class="item-thumb"><img src="Content/Images/carrot.png" alt="Fresh Organic Carrot" /></div>
                    <h3 class="item-name">Fresh Organic Carrot</h3>
                    <p class="item-unit">500g</p>
                    <p class="item-price">&#8377;40</p>
                    <div class="qty-pill">
                        <button type="button" class="qty-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                        <asp:TextBox ID="txtQtyCarrot" runat="server" Text="2" MaxLength="2" CssClass="qty-input" aria-label="Carrot quantity" />
                        <button type="button" class="qty-btn" data-step="1" aria-label="Increase quantity">+</button>
                        <asp:RequiredFieldValidator ID="rfvQtyCarrot" runat="server" ControlToValidate="txtQtyCarrot" Text="Enter quantity" ErrorMessage="" ValidationGroup="Cart" Display="Dynamic" CssClass="qty-error" SetFocusOnError="true" />
                        <asp:RangeValidator ID="rvQtyCarrot" runat="server" ControlToValidate="txtQtyCarrot" Type="Integer" MinimumValue="1" MaximumValue="10" Text="Quantity must be 1&#8211;10" ErrorMessage="" ValidationGroup="Cart" Display="Dynamic" CssClass="qty-error" SetFocusOnError="true" />
                    </div>
                    <div class="item-side">
                        <button type="button" class="item-remove" aria-label="Remove Fresh Organic Carrot">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 3h6l1 2h4v2H4V5h4l1-2zM6 9h12l-1 12H7L6 9zm4 2v8h1.5v-8H10zm2.5 0v8H14v-8h-1.5z" /></svg>
                        </button>
                        <span class="item-sub-label">Subtotal</span>
                        <span class="item-sub">&#8377;80</span>
                    </div>
                </article>

                <article class="cart-item" data-price="120">
                    <div class="item-thumb"><img src="Content/Images/broccoli.jpg" alt="Premium Broccoli" /></div>
                    <h3 class="item-name">Premium Broccoli</h3>
                    <span class="item-badge">10% OFF</span>
                    <p class="item-unit">1 kg</p>
                    <p class="item-price">&#8377;120 <span class="item-old">&#8377;135</span></p>
                    <div class="qty-pill">
                        <button type="button" class="qty-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                        <asp:TextBox ID="txtQtyBroccoli" runat="server" Text="1" MaxLength="2" CssClass="qty-input" aria-label="Broccoli quantity" />
                        <button type="button" class="qty-btn" data-step="1" aria-label="Increase quantity">+</button>
                        <asp:RequiredFieldValidator ID="rfvQtyBroccoli" runat="server" ControlToValidate="txtQtyBroccoli" Text="Enter quantity" ErrorMessage="" ValidationGroup="Cart" Display="Dynamic" CssClass="qty-error" SetFocusOnError="true" />
                        <asp:RangeValidator ID="rvQtyBroccoli" runat="server" ControlToValidate="txtQtyBroccoli" Type="Integer" MinimumValue="1" MaximumValue="10" Text="Quantity must be 1&#8211;10" ErrorMessage="" ValidationGroup="Cart" Display="Dynamic" CssClass="qty-error" SetFocusOnError="true" />
                    </div>
                    <div class="item-side">
                        <button type="button" class="item-remove" aria-label="Remove Premium Broccoli">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 3h6l1 2h4v2H4V5h4l1-2zM6 9h12l-1 12H7L6 9zm4 2v8h1.5v-8H10zm2.5 0v8H14v-8h-1.5z" /></svg>
                        </button>
                        <span class="item-sub-label">Subtotal</span>
                        <span class="item-sub">&#8377;120</span>
                    </div>
                </article>

                <article class="cart-item is-out">
                    <span class="item-out-badge">Out of Stock</span>
                    <div class="item-thumb"><img src="Content/Images/tomato.png" alt="Tomatoes" /></div>
                    <h3 class="item-name">Tomatoes</h3>
                    <p class="item-unit">500g</p>
                    <p class="item-price">&#8377;30</p>
                    <div class="item-side">
                        <button type="button" class="item-remove" aria-label="Remove Tomatoes">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9 3h6l1 2h4v2H4V5h4l1-2zM6 9h12l-1 12H7L6 9zm4 2v8h1.5v-8H10zm2.5 0v8H14v-8h-1.5z" /></svg>
                        </button>
                    </div>
                </article>

            </div>

            <%-- ================= Order summary ================= --%>
            <aside class="cart-summary">
                <h2 class="summary-title">Order Summary</h2>

                <div class="summary-row">
                    <span id="sumItemsLabel">Subtotal (2 items)</span>
                    <strong id="sumSubtotal">&#8377;200</strong>
                </div>
                <div class="summary-row">
                    <span>Delivery Charge</span>
                    <strong id="sumDelivery">&#8377;20</strong>
                </div>
                <div class="summary-row summary-row--discount">
                    <span>
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M21.4 11.6 12.4 2.6A2 2 0 0 0 11 2H4a2 2 0 0 0-2 2v7c0 .6.2 1.1.6 1.4l9 9a2 2 0 0 0 2.8 0l7-7a2 2 0 0 0 0-2.8zM6.5 8a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z" /></svg>
                        Discount
                    </span>
                    <strong id="sumDiscount">-&#8377;10</strong>
                </div>

                <hr class="summary-divider" />

                <div class="summary-total">
                    <span class="summary-total-label">Total</span>
                    <span class="summary-total-value">
                        <span class="summary-total-amount" id="sumTotal">&#8377;210</span>
                        <span class="summary-tax">Includes all applicable taxes</span>
                    </span>
                </div>

                <asp:ValidationSummary ID="vsCart" runat="server"
                    ValidationGroup="Cart"
                    DisplayMode="SingleParagraph"
                    HeaderText="Please fix the quantities in your cart"
                    ShowMessageBox="false"
                    CssClass="summary-error" />

                <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout &#8594;" CssClass="checkout-btn" ValidationGroup="Cart" PostBackUrl="~/Checkout.aspx" />

                <p class="summary-secure">
                    <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 1 3 5v6c0 5 3.8 9.7 9 11 5.2-1.3 9-6 9-11V5l-9-4zm-1 15-4-4 1.4-1.4L11 13.2l4.6-4.6L17 10l-6 6z" /></svg>
                    Secure SSL Checkout
                </p>
            </aside>

        </div>

        <%-- ================= Empty state ================= --%>
        <div class="cart-empty">
            <p class="cart-empty-title">Your cart is empty</p>
            <a class="cart-empty-btn" href="Vegetables.aspx">Continue Shopping</a>
        </div>

    </div>

    <script type="text/javascript">
        // UI only: +/- change numbers, trash removes a card, and the totals are
        // recalculated. Quantity rules are left to the ASP.NET validators.
        (function () {
            // Escape sequence, never a literal symbol: the page must not depend
            // on how the .aspx file's bytes happen to be decoded.
            var RUPEE = '\u20B9';
            var DELIVERY = 20, DISCOUNT = 10;
            var page = document.getElementById('cartPage');
            var list = document.getElementById('cartItems');

            function rupees(n) { return (n < 0 ? '-' : '') + RUPEE + Math.abs(n); }

            function qtyOf(card) {
                var box = card.querySelector('.qty-input');
                return box ? (parseInt(box.value, 10) || 0) : 0;
            }

            function recalc() {
                var cards = list.querySelectorAll('.cart-item');
                var subtotal = 0, count = 0;

                for (var i = 0; i < cards.length; i++) {
                    var card = cards[i];
                    if (card.classList.contains('is-out')) { continue; }
                    var line = parseInt(card.getAttribute('data-price'), 10) * qtyOf(card);
                    card.querySelector('.item-sub').textContent = rupees(line);
                    subtotal += line;
                    count++;
                }

                var delivery = count ? DELIVERY : 0;
                var discount = count ? DISCOUNT : 0;
                document.getElementById('sumItemsLabel').textContent = 'Subtotal (' + count + (count === 1 ? ' item)' : ' items)');
                document.getElementById('sumSubtotal').textContent = rupees(subtotal);
                document.getElementById('sumDelivery').textContent = rupees(delivery);
                document.getElementById('sumDiscount').textContent = rupees(-discount);
                document.getElementById('sumTotal').textContent = rupees(subtotal + delivery - discount);

                if (!cards.length) { page.classList.add('is-empty'); }
            }

            list.addEventListener('click', function (e) {
                var step = e.target.closest('.qty-btn');
                if (step) {
                    var box = step.parentNode.querySelector('.qty-input');
                    box.value = String((parseInt(box.value, 10) || 0) + parseInt(step.getAttribute('data-step'), 10));
                    recalc();
                    return;
                }

                var remove = e.target.closest('.item-remove');
                if (remove) {
                    var card = remove.closest('.cart-item');
                    // A removed card's validators must stop taking part in the
                    // Cart group, otherwise checkout would look for a missing box.
                    var vals = card.querySelectorAll('.qty-error');
                    for (var i = 0; i < vals.length; i++) {
                        if (typeof ValidatorEnable === 'function') { ValidatorEnable(vals[i], false); }
                    }
                    card.parentNode.removeChild(card);
                    recalc();
                }
            });

            list.addEventListener('input', function (e) {
                if (e.target.classList.contains('qty-input')) { recalc(); }
            });

            // Derive the subtotals and the summary from the quantity boxes right
            // away, so the markup and the totals can never drift apart.
            recalc();
        })();
    </script>

</asp:Content>
