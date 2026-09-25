<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="sabzify.Checkout" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="CheckoutContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .checkout-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.checkout-page) {
            background: #F7FAFC;
        }

        .checkout-page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 32px 24px 56px;
            color: #111827;
        }

        /* Two columns ------------------------------------------------------- */
        .checkout-page .checkout-layout {
            display: flex;
            align-items: flex-start;
            gap: 24px;
        }

        .checkout-page .checkout-main {
            flex: 1 1 auto;
            min-width: 0;
        }

        /* Cards -------------------------------------------------------------- */
        .checkout-page .co-card {
            padding: 20px;
            border: 1px solid #EEF1F4;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .05);
        }

        .checkout-page .checkout-main .co-card {
            margin-bottom: 20px;
        }

        .checkout-page .co-card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 18px;
            padding-bottom: 14px;
            border-bottom: 1px solid #EEF1F4;
            font-size: 15px;
            font-weight: 600;
            color: #111827;
        }

        .checkout-page .co-card-title svg {
            flex: none;
            width: 16px;
            height: 16px;
            fill: #1B6E2A;
        }

        /* Delivery address form ---------------------------------------------- */
        .checkout-page .addr-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px 16px;
        }

        /* The field is the positioning context for its error, which floats in
           the grid gap so a message can never change the card's height. */
        .checkout-page .co-field {
            position: relative;
            min-width: 0;
        }

        .checkout-page .co-field--full {
            grid-column: 1 / -1;
        }

        .checkout-page .co-label {
            display: block;
            margin-bottom: 5px;
            font-size: 11px;
            color: #6B7280;
        }

        .checkout-page input.co-input {
            display: block;
            box-sizing: border-box;
            width: 100%;
            max-width: none;
            height: 38px;
            margin: 0;
            padding: 0 12px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-size: 13px;
            line-height: normal;
            color: #111827;
            outline: none;
        }

        .checkout-page input.co-input::placeholder {
            color: #9CA3AF;
        }

        .checkout-page input.co-input:focus {
            border-color: #1B6E2A;
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .15);
        }

        .checkout-page input.co-input--filled {
            background: #F0F7FA;
        }

        /* Validator messages -------------------------------------------------- */
        /* Display="Dynamic" means the span carries style="display:none" while the
           field is valid, so :has() can pick out only the messages on screen. */
        .checkout-page .field-error {
            position: absolute;
            top: calc(100% + 1px);
            left: 0;
            right: 0;
            display: block;
            margin: 0;
            font-size: 11px;
            line-height: 13px;
            text-align: left;
            color: #C0392B;
        }

        .checkout-page .co-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.co-input,
        .checkout-page .co-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.co-input:focus {
            border-color: #C0392B;
        }

        .checkout-page .co-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.co-input:focus {
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .15);
        }

        /* Delivery slot ------------------------------------------------------- */
        .checkout-page .slot-wrap {
            position: relative;
        }

        .checkout-page .slot-list {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px;
        }

        /* The native radios stay reachable by keyboard and by the validator, but
           are taken out of the grid flow so only the cards are laid out. */
        .checkout-page .slot-list input[type="radio"] {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            padding: 0;
            border: 0;
            opacity: 0;
            pointer-events: none;
        }

        .checkout-page .slot-list label {
            position: relative;
            display: block;
            padding: 16px;
            border: 1px solid #E1E6EA;
            border-radius: 8px;
            background: #fff;
            text-align: center;
            cursor: pointer;
        }

        /* The radio dot in the corner of every card. */
        .checkout-page .slot-list label::after {
            content: "";
            position: absolute;
            top: 10px;
            right: 10px;
            box-sizing: border-box;
            width: 12px;
            height: 12px;
            border: 1px solid #CBD5DD;
            border-radius: 50%;
            background: #fff;
        }

        .checkout-page .slot-list input[type="radio"]:checked + label {
            border-color: #1B6E2A;
            background: #EAF6F8;
        }

        .checkout-page .slot-list input[type="radio"]:checked + label::after {
            border-color: #1B6E2A;
            background: #1B6E2A;
            box-shadow: inset 0 0 0 2px #EAF6F8;
        }

        .checkout-page .slot-list input[type="radio"]:focus + label {
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .15);
        }

        .checkout-page .slot-icon {
            display: block;
            width: 18px;
            height: 18px;
            margin: 0 auto 8px;
        }

        .checkout-page .slot-icon--sun {
            fill: #F59E0B;
        }

        .checkout-page .slot-icon--moon {
            fill: #1E3A5F;
        }

        .checkout-page .slot-name {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .checkout-page .slot-time {
            display: block;
            margin-top: 2px;
            font-size: 11px;
            color: #6B7280;
        }

        .checkout-page .slot-wrap .field-error {
            top: calc(100% + 4px);
        }

        /* Payment method ------------------------------------------------------ */
        .checkout-page .pay-option {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 14px;
            border: 1px solid #1B6E2A;
            border-radius: 8px;
            background: #EAF6F8;
        }

        .checkout-page .pay-option svg.pay-icon {
            flex: none;
            width: 18px;
            height: 18px;
            fill: #374151;
        }

        .checkout-page .pay-option .pay-radio {
            margin-left: auto;
        }

        /* The COD radio is the only option, so it is shown as a plain dot. */
        .checkout-page .pay-option .pay-radio input[type="radio"] {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            opacity: 0;
            pointer-events: none;
        }

        .checkout-page .pay-option .pay-radio label {
            display: block;
            box-sizing: border-box;
            width: 12px;
            height: 12px;
            border: 1px solid #1B6E2A;
            border-radius: 50%;
            background: #1B6E2A;
            box-shadow: inset 0 0 0 2px #EAF6F8;
            font-size: 0;
            cursor: pointer;
        }

        .checkout-page .pay-name {
            font-size: 13px;
            color: #111827;
        }

        /* Order summary ------------------------------------------------------- */
        .checkout-page .co-summary {
            position: sticky;
            top: 24px;
            flex: 0 0 330px;
            width: 330px;
        }

        .checkout-page .sum-item {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 12px;
            font-size: 12px;
        }

        .checkout-page .sum-item-name {
            min-width: 0;
            color: #374151;
        }

        .checkout-page .sum-item-amount {
            flex: none;
            font-weight: 600;
            color: #111827;
        }

        .checkout-page .sum-divider {
            height: 1px;
            margin: 16px 0;
            border: 0;
            background: #EEF1F4;
            opacity: 1;
        }

        .checkout-page .sum-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 10px;
            font-size: 12px;
            color: #374151;
        }

        .checkout-page .sum-row strong {
            font-weight: 600;
            color: #111827;
        }

        .checkout-page .sum-row--discount,
        .checkout-page .sum-row--discount strong {
            color: #1B6E2A;
        }

        .checkout-page .sum-total {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .checkout-page .sum-total-label {
            font-size: 15px;
            font-weight: 600;
            color: #111827;
        }

        .checkout-page .sum-total-amount {
            font-size: 19px;
            font-weight: 700;
            color: #1B6E2A;
        }

        .checkout-page .summary-error {
            margin: 18px 0 10px;
            font-size: 11px;
            line-height: 1.35;
            text-align: center;
            color: #C0392B;
        }

        .checkout-page input.place-btn {
            display: block;
            box-sizing: border-box;
            width: 100%;
            max-width: none;
            height: 40px;
            margin-top: 18px;
            padding: 0;
            border: 0;
            border-radius: 999px;
            background: #1B6E2A;
            font-size: 13px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        /* The summary already supplies the gap when it is on screen. */
        .checkout-page .summary-error + input.place-btn {
            margin-top: 0;
        }

        .checkout-page input.place-btn:hover,
        .checkout-page input.place-btn:focus {
            background: #155822;
        }

        .checkout-page .sum-secure {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            margin: 10px 0 0;
            font-size: 10px;
            color: #6B7280;
        }

        .checkout-page .sum-secure svg {
            flex: none;
            width: 10px;
            height: 10px;
            fill: currentColor;
        }

        /* Responsive ----------------------------------------------------------- */
        @media screen and (max-width: 1024px) {
            .checkout-page .co-summary {
                flex-basis: 300px;
                width: 300px;
            }
        }

        @media screen and (max-width: 768px) {
            /* Stacked, so the columns have to stretch: flex-start would shrink
               each one to its content width. */
            .checkout-page .checkout-layout {
                flex-direction: column;
                align-items: stretch;
            }

            .checkout-page .co-summary {
                position: static;
                flex: 0 0 auto;
                width: auto;
            }

            .checkout-page .addr-grid {
                grid-template-columns: minmax(0, 1fr);
            }
        }

        @media screen and (max-width: 480px) {
            .checkout-page {
                padding: 20px 16px;
            }

            .checkout-page .slot-list {
                grid-template-columns: minmax(0, 1fr);
            }
        }
    </style>

    <div class="checkout-page">
        <div class="checkout-layout">

            <div class="checkout-main">

                <%-- ================= Delivery address ================= --%>
                <section class="co-card">
                    <h2 class="co-card-title">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" /></svg>
                        Delivery Address
                    </h2>

                    <div class="addr-grid">

                        <div class="co-field">
                            <label class="co-label" for="<%= txtFullName.ClientID %>">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="co-input" placeholder="vivek makvana" />
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                                ControlToValidate="txtFullName"
                                Text="Full name is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revFullName" runat="server"
                                ControlToValidate="txtFullName"
                                ValidationExpression="^(?=.{2,100}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                                Text="Name can contain only letters and spaces"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="co-field">
                            <label class="co-label" for="<%= txtPhone.ClientID %>">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="co-input" placeholder="+91 98765 43210" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                ControlToValidate="txtPhone"
                                Text="Phone number is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revPhone" runat="server"
                                ControlToValidate="txtPhone"
                                ValidationExpression="^(\+91[\s-]?)?[6-9]\d{9}$"
                                Text="Enter a valid 10-digit mobile number"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="co-field co-field--full">
                            <label class="co-label" for="<%= txtAddress.ClientID %>">Flat, House no., Building, Company, Apartment</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="co-input" placeholder="rajkot" />
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                                ControlToValidate="txtAddress"
                                Text="Delivery address is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revAddress" runat="server"
                                ControlToValidate="txtAddress"
                                ValidationExpression="^.{5,200}$"
                                Text="Enter a complete address"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="co-field">
                            <label class="co-label" for="<%= txtCity.ClientID %>">City</label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="co-input co-input--filled" placeholder="Rajkot" />
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                                ControlToValidate="txtCity"
                                Text="City is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revCity" runat="server"
                                ControlToValidate="txtCity"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .-][A-Za-z]+)*$"
                                Text="Enter a valid city name"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="co-field">
                            <label class="co-label" for="<%= txtState.ClientID %>">State</label>
                            <asp:TextBox ID="txtState" runat="server" CssClass="co-input co-input--filled" placeholder="Gujarat" />
                            <asp:RequiredFieldValidator ID="rfvState" runat="server"
                                ControlToValidate="txtState"
                                Text="State is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revState" runat="server"
                                ControlToValidate="txtState"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .-][A-Za-z]+)*$"
                                Text="Enter a valid state name"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="co-field">
                            <label class="co-label" for="<%= txtPincode.ClientID %>">Pincode</label>
                            <asp:TextBox ID="txtPincode" runat="server" CssClass="co-input" placeholder="360001" />
                            <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                                ControlToValidate="txtPincode"
                                Text="Pincode is required"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revPincode" runat="server"
                                ControlToValidate="txtPincode"
                                ValidationExpression="^[1-9][0-9]{5}$"
                                Text="Enter a valid 6-digit pincode"
                                ErrorMessage=""
                                ValidationGroup="Checkout"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                    </div>
                </section>

                <%-- ================= Delivery slot ================= --%>
                <section class="co-card">
                    <h2 class="co-card-title">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm0 2a8 8 0 1 1 0 16 8 8 0 0 1 0-16zm-1 3v6l5 3 1-1.7-4-2.3V7h-2z" /></svg>
                        Delivery Slot
                    </h2>

                    <%-- A RadioButtonList keeps this one control, so a plain
                         RequiredFieldValidator can guard it with no code behind. --%>
                    <div class="slot-wrap">
                        <asp:RadioButtonList ID="rblSlot" runat="server"
                            CssClass="slot-list"
                            RepeatLayout="Flow"
                            RepeatDirection="Horizontal">
                            <asp:ListItem Value="Morning" Selected="True" Text='&lt;svg class="slot-icon slot-icon--sun" viewBox="0 0 24 24" aria-hidden="true"&gt;&lt;path d="M12 17a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0-13.5a1 1 0 0 1 1 1V6a1 1 0 0 1-2 0V4.5a1 1 0 0 1 1-1zm0 15a1 1 0 0 1 1 1V21a1 1 0 0 1-2 0v-1.5a1 1 0 0 1 1-1zM3.5 12a1 1 0 0 1 1-1H6a1 1 0 0 1 0 2H4.5a1 1 0 0 1-1-1zm14.5 0a1 1 0 0 1 1-1h1.5a1 1 0 0 1 0 2H19a1 1 0 0 1-1-1zM5.6 5.6a1 1 0 0 1 1.4 0l1 1a1 1 0 0 1-1.4 1.4l-1-1a1 1 0 0 1 0-1.4zm10.4 10.4a1 1 0 0 1 1.4 0l1 1a1 1 0 0 1-1.4 1.4l-1-1a1 1 0 0 1 0-1.4zm2.4-10.4a1 1 0 0 1 0 1.4l-1 1A1 1 0 0 1 16 6.6l1-1a1 1 0 0 1 1.4 0zM8 16a1 1 0 0 1 0 1.4l-1 1A1 1 0 0 1 5.6 17l1-1a1 1 0 0 1 1.4 0z"/&gt;&lt;/svg&gt;&lt;span class="slot-name"&gt;Morning Slot&lt;/span&gt;&lt;span class="slot-time"&gt;8:00 AM - 11:00 AM&lt;/span&gt;' />
                            <asp:ListItem Value="Evening" Text='&lt;svg class="slot-icon slot-icon--moon" viewBox="0 0 24 24" aria-hidden="true"&gt;&lt;path d="M21 13.3A9 9 0 0 1 10.7 3 9 9 0 1 0 21 13.3z"/&gt;&lt;/svg&gt;&lt;span class="slot-name"&gt;Evening Slot&lt;/span&gt;&lt;span class="slot-time"&gt;4:00 PM - 7:00 PM&lt;/span&gt;' />
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rfvSlot" runat="server"
                            ControlToValidate="rblSlot"
                            Text="Select a delivery slot"
                            ErrorMessage=""
                            ValidationGroup="Checkout"
                            Display="Dynamic"
                            CssClass="field-error"
                            SetFocusOnError="true" />
                    </div>
                </section>

                <%-- ================= Payment method ================= --%>
                <section class="co-card">
                    <h2 class="co-card-title">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M3 5h18a1 1 0 0 1 1 1v2H2V6a1 1 0 0 1 1-1zM2 10h20v8a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-8zm3 5v2h5v-2H5z" /></svg>
                        Payment Method
                    </h2>

                    <div class="pay-option">
                        <svg class="pay-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 6h11v9H3V6zm12 3h3.3l2.7 3v3h-6V9zM6.5 20a1.8 1.8 0 1 0 0-3.5 1.8 1.8 0 0 0 0 3.5zm11 0a1.8 1.8 0 1 0 0-3.5 1.8 1.8 0 0 0 0 3.5z" /></svg>
                        <span class="pay-name">Cash on Delivery</span>
                        <span class="pay-radio">
                            <asp:RadioButton ID="rbCOD" runat="server" GroupName="Pay" Checked="true" Text="" />
                            <label for="<%= rbCOD.ClientID %>">Cash on Delivery</label>
                        </span>
                    </div>
                </section>

            </div>

            <%-- ================= Order summary ================= --%>
            <aside class="co-summary">
                <div class="co-card">
                    <h2 class="co-card-title">Order Summary</h2>

                    <div class="sum-item">
                        <span class="sum-item-name">Farm Fresh Tomatoes (500g) x 2</span>
                        <span class="sum-item-amount">&#8377;80</span>
                    </div>
                    <div class="sum-item">
                        <span class="sum-item-name">Organic Spinach (1 Bunch) x 1</span>
                        <span class="sum-item-amount">&#8377;45</span>
                    </div>
                    <div class="sum-item">
                        <span class="sum-item-name">Local Potatoes (1kg) x 1</span>
                        <span class="sum-item-amount">&#8377;60</span>
                    </div>

                    <hr class="sum-divider" />

                    <div class="sum-row">
                        <span>Subtotal</span>
                        <strong>&#8377;185.00</strong>
                    </div>
                    <div class="sum-row">
                        <span>Delivery Charge</span>
                        <strong>&#8377;20.00</strong>
                    </div>
                    <div class="sum-row sum-row--discount">
                        <span>Discount (Promo)</span>
                        <strong>- &#8377;15.00</strong>
                    </div>

                    <hr class="sum-divider" />

                    <div class="sum-total">
                        <span class="sum-total-label">Total</span>
                        <span class="sum-total-amount">&#8377;190.00</span>
                    </div>

                    <asp:ValidationSummary ID="vsCheckout" runat="server"
                        ValidationGroup="Checkout"
                        DisplayMode="SingleParagraph"
                        HeaderText="Please complete the highlighted fields"
                        ShowMessageBox="false"
                        CssClass="summary-error" />

                    <asp:Button ID="btnPlaceOrder" runat="server"
                        Text="Place Order &#8594;"
                        CssClass="place-btn"
                        ValidationGroup="Checkout"
                        PostBackUrl="~/OrderConfirmation.aspx" />

                    <p class="sum-secure">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 1a5 5 0 0 0-5 5v3H5v13h14V9h-2V6a5 5 0 0 0-5-5zm0 2a3 3 0 0 1 3 3v3H9V6a3 3 0 0 1 3-3z" /></svg>
                        Secure Payment Guarantee
                    </p>
                </div>
            </aside>

        </div>
    </div>

</asp:Content>
