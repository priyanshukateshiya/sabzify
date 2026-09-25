<%@ Page Title="Edit Product" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="sabzify.Admin.EditProduct" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="EditProductTitle" ContentPlaceHolderID="TitleContent" runat="server">Edit Product</asp:Content>

<asp:Content ID="EditProductHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .editprod-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        /* Header bar ----------------------------------------------------------- */
        .editprod-page .ep-bar {
            margin-bottom: 24px;
            padding-bottom: 14px;
            border-bottom: 1px solid #E8EDF2;
        }

        .editprod-page .ep-crumb {
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0 0 6px;
            font-size: 10px;
            color: #6B7280;
        }

        .editprod-page .ep-crumb a {
            color: #6B7280;
            text-decoration: none;
        }

        .editprod-page .ep-crumb a:hover,
        .editprod-page .ep-crumb a:focus {
            color: #1B7A3A;
            text-decoration: underline;
        }

        .editprod-page .ep-crumb-current {
            color: #111827;
        }

        .editprod-page .ep-bar-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
        }

        .editprod-page .ep-title {
            margin: 0 0 4px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .editprod-page .ep-sub {
            margin: 0;
            font-size: 11.5px;
            color: #6B7280;
        }

        .editprod-page .ep-actions {
            display: flex;
            align-items: center;
            flex: none;
            gap: 10px;
        }

        .editprod-page .btn-cancel {
            height: 30px;
            padding: 0 16px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 11.5px;
            color: #374151;
            cursor: pointer;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .editprod-page .btn-cancel:hover,
        .editprod-page .btn-cancel:focus {
            border-color: #1B7A3A;
            background: #F7FAF6;
        }

        /* asp:Button renders an <input>, which cannot hold an SVG, so the icon
           sits on top of it inside this wrapper. */
        .editprod-page .save-wrap {
            position: relative;
            display: inline-flex;
        }

        .editprod-page .save-wrap svg {
            position: absolute;
            top: 50%;
            left: 16px;
            width: 12px;
            height: 12px;
            transform: translateY(-50%);
            color: #fff;
            pointer-events: none;
        }

        .editprod-page .btn-save {
            height: 30px;
            padding: 0 16px 0 34px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .editprod-page .btn-save:hover,
        .editprod-page .btn-save:focus {
            background: #166A32;
        }

        /* Body card ------------------------------------------------------------ */
        .editprod-page .ep-card {
            padding: 26px;
            border: 1px solid #EDF1F5;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .editprod-page .summary-error {
            margin: 0 0 16px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
        }

        .editprod-page .summary-error:empty {
            display: none;
        }

        .editprod-page .ep-cols {
            display: flex;
            align-items: flex-start;
            gap: 32px;
        }

        .editprod-page .ep-general {
            flex: 1;
            min-width: 0;
        }

        .editprod-page .ep-org {
            flex: 0 0 280px;
            width: 280px;
            min-width: 0;
            padding-left: 32px;
            border-left: 1px solid #F1F3EF;
            align-self: stretch;
        }

        .editprod-page .ep-section-title {
            margin: 0 0 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #E8EDF2;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        /* Fields --------------------------------------------------------------- */
        .editprod-page .field {
            min-width: 0;
            margin-bottom: 18px;
        }

        .editprod-page .field > label,
        .editprod-page .ep-label {
            display: block;
            margin-bottom: 6px;
            font-size: 11px;
            font-weight: 600;
            color: #374151;
        }

        .editprod-page .req {
            color: #C0392B;
        }

        .editprod-page .field input[type="text"],
        .editprod-page .field textarea,
        .editprod-page .field select {
            display: block;
            width: 100%;
            margin: 0;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 12.5px;
            color: #111827;
            outline: none;
            box-sizing: border-box;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .editprod-page .field input[type="text"],
        .editprod-page .field select {
            height: 38px;
            padding: 0 12px;
        }

        .editprod-page .field textarea {
            min-height: 84px;
            padding: 10px 12px;
            line-height: 1.5;
            resize: vertical;
        }

        .editprod-page .field input[type="text"]:focus,
        .editprod-page .field textarea:focus,
        .editprod-page .field select:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Dropdowns with their own chevron. */
        .editprod-page .select-wrap {
            position: relative;
        }

        .editprod-page .field select {
            padding-right: 32px;
            -webkit-appearance: none;
            appearance: none;
            cursor: pointer;
        }

        .editprod-page .select-wrap svg {
            position: absolute;
            top: 50%;
            right: 11px;
            width: 14px;
            height: 14px;
            transform: translateY(-50%);
            color: #374151;
            pointer-events: none;
        }

        /* Rupee prefix inside the price input. */
        .editprod-page .price-wrap {
            position: relative;
        }

        .editprod-page .price-wrap .price-symbol {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            font-size: 12.5px;
            color: #6B7280;
            pointer-events: none;
        }

        .editprod-page .field .price-wrap input[type="text"] {
            padding-left: 28px;
        }

        /* Price / Unit / Stock: equal columns; each error stays under its own box. */
        .editprod-page .ep-row3 {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            align-items: start;
            gap: 14px;
        }

        /* Validators use Display="Dynamic": no space until shown, always under
           their own control. */
        .editprod-page .field-error {
            display: block;
            margin-top: 4px;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        /* "abc" fails both the price pattern and the range; show only the pattern
           message so the field doesn't list two errors for one mistake. */
        .editprod-page .field:has(.price-format:not([style*="display:none"]):not([style*="display: none"])) .price-range {
            display: none !important;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variants are more specific than the plain :focus rules, so the
           green ring cannot override the red border. */
        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"],
        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea,
        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) select {
            border-color: #C0392B;
        }

        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus,
        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea:focus,
        .editprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) select:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        /* Product Status option cards: asp:RadioButton renders <input><label>;
           the input is visually hidden and the label is the card. */
        .editprod-page .status-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .editprod-page .status-opt {
            position: relative;
            display: block;
        }

        .editprod-page .status-opt input {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            opacity: 0;
            pointer-events: none;
        }

        .editprod-page .status-opt label {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 12px 14px;
            border: 1px solid #E1E6EA;
            border-radius: 8px;
            background: #fff;
            cursor: pointer;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .editprod-page .status-opt label::before {
            content: "";
            flex: none;
            width: 14px;
            height: 14px;
            margin-top: 1px;
            border: 1.5px solid #9CA3AF;
            border-radius: 50%;
            background: #fff;
            box-sizing: border-box;
        }

        .editprod-page .status-opt label:hover {
            border-color: #A7CDB1;
        }

        .editprod-page .status-opt input:checked + label {
            border-color: #1B7A3A;
            background: #EAF3EA;
        }

        .editprod-page .status-opt input:checked + label::before {
            border-color: #1B7A3A;
            background: #1B7A3A;
            box-shadow: inset 0 0 0 2.5px #fff;
        }

        .editprod-page .status-opt input:focus-visible + label {
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .18);
        }

        .editprod-page .opt-text {
            display: block;
        }

        .editprod-page .opt-title {
            display: block;
            font-size: 11.5px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .editprod-page .opt-desc {
            display: block;
            margin-top: 3px;
            font-size: 10px;
            line-height: 1.5;
            color: #6B7280;
        }

        @media screen and (max-width: 1100px) {
            .editprod-page .ep-cols {
                flex-direction: column;
                align-items: stretch;
                gap: 8px;
            }

            .editprod-page .ep-org {
                flex: none;
                width: auto;
                padding-top: 24px;
                padding-left: 0;
                border-top: 1px solid #F1F3EF;
                border-left: 0;
            }
        }

        @media screen and (max-width: 900px) {
            .editprod-page .ep-bar-row {
                flex-direction: column;
                gap: 12px;
            }
        }

        @media screen and (max-width: 700px) {
            .editprod-page .ep-row3 {
                grid-template-columns: minmax(0, 1fr);
                gap: 0;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .editprod-page) {
                padding: 18px 14px;
            }

            .editprod-page .ep-card {
                padding: 20px 16px;
            }

            .editprod-page .ep-actions {
                flex-direction: column-reverse;
                align-items: stretch;
                width: 100%;
                gap: 8px;
            }

            .editprod-page .save-wrap,
            .editprod-page .btn-save,
            .editprod-page .btn-cancel {
                width: 100%;
                height: 34px;
            }

            .editprod-page .save-wrap svg {
                left: calc(50% - 56px);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="EditProductBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="editprod-page">

        <div class="ep-bar">
            <p class="ep-crumb">
                <a href="Products.aspx">Products</a>
                <span aria-hidden="true">&#8250;</span>
                <span class="ep-crumb-current">Edit Product</span>
            </p>
            <div class="ep-bar-row">
                <div>
                    <h1 class="ep-title">Edit Product</h1>
                    <p class="ep-sub">Update details for 'Fresh Tomato' in the Rajkot inventory.</p>
                </div>
                <div class="ep-actions">
                    <%-- UseSubmitBehavior="false" renders type="button", so pressing Enter
                         in a field submits Update Product, never Cancel. --%>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel"
                        CausesValidation="false" UseSubmitBehavior="false"
                        PostBackUrl="~/Admin/Products.aspx" />
                    <span class="save-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z" /><polyline points="17 21 17 13 7 13 7 21" /><polyline points="7 3 7 8 15 8" />
                        </svg>
                        <asp:Button ID="btnSaveProduct" runat="server" Text="Update Product" CssClass="btn-save"
                            ValidationGroup="Product" />
                    </span>
                </div>
            </div>
        </div>

        <div class="ep-card">

            <%-- Validators carry Text only (no ErrorMessage), so the summary shows
                 just this header line once. --%>
            <asp:ValidationSummary ID="vsProduct" runat="server" ValidationGroup="Product"
                DisplayMode="SingleParagraph" HeaderText="Please complete the highlighted fields"
                ShowMessageBox="false" CssClass="summary-error" />

            <div class="ep-cols">

                <section class="ep-general">
                    <h2 class="ep-section-title">General Information</h2>

                    <div class="field">
                        <asp:Label ID="lblProductName" runat="server" AssociatedControlID="txtProductName" Text="Product Name <span class='req'>*</span>" />
                        <asp:TextBox ID="txtProductName" runat="server" Text="Fresh Tomato" autocomplete="off" />
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName"
                            Text="Product name is required" ValidationGroup="Product" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revProductName" runat="server" ControlToValidate="txtProductName"
                            ValidationExpression="^(?=.{2,60}$)(?!.*\s{2})[A-Za-z0-9(][A-Za-z0-9 &()\-]*[A-Za-z0-9)]$"
                            Text="Use letters, numbers, spaces and - &amp; ( ) only" ValidationGroup="Product" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="field">
                        <asp:Label ID="lblDescription" runat="server" AssociatedControlID="txtDescription" Text="Description" />
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"
                            Text="Locally sourced, farm-fresh red tomatoes from Rajkot farms. Ideal for curries, salads, and everyday cooking." />
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                            Text="Description is required" ValidationGroup="Product" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revDescription" runat="server" ControlToValidate="txtDescription"
                            ValidationExpression="^[\s\S]{10,300}$"
                            Text="Description must be 10&#8211;300 characters" ValidationGroup="Product" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="ep-row3">
                        <div class="field">
                            <asp:Label ID="lblPrice" runat="server" AssociatedControlID="txtPrice" Text="Price per Unit <span class='req'>*</span>" />
                            <div class="price-wrap">
                                <span class="price-symbol" aria-hidden="true">&#8377;</span>
                                <asp:TextBox ID="txtPrice" runat="server" Text="40" inputmode="decimal" autocomplete="off" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                                Text="Price is required" ValidationGroup="Product" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice"
                                ValidationExpression="^\d{1,5}(\.\d{1,2})?$"
                                Text="Enter a valid price" ValidationGroup="Product" Display="Dynamic"
                                CssClass="field-error price-format" SetFocusOnError="true" />
                            <asp:RangeValidator ID="rvPrice" runat="server" ControlToValidate="txtPrice"
                                Type="Double" MinimumValue="1" MaximumValue="99999"
                                Text="Price must be between 1 and 99999" ValidationGroup="Product" Display="Dynamic"
                                CssClass="field-error price-range" SetFocusOnError="true" />
                        </div>

                        <%-- No RequiredFieldValidator: the list has no blank item. --%>
                        <div class="field">
                            <asp:Label ID="lblUnit" runat="server" AssociatedControlID="ddlUnit" Text="Unit <span class='req'>*</span>" />
                            <div class="select-wrap">
                                <asp:DropDownList ID="ddlUnit" runat="server">
                                    <asp:ListItem Text="Kilogram (kg)" Value="kg" Selected="True" />
                                    <asp:ListItem Text="Gram (g)" Value="g" />
                                    <asp:ListItem Text="Bunch" Value="bunch" />
                                    <asp:ListItem Text="Piece" Value="piece" />
                                    <asp:ListItem Text="Litre (l)" Value="l" />
                                </asp:DropDownList>
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9" /></svg>
                            </div>
                        </div>

                        <div class="field">
                            <asp:Label ID="lblStock" runat="server" AssociatedControlID="txtStock" Text="Stock Quantity <span class='req'>*</span>" />
                            <asp:TextBox ID="txtStock" runat="server" Text="150" inputmode="numeric" autocomplete="off" />
                            <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock"
                                Text="Stock quantity is required" ValidationGroup="Product" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RangeValidator ID="rvStock" runat="server" ControlToValidate="txtStock"
                                Type="Integer" MinimumValue="0" MaximumValue="99999"
                                Text="Enter a quantity between 0 and 99999" ValidationGroup="Product" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                        </div>
                    </div>
                </section>

                <section class="ep-org">
                    <h2 class="ep-section-title">Organization</h2>

                    <%-- No RequiredFieldValidator: the list has no blank item. --%>
                    <div class="field">
                        <asp:Label ID="lblCategory" runat="server" AssociatedControlID="ddlCategory" Text="Category <span class='req'>*</span>" />
                        <div class="select-wrap">
                            <asp:DropDownList ID="ddlCategory" runat="server">
                                <asp:ListItem Text="Vegetables" Value="Vegetables" Selected="True" />
                                <asp:ListItem Text="Leafy Greens" Value="Leafy Greens" />
                                <asp:ListItem Text="Root Vegetables" Value="Root Vegetables" />
                                <asp:ListItem Text="Organic" Value="Organic" />
                                <asp:ListItem Text="Seasonal" Value="Seasonal" />
                            </asp:DropDownList>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9" /></svg>
                        </div>
                    </div>

                    <div class="field" role="radiogroup" aria-labelledby="lblProductStatus">
                        <span class="ep-label" id="lblProductStatus">Product Status</span>
                        <div class="status-options">
                            <asp:RadioButton ID="rbStatusActive" runat="server" GroupName="ProdStatus" Checked="true" CssClass="status-opt"
                                Text="<span class='opt-text'><span class='opt-title'>Active</span><span class='opt-desc'>Product is visible and available for purchase.</span></span>" />
                            <asp:RadioButton ID="rbStatusDraft" runat="server" GroupName="ProdStatus" CssClass="status-opt"
                                Text="<span class='opt-text'><span class='opt-title'>Draft</span><span class='opt-desc'>Product is hidden from customers.</span></span>" />
                        </div>
                    </div>
                </section>

            </div>
        </div>

    </div>

    <%-- UI only: this page belongs to the Products section, so highlight that
         sidebar item (the master's path match finds no "EditProduct" link). --%>
    <script>
        (function () {
            var link = document.querySelector('.admin-shell .adm-nav a[href="Products.aspx"]');
            if (link) {
                link.classList.add('is-active');
                link.setAttribute('aria-current', 'page');
            }
        })();
    </script>
</asp:Content>
