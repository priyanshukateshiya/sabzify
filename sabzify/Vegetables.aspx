<%@ Page Title="Vegetables" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vegetables.aspx.cs" Inherits="sabzify.Vegetables" UnobtrusiveValidationMode="None" %>

<asp:Content ID="VegetablesContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .veg-page. --%>
    <style>
        .veg-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 32px 24px 48px;
            color: #111827;
        }

        .veg-page .veg-layout {
            display: grid;
            grid-template-columns: 220px minmax(0, 1fr);
            gap: 24px;
            align-items: start;
        }

        /* Filters sidebar ------------------------------------------------ */
        .veg-page .veg-filters {
            position: sticky;
            top: 24px;
            padding: 20px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 18px rgba(26, 43, 32, .06);
        }

        .veg-page .veg-filters-title {
            margin: 0 0 14px;
            padding-bottom: 10px;
            border-bottom: 1px solid #E5E7EB;
            font-size: 18px;
            font-weight: 600;
            color: #1B6E2A;
        }

        .veg-page .veg-filters-heading {
            margin: 0 0 8px;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .veg-page .veg-check {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 8px;
            font-size: 14px;
            font-weight: 400;
            color: #374151;
            cursor: pointer;
        }

        .veg-page .veg-check input {
            width: 15px;
            height: 15px;
            margin: 0;
            accent-color: #1B6E2A;
            cursor: pointer;
        }

        .veg-page .veg-check--gap {
            margin-top: 18px;
        }

        /* Header row ------------------------------------------------------ */
        .veg-page .veg-head {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .veg-page h1.veg-title {
            margin: 0 0 4px;
            font-size: 26px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .veg-page .veg-count {
            margin: 0;
            font-size: 13px;
            color: #6B7280;
        }

        .veg-page .veg-sort {
            height: 36px;
            padding: 0 10px;
            border: 1px solid #E5E7EB;
            border-radius: 8px;
            background: #fff;
            font-size: 13px;
            color: #111827;
            cursor: pointer;
        }

        /* Product grid ---------------------------------------------------- */
        .veg-page .veg-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
        }

        .veg-page .veg-card {
            display: flex;
            flex-direction: column;
            padding: 10px;
            border: 1px solid transparent;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 18px rgba(26, 43, 32, .06);
        }

        .veg-page .veg-card.is-in-cart {
            border-color: #A7D7A0;
        }

        .veg-page .veg-media {
            position: relative;
            height: 150px;
            border-radius: 8px;
            overflow: hidden;
            background: #F3F4F6;
        }

        .veg-page .veg-media img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .veg-page .veg-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            color: #fff;
        }

        .veg-page .veg-badge--sale {
            background: #F59E0B;
        }

        .veg-page .veg-badge--organic {
            background: #1B6E2A;
        }

        .veg-page h3.veg-name {
            margin: 12px 0 18px;
            font-size: 14px;
            font-weight: 500;
            line-height: 1.35;
            color: #111827;
        }

        .veg-page .veg-price {
            margin: 0 0 10px;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }

        .veg-page .veg-unit {
            font-size: 12px;
            font-weight: 400;
            color: #6B7280;
        }

        .veg-page .veg-old {
            margin-left: 4px;
            font-size: 12px;
            font-weight: 400;
            color: #9CA3AF;
            text-decoration: line-through;
        }

        /* The action area reserves room under the button/stepper for the
           quantity error, so every card's button stays on the same line. */
        .veg-page .veg-actions {
            margin-top: auto;
            padding-bottom: 16px;
        }

        .veg-page .veg-add {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            height: 36px;
            padding: 0 8px;
            border: 0;
            border-radius: 6px;
            background: #1B6E2A;
            font-size: 13px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
        }

        .veg-page .veg-add:hover,
        .veg-page .veg-add:focus {
            background: #155822;
        }

        .veg-page .veg-add svg {
            width: 15px;
            height: 15px;
            fill: currentColor;
            flex: none;
        }

        .veg-page .stepper {
            position: relative;
            display: none;
            align-items: center;
            justify-content: space-between;
            height: 36px;
            padding: 0 4px;
            border: 1px solid #A7D7A0;
            border-radius: 6px;
            background: #EEF6EC;
        }

        .veg-page .veg-card.is-in-cart .stepper {
            display: flex;
        }

        .veg-page .veg-card.is-in-cart .veg-add {
            display: none;
        }

        .veg-page .stepper-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
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

        .veg-page .stepper-btn:hover,
        .veg-page .stepper-btn:focus {
            background: #DDEFD9;
        }

        .veg-page input.qty-input {
            width: 32px;
            max-width: 32px;
            height: 28px;
            padding: 0;
            border: 0;
            background: transparent;
            text-align: center;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
            outline: none;
        }

        .veg-page .qty-error {
            position: absolute;
            top: calc(100% + 2px);
            left: 0;
            right: 0;
            font-size: 11px;
            line-height: 1.3;
            text-align: center;
            color: #C0392B;
            white-space: nowrap;
        }

        .veg-page .stepper:has(.qty-error:not([style*="display:none"]):not([style*="display: none"])) {
            border-color: #C0392B;
        }

        /* Pagination ------------------------------------------------------- */
        .veg-page .veg-pager {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 32px;
        }

        .veg-page .pager-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            padding: 0;
            border: 1px solid #D1D5DB;
            border-radius: 50%;
            background: #fff;
            font-size: 12px;
            font-weight: 500;
            color: #374151;
            cursor: pointer;
        }

        .veg-page .pager-btn:hover:not(:disabled):not(.is-active) {
            border-color: #1B6E2A;
            color: #1B6E2A;
        }

        .veg-page .pager-btn.is-active {
            border-color: #1B6E2A;
            background: #1B6E2A;
            color: #fff;
        }

        .veg-page .pager-btn:disabled {
            opacity: .5;
            cursor: default;
        }

        .veg-page .pager-btn svg {
            width: 14px;
            height: 14px;
            fill: currentColor;
        }

        .veg-page .pager-gap {
            font-size: 12px;
            color: #6B7280;
        }

        /* Responsive ------------------------------------------------------- */
        @media screen and (max-width: 1024px) {
            .veg-page .veg-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 768px) {
            .veg-page .veg-layout {
                grid-template-columns: minmax(0, 1fr);
            }

            .veg-page .veg-filters {
                position: static;
            }

            .veg-page .veg-head {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .veg-page .veg-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 480px) {
            .veg-page {
                padding: 24px 16px 40px;
            }

            .veg-page .veg-grid {
                gap: 10px;
            }

            .veg-page .veg-media {
                height: 120px;
            }

            .veg-page .veg-pager {
                gap: 6px;
            }
        }
    </style>

    <div class="veg-page">
        <div class="veg-layout">

            <%-- ================= Filters ================= --%>
            <aside class="veg-filters">
                <h2 class="veg-filters-title">Filters</h2>
                <p class="veg-filters-heading">Categories</p>
                <label class="veg-check"><input type="checkbox" checked="checked" /> Leafy Greens</label>
                <label class="veg-check"><input type="checkbox" checked="checked" /> Root Vegetables</label>
                <label class="veg-check"><input type="checkbox" /> Marrows</label>
                <label class="veg-check veg-check--gap"><input type="checkbox" /> Organic Only</label>
            </aside>

            <section class="veg-main">

                <%-- ================= Header row ================= --%>
                <div class="veg-head">
                    <div>
                        <h1 class="veg-title">Fresh Vegetables</h1>
                        <p class="veg-count">Showing 1&#8211;12 of 48 fresh items in Rajkot</p>
                    </div>
                    <select class="veg-sort" aria-label="Sort products">
                        <option>Sort by: Popularity</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                        <option>Newest</option>
                    </select>
                </div>

                <%-- ================= Product grid ================= --%>
                <%-- Every card renders both the Add to Cart button and the stepper;
                     .is-in-cart on the card decides which one shows. --%>
                <div class="veg-grid">

                    <article class="veg-card">
                        <div class="veg-media">
                            <img src="Content/Images/carrot.png" alt="Farm Fresh Carrot" />
                            <span class="veg-badge veg-badge--sale">-10%</span>
                        </div>
                        <h3 class="veg-name">Farm Fresh Carrot</h3>
                        <p class="veg-price">&#8377;40 <span class="veg-unit">/kg</span> <span class="veg-old">&#8377;45</span></p>
                        <div class="veg-actions">
                            <button type="button" class="veg-add">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" /></svg>
                                Add to Cart
                            </button>
                            <div class="stepper">
                                <button type="button" class="stepper-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                                <asp:TextBox ID="txtQtyCarrot" runat="server" Text="1" MaxLength="2" CssClass="qty-input" aria-label="Carrot quantity" />
                                <button type="button" class="stepper-btn" data-step="1" aria-label="Increase quantity">+</button>
                                <asp:RequiredFieldValidator ID="rfvQtyCarrot" runat="server" ControlToValidate="txtQtyCarrot" ErrorMessage="Enter quantity" ValidationGroup="QtyCarrot" Display="Dynamic" CssClass="qty-error" />
                                <asp:RangeValidator ID="rvQtyCarrot" runat="server" ControlToValidate="txtQtyCarrot" Type="Integer" MinimumValue="1" MaximumValue="10" ErrorMessage="Quantity must be 1&#8211;10" ValidationGroup="QtyCarrot" Display="Dynamic" CssClass="qty-error" />
                            </div>
                        </div>
                    </article>

                    <article class="veg-card">
                        <div class="veg-media">
                            <a href="ProductDetails.aspx"><img src="Content/Images/tomato.png" alt="Local Tomato" /></a>
                        </div>
                        <h3 class="veg-name"><a href="ProductDetails.aspx">Local Tomato</a></h3>
                        <p class="veg-price">&#8377;35 <span class="veg-unit">/kg</span></p>
                        <div class="veg-actions">
                            <button type="button" class="veg-add">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" /></svg>
                                Add to Cart
                            </button>
                            <div class="stepper">
                                <button type="button" class="stepper-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                                <asp:TextBox ID="txtQtyTomato" runat="server" Text="1" MaxLength="2" CssClass="qty-input" aria-label="Tomato quantity" />
                                <button type="button" class="stepper-btn" data-step="1" aria-label="Increase quantity">+</button>
                                <asp:RequiredFieldValidator ID="rfvQtyTomato" runat="server" ControlToValidate="txtQtyTomato" ErrorMessage="Enter quantity" ValidationGroup="QtyTomato" Display="Dynamic" CssClass="qty-error" />
                                <asp:RangeValidator ID="rvQtyTomato" runat="server" ControlToValidate="txtQtyTomato" Type="Integer" MinimumValue="1" MaximumValue="10" ErrorMessage="Quantity must be 1&#8211;10" ValidationGroup="QtyTomato" Display="Dynamic" CssClass="qty-error" />
                            </div>
                        </div>
                    </article>

                    <article class="veg-card">
                        <div class="veg-media">
                            <img src="Content/Images/potato.jpg" alt="Organic Potato" />
                            <span class="veg-badge veg-badge--organic">Organic</span>
                        </div>
                        <h3 class="veg-name">Organic Potato</h3>
                        <p class="veg-price">&#8377;35 <span class="veg-unit">/kg</span></p>
                        <div class="veg-actions">
                            <button type="button" class="veg-add">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" /></svg>
                                Add to Cart
                            </button>
                            <div class="stepper">
                                <button type="button" class="stepper-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                                <asp:TextBox ID="txtQtyPotato" runat="server" Text="1" MaxLength="2" CssClass="qty-input" aria-label="Potato quantity" />
                                <button type="button" class="stepper-btn" data-step="1" aria-label="Increase quantity">+</button>
                                <asp:RequiredFieldValidator ID="rfvQtyPotato" runat="server" ControlToValidate="txtQtyPotato" ErrorMessage="Enter quantity" ValidationGroup="QtyPotato" Display="Dynamic" CssClass="qty-error" />
                                <asp:RangeValidator ID="rvQtyPotato" runat="server" ControlToValidate="txtQtyPotato" Type="Integer" MinimumValue="1" MaximumValue="10" ErrorMessage="Quantity must be 1&#8211;10" ValidationGroup="QtyPotato" Display="Dynamic" CssClass="qty-error" />
                            </div>
                        </div>
                    </article>

                    <article class="veg-card is-in-cart">
                        <div class="veg-media">
                            <img src="Content/Images/palak.jpg" alt="Fresh Palak" />
                        </div>
                        <h3 class="veg-name">Fresh Palak</h3>
                        <p class="veg-price">&#8377;25 <span class="veg-unit">/bunch</span></p>
                        <div class="veg-actions">
                            <button type="button" class="veg-add">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" /></svg>
                                Add to Cart
                            </button>
                            <div class="stepper">
                                <button type="button" class="stepper-btn" data-step="-1" aria-label="Decrease quantity">&#8722;</button>
                                <asp:TextBox ID="txtQtyPalak" runat="server" Text="2" MaxLength="2" CssClass="qty-input" aria-label="Palak quantity" />
                                <button type="button" class="stepper-btn" data-step="1" aria-label="Increase quantity">+</button>
                                <asp:RequiredFieldValidator ID="rfvQtyPalak" runat="server" ControlToValidate="txtQtyPalak" ErrorMessage="Enter quantity" ValidationGroup="QtyPalak" Display="Dynamic" CssClass="qty-error" />
                                <asp:RangeValidator ID="rvQtyPalak" runat="server" ControlToValidate="txtQtyPalak" Type="Integer" MinimumValue="1" MaximumValue="10" ErrorMessage="Quantity must be 1&#8211;10" ValidationGroup="QtyPalak" Display="Dynamic" CssClass="qty-error" />
                            </div>
                        </div>
                    </article>

                </div>

                <%-- ================= Pagination ================= --%>
                <nav class="veg-pager" aria-label="Pages">
                    <button type="button" class="pager-btn" disabled="disabled" aria-label="Previous page">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M15.4 7.4 14 6l-6 6 6 6 1.4-1.4L10.8 12z" /></svg>
                    </button>
                    <button type="button" class="pager-btn is-active" aria-current="page">1</button>
                    <button type="button" class="pager-btn">2</button>
                    <button type="button" class="pager-btn">3</button>
                    <span class="pager-gap">&#8230;</span>
                    <button type="button" class="pager-btn">12</button>
                    <button type="button" class="pager-btn" aria-label="Next page">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M8.6 16.6 10 18l6-6-6-6-1.4 1.4 4.6 4.6z" /></svg>
                    </button>
                </nav>

            </section>
        </div>
    </div>

    <script type="text/javascript">
        // UI only: switches a card between "Add to Cart" and the stepper and
        // moves the number up/down. Limits are left to the ASP.NET validators.
        (function () {
            var cards = document.querySelectorAll('.veg-page .veg-card');

            for (var i = 0; i < cards.length; i++) {
                (function (card) {
                    var input = card.querySelector('.qty-input');

                    card.querySelector('.veg-add').addEventListener('click', function () {
                        input.value = '1';
                        card.className += ' is-in-cart';
                        input.focus();
                    });

                    var steps = card.querySelectorAll('.stepper-btn');
                    for (var j = 0; j < steps.length; j++) {
                        steps[j].addEventListener('click', function () {
                            var step = parseInt(this.getAttribute('data-step'), 10);
                            var qty = parseInt(input.value, 10) || 0;

                            if (step < 0 && qty === 1) {
                                card.className = card.className.replace(/\s*\bis-in-cart\b/g, '');
                                return;
                            }
                            input.value = String(qty + step);
                        });
                    }
                })(cards[i]);
            }
        })();
    </script>

</asp:Content>
