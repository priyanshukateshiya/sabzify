<%@ Page Title="Add New Product" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="sabzify.Admin.AddProduct" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="AddProductTitle" ContentPlaceHolderID="TitleContent" runat="server">Add New Product</asp:Content>

<asp:Content ID="AddProductHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .addprod-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        /* Header bar ----------------------------------------------------------- */
        .addprod-page .ap-bar {
            margin-bottom: 22px;
            padding-bottom: 14px;
            border-bottom: 1px solid #E8EDF2;
        }

        .addprod-page .ap-crumb {
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0 0 6px;
            font-size: 10px;
            color: #6B7280;
        }

        .addprod-page .ap-crumb a {
            color: #6B7280;
            text-decoration: none;
        }

        .addprod-page .ap-crumb a:hover,
        .addprod-page .ap-crumb a:focus {
            color: #1B7A3A;
            text-decoration: underline;
        }

        .addprod-page .ap-crumb-current {
            color: #111827;
        }

        .addprod-page .ap-bar-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
        }

        .addprod-page .ap-title {
            margin: 0 0 4px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .addprod-page .ap-sub {
            margin: 0;
            font-size: 11px;
            color: #6B7280;
        }

        .addprod-page .ap-actions {
            display: flex;
            align-items: center;
            flex: none;
            gap: 10px;
        }

        .addprod-page .btn-cancel {
            height: 28px;
            padding: 0 16px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 11px;
            color: #374151;
            cursor: pointer;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .addprod-page .btn-cancel:hover,
        .addprod-page .btn-cancel:focus {
            border-color: #1B7A3A;
            background: #F7FAF6;
        }

        /* asp:Button renders an <input>, which cannot hold an SVG, so the icon
           sits on top of it inside this wrapper. */
        .addprod-page .save-wrap {
            position: relative;
            display: inline-flex;
        }

        .addprod-page .save-wrap svg {
            position: absolute;
            top: 50%;
            left: 16px;
            width: 12px;
            height: 12px;
            transform: translateY(-50%);
            color: #fff;
            pointer-events: none;
        }

        .addprod-page .btn-save {
            height: 28px;
            padding: 0 16px 0 34px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .addprod-page .btn-save:hover,
        .addprod-page .btn-save:focus {
            background: #166A32;
        }

        .addprod-page .summary-error {
            margin: -8px 0 14px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
        }

        .addprod-page .summary-error:empty {
            display: none;
        }

        /* Body ----------------------------------------------------------------- */
        .addprod-page .ap-cols {
            display: flex;
            align-items: flex-start;
            gap: 18px;
        }

        .addprod-page .ap-main {
            flex: 1;
            min-width: 0;
        }

        .addprod-page .ap-side {
            flex: 0 0 250px;
            width: 250px;
            min-width: 0;
        }

        .addprod-page .ap-card {
            margin-bottom: 18px;
            padding: 18px;
            border: 1px solid #EDF1F5;
            border-radius: 8px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .addprod-page .ap-section-title {
            margin: 0 0 16px;
            padding-bottom: 11px;
            border-bottom: 1px solid #E8EDF2;
            font-size: 13px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        /* Fields --------------------------------------------------------------- */
        .addprod-page .field {
            min-width: 0;
            margin-bottom: 15px;
        }

        .addprod-page .field:last-child {
            margin-bottom: 0;
        }

        .addprod-page .field > label,
        .addprod-page .ap-label {
            display: block;
            margin-bottom: 5px;
            font-size: 10.5px;
            font-weight: 600;
            color: #374151;
        }

        .addprod-page .req {
            color: #C0392B;
        }

        .addprod-page .field input[type="text"],
        .addprod-page .field textarea,
        .addprod-page .field select {
            display: block;
            width: 100%;
            margin: 0;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 11.5px;
            color: #111827;
            outline: none;
            box-sizing: border-box;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .addprod-page .field input[type="text"],
        .addprod-page .field select {
            height: 34px;
            padding: 0 11px;
        }

        .addprod-page .field textarea {
            min-height: 72px;
            padding: 9px 11px;
            line-height: 1.5;
            resize: vertical;
        }

        .addprod-page .field input[type="text"]::placeholder,
        .addprod-page .field textarea::placeholder {
            color: #9CA3AF;
        }

        .addprod-page .field input[type="text"]:focus,
        .addprod-page .field textarea:focus,
        .addprod-page .field select:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Dropdowns with their own chevron. */
        .addprod-page .select-wrap {
            position: relative;
        }

        .addprod-page .field select {
            padding-right: 30px;
            -webkit-appearance: none;
            appearance: none;
            cursor: pointer;
        }

        .addprod-page .select-wrap svg {
            position: absolute;
            top: 50%;
            right: 10px;
            width: 13px;
            height: 13px;
            transform: translateY(-50%);
            color: #374151;
            pointer-events: none;
        }

        /* Rupee prefix inside the price input. */
        .addprod-page .price-wrap {
            position: relative;
        }

        .addprod-page .price-wrap .price-symbol {
            position: absolute;
            top: 50%;
            left: 11px;
            transform: translateY(-50%);
            font-size: 11.5px;
            color: #6B7280;
            pointer-events: none;
        }

        .addprod-page .field .price-wrap input[type="text"] {
            padding-left: 26px;
        }

        /* Price / Unit: equal columns; each error stays under its own box. */
        .addprod-page .ap-row2 {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            align-items: start;
            gap: 14px;
            margin-bottom: 15px;
        }

        .addprod-page .ap-row2 .field {
            margin-bottom: 0;
        }

        /* Validators use Display="Dynamic": no space until shown, always under
           their own control. */
        .addprod-page .field-error {
            display: block;
            margin-top: 4px;
            font-size: 10.5px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        /* "abc" fails both the price pattern and the range; show only the pattern
           message so the field doesn't list two errors for one mistake. */
        .addprod-page .field:has(.price-format:not([style*="display:none"]):not([style*="display: none"])) .price-range {
            display: none !important;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variants are more specific than the plain :focus rules, so the
           green ring cannot override the red border. */
        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"],
        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea,
        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) select {
            border-color: #C0392B;
        }

        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus,
        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea:focus,
        .addprod-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) select:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        /* Product images drop zone --------------------------------------------- */
        .addprod-page .drop-zone {
            padding: 20px;
            border: 1px solid #E8EDF2;
            border-radius: 8px;
            background: #F7F9FA;
            text-align: center;
        }

        .addprod-page .drop-box {
            display: block;
            width: 100%;
            max-width: 200px;
            margin: 0 auto;
            padding: 34px 20px;
            border: 2px dashed #C9D3CE;
            border-radius: 8px;
            background: #F1F3F4;
            font-family: inherit;
            cursor: pointer;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .addprod-page .drop-box:hover,
        .addprod-page .drop-box:focus-visible {
            border-color: #9DB8A6;
            outline: none;
        }

        .addprod-page .drop-box.is-dragover {
            border-color: #1B7A3A;
            background: #EAF3EA;
        }

        .addprod-page .drop-box svg {
            display: block;
            width: 30px;
            height: 30px;
            margin: 0 auto;
            color: #9CA3AF;
        }

        .addprod-page .drop-title {
            display: block;
            margin-top: 10px;
            font-size: 10.5px;
            font-weight: 600;
            color: #374151;
        }

        .addprod-page .drop-hint {
            display: block;
            margin-top: 3px;
            font-size: 9px;
            color: #9CA3AF;
        }

        .addprod-page .drop-caption {
            margin: 14px 0 0;
            font-size: 10px;
            color: #6B7280;
        }

        /* The real file input is visually hidden; the dashed box opens it. */
        .addprod-page .file-input {
            position: absolute;
            width: 1px;
            height: 1px;
            overflow: hidden;
            clip: rect(0 0 0 0);
            white-space: nowrap;
        }

        .addprod-page .file-chips {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 6px;
            margin-top: 12px;
        }

        .addprod-page .file-chips:empty {
            display: none;
        }

        .addprod-page .file-chip {
            max-width: 100%;
            overflow: hidden;
            padding: 3px 9px;
            border: 1px solid #E1E6EA;
            border-radius: 999px;
            background: #fff;
            font-size: 10px;
            color: #6B7280;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* Product Status rows: asp:RadioButton renders <input><label>; the input
           is visually hidden and the label is the row, with the dot on the right. */
        .addprod-page .status-options {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .addprod-page .status-opt {
            position: relative;
            display: block;
        }

        .addprod-page .status-opt input {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            opacity: 0;
            pointer-events: none;
        }

        .addprod-page .status-opt label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: 9px 11px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-size: 11px;
            line-height: 1.3;
            color: #111827;
            cursor: pointer;
            transition: border-color .15s ease, background-color .15s ease;
        }

        .addprod-page .status-opt label::after {
            content: "";
            flex: none;
            width: 13px;
            height: 13px;
            border: 1.5px solid #C4CAD1;
            border-radius: 50%;
            background: #fff;
            box-sizing: border-box;
        }

        .addprod-page .status-opt label:hover {
            border-color: #A7CDB1;
        }

        .addprod-page .status-opt input:checked + label {
            border-color: #1B7A3A;
            background: #EAF3EA;
            font-weight: 600;
        }

        .addprod-page .status-opt input:checked + label::after {
            border-color: #1B7A3A;
            background: #1B7A3A;
            box-shadow: inset 0 0 0 2.5px #EAF3EA;
        }

        .addprod-page .status-opt input:focus-visible + label {
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .18);
        }

        @media screen and (max-width: 1100px) {
            .addprod-page .ap-cols {
                flex-direction: column;
                align-items: stretch;
                gap: 0;
            }

            .addprod-page .ap-side {
                flex: none;
                width: auto;
            }
        }

        @media screen and (max-width: 900px) {
            .addprod-page .ap-bar-row {
                flex-direction: column;
                gap: 12px;
            }
        }

        @media screen and (max-width: 600px) {
            .admin-shell .adm-main:has(> .addprod-page) {
                padding: 18px 14px;
            }

            .addprod-page .ap-row2 {
                grid-template-columns: minmax(0, 1fr);
                gap: 15px;
            }

            .addprod-page .ap-actions {
                flex-direction: column-reverse;
                align-items: stretch;
                width: 100%;
                gap: 8px;
            }

            .addprod-page .save-wrap,
            .addprod-page .btn-save,
            .addprod-page .btn-cancel {
                width: 100%;
                height: 34px;
            }

            .addprod-page .save-wrap svg {
                left: calc(50% - 50px);
            }

            .addprod-page .drop-zone {
                padding: 12px;
            }

            .addprod-page .drop-box {
                padding: 24px 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="AddProductBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="addprod-page">

        <div class="ap-bar">
            <p class="ap-crumb">
                <a href="Products.aspx">Products</a>
                <span aria-hidden="true">&#8250;</span>
                <span class="ap-crumb-current">Add New Product</span>
            </p>
            <div class="ap-bar-row">
                <div>
                    <h1 class="ap-title">Add New Product</h1>
                    <p class="ap-sub">Create a new entry in the Rajkot inventory catalog.</p>
                </div>
                <div class="ap-actions">
                    <%-- UseSubmitBehavior="false" renders type="button", so pressing Enter
                         in a field submits Save Product, never Cancel. --%>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel"
                        CausesValidation="false" UseSubmitBehavior="false"
                        PostBackUrl="~/Admin/Products.aspx" />
                    <span class="save-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z" /><polyline points="17 21 17 13 7 13 7 21" /><polyline points="7 3 7 8 15 8" />
                        </svg>
                        <asp:Button ID="btnSaveProduct" runat="server" Text="Save Product" CssClass="btn-save"
                            ValidationGroup="AddProduct" />
                    </span>
                </div>
            </div>
        </div>

        <%-- Validators carry Text only (no ErrorMessage), so the summary shows
             just this header line once. --%>
        <asp:ValidationSummary ID="vsAddProduct" runat="server" ValidationGroup="AddProduct"
            DisplayMode="SingleParagraph" HeaderText="Please complete the highlighted fields"
            ShowMessageBox="false" CssClass="summary-error" />

        <div class="ap-cols">

            <div class="ap-main">

                <section class="ap-card">
                    <h2 class="ap-section-title">General Information</h2>

                    <div class="field">
                        <asp:Label ID="lblProductName" runat="server" AssociatedControlID="txtProductName" Text="Product Name <span class='req'>*</span>" />
                        <asp:TextBox ID="txtProductName" runat="server" placeholder="e.g., Fresh Organic Tomatoes" autocomplete="off" />
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName"
                            Text="Product name is required" ValidationGroup="AddProduct" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revProductName" runat="server" ControlToValidate="txtProductName"
                            ValidationExpression="^(?=.{2,60}$)(?!.*\s{2})[A-Za-z0-9(][A-Za-z0-9 &()\-]*[A-Za-z0-9)]$"
                            Text="Use letters, numbers, spaces and - &amp; ( ) only" ValidationGroup="AddProduct" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <%-- Optional: no RequiredFieldValidator; the length check passes when empty. --%>
                    <div class="field">
                        <asp:Label ID="lblDescription" runat="server" AssociatedControlID="txtDescription" Text="Description" />
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"
                            placeholder="Provide a detailed description of the vegetable, origin, and freshness..." />
                        <asp:RegularExpressionValidator ID="revDescription" runat="server" ControlToValidate="txtDescription"
                            ValidationExpression="^[\s\S]{0,300}$"
                            Text="Description must be 300 characters or fewer" ValidationGroup="AddProduct" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>
                </section>

                <section class="ap-card">
                    <h2 class="ap-section-title">Product Images</h2>

                    <div class="drop-zone">
                        <button type="button" class="drop-box" id="dropBox" aria-describedby="dropCaption">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M14.5 20H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h3l2-3h6l2 3h3a2 2 0 0 1 2 2v4.5" /><circle cx="12" cy="12.5" r="3.5" /><line x1="19" y1="16" x2="19" y2="22" /><line x1="16" y1="19" x2="22" y2="19" />
                            </svg>
                            <span class="drop-title">Click to upload product image</span>
                            <span class="drop-hint">Drag &amp; drop or browse</span>
                        </button>
                        <p class="drop-caption" id="dropCaption">Drag &amp; drop or click to upload product photos</p>
                        <asp:FileUpload ID="fuImage" runat="server" AllowMultiple="true" CssClass="file-input" TabIndex="-1" aria-hidden="true" />
                        <div class="file-chips" id="fileChips" aria-live="polite"></div>
                    </div>
                </section>

                <section class="ap-card">
                    <h2 class="ap-section-title">Inventory &amp; Pricing</h2>

                    <div class="ap-row2">
                        <div class="field">
                            <asp:Label ID="lblPrice" runat="server" AssociatedControlID="txtPrice" Text="Price per Unit <span class='req'>*</span>" />
                            <div class="price-wrap">
                                <span class="price-symbol" aria-hidden="true">&#8377;</span>
                                <asp:TextBox ID="txtPrice" runat="server" placeholder="0.00" inputmode="decimal" autocomplete="off" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                                Text="Price is required" ValidationGroup="AddProduct" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice"
                                ValidationExpression="^\d{1,5}(\.\d{1,2})?$"
                                Text="Enter a valid price" ValidationGroup="AddProduct" Display="Dynamic"
                                CssClass="field-error price-format" SetFocusOnError="true" />
                            <asp:RangeValidator ID="rvPrice" runat="server" ControlToValidate="txtPrice"
                                Type="Double" MinimumValue="1" MaximumValue="99999"
                                Text="Price must be between 1 and 99999" ValidationGroup="AddProduct" Display="Dynamic"
                                CssClass="field-error price-range" SetFocusOnError="true" />
                        </div>

                        <%-- No validator: a unit is always selected. --%>
                        <div class="field">
                            <asp:Label ID="lblUnit" runat="server" AssociatedControlID="ddlUnit" Text="Unit" />
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
                    </div>

                    <%-- Optional: no RequiredFieldValidator; the range check passes when empty. --%>
                    <div class="field">
                        <asp:Label ID="lblStock" runat="server" AssociatedControlID="txtStock" Text="Stock Quantity" />
                        <asp:TextBox ID="txtStock" runat="server" placeholder="Enter stock amount" inputmode="numeric" autocomplete="off" />
                        <asp:RangeValidator ID="rvStock" runat="server" ControlToValidate="txtStock"
                            Type="Integer" MinimumValue="0" MaximumValue="99999"
                            Text="Enter a quantity between 0 and 99999" ValidationGroup="AddProduct" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>
                </section>

            </div>

            <aside class="ap-side">
                <section class="ap-card">
                    <h2 class="ap-section-title">Organization</h2>

                    <div class="field">
                        <asp:Label ID="lblCategory" runat="server" AssociatedControlID="ddlCategory" Text="Category <span class='req'>*</span>" />
                        <div class="select-wrap">
                            <asp:DropDownList ID="ddlCategory" runat="server">
                                <asp:ListItem Text="Select Category" Value="" Selected="True" />
                                <asp:ListItem Text="Vegetables" Value="Vegetables" />
                                <asp:ListItem Text="Leafy Greens" Value="Leafy Greens" />
                                <asp:ListItem Text="Root Vegetables" Value="Root Vegetables" />
                                <asp:ListItem Text="Organic" Value="Organic" />
                                <asp:ListItem Text="Seasonal" Value="Seasonal" />
                            </asp:DropDownList>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9" /></svg>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" InitialValue=""
                            Text="Select a category" ValidationGroup="AddProduct" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="field" role="radiogroup" aria-labelledby="lblProductStatus">
                        <span class="ap-label" id="lblProductStatus">Product Status</span>
                        <div class="status-options">
                            <asp:RadioButton ID="rbStatusActive" runat="server" GroupName="ProdStatus" Checked="true" CssClass="status-opt" Text="Active" />
                            <asp:RadioButton ID="rbStatusDraft" runat="server" GroupName="ProdStatus" CssClass="status-opt" Text="Draft" />
                        </div>
                    </div>
                </section>
            </aside>

        </div>

    </div>

    <%-- UI only (no validation, no upload logic): highlights the Products nav item,
         opens the hidden file input from the dashed box, styles drag-over, and
         lists the chosen file names. --%>
    <script>
        (function () {
            var link = document.querySelector('.admin-shell .adm-nav a[href="Products.aspx"]');
            if (link) {
                link.classList.add('is-active');
                link.setAttribute('aria-current', 'page');
            }

            var box = document.getElementById('dropBox');
            var input = document.getElementById('<%= fuImage.ClientID %>');
            var chips = document.getElementById('fileChips');

            function listFiles(files) {
                chips.innerHTML = '';
                Array.prototype.forEach.call(files || [], function (file) {
                    var chip = document.createElement('span');
                    chip.className = 'file-chip';
                    chip.textContent = file.name;
                    chip.title = file.name;
                    chips.appendChild(chip);
                });
            }

            box.addEventListener('click', function () {
                input.click();
            });

            input.addEventListener('change', function () {
                listFiles(input.files);
            });

            ['dragenter', 'dragover'].forEach(function (type) {
                box.addEventListener(type, function (e) {
                    e.preventDefault();
                    box.classList.add('is-dragover');
                });
            });

            box.addEventListener('dragleave', function () {
                box.classList.remove('is-dragover');
            });

            box.addEventListener('drop', function (e) {
                e.preventDefault();
                box.classList.remove('is-dragover');
                if (e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files.length) {
                    try {
                        input.files = e.dataTransfer.files;
                    } catch (err) {
                        // Older browsers cannot assign files; the names still list below.
                    }
                    listFiles(e.dataTransfer.files);
                }
            });
        })();
    </script>
</asp:Content>
