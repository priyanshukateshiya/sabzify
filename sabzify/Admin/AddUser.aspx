<%@ Page Title="Add New User" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="sabzify.Admin.AddUser" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="AddUserTitle" ContentPlaceHolderID="TitleContent" runat="server">Add New User</asp:Content>

<asp:Content ID="AddUserHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .adduser-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        /* Header bar ----------------------------------------------------------- */
        .adduser-page .au-header {
            margin-bottom: 20px;
        }

        .adduser-page .au-crumbs {
            margin: 0 0 6px;
            font-size: 9.5px;
            line-height: 1.4;
            color: #6B7280;
        }

        .adduser-page .au-crumbs a {
            color: #6B7280;
            text-decoration: none;
        }

        .adduser-page .au-crumbs a:hover,
        .adduser-page .au-crumbs a:focus {
            color: #1B7A3A;
            text-decoration: underline;
        }

        .adduser-page .au-crumbs .sep {
            margin: 0 4px;
        }

        .adduser-page .au-crumbs .current {
            font-weight: 600;
            color: #111827;
        }

        .adduser-page .au-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
        }

        .adduser-page .au-title {
            margin: 0 0 4px;
            font-size: 20px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .adduser-page .au-sub {
            margin: 0;
            font-size: 10.5px;
            color: #6B7280;
        }

        .adduser-page .au-actions {
            display: flex;
            align-items: center;
            flex: none;
            gap: 8px;
        }

        .adduser-page .btn-cancel {
            height: 27px;
            padding: 0 15px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 10.5px;
            color: #374151;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .adduser-page .btn-cancel:hover,
        .adduser-page .btn-cancel:focus {
            background: #F1F5F2;
        }

        /* asp:Button renders an <input>, which cannot hold an SVG, so the icon
           sits on top of it inside this wrapper. */
        .adduser-page .create-wrap {
            position: relative;
            display: inline-flex;
        }

        .adduser-page .create-wrap svg {
            position: absolute;
            top: 50%;
            left: 15px;
            width: 11px;
            height: 11px;
            transform: translateY(-50%);
            color: #fff;
            pointer-events: none;
        }

        .adduser-page .btn-create {
            height: 27px;
            padding: 0 15px 0 31px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .adduser-page .btn-create:hover,
        .adduser-page .btn-create:focus {
            background: #166A32;
        }

        .adduser-page .summary-error {
            margin: -8px 0 14px;
            font-size: 10px;
            line-height: 1.4;
            color: #C0392B;
        }

        .adduser-page .summary-error:empty {
            display: none;
        }

        /* Body columns ----------------------------------------------------------- */
        .adduser-page .au-body {
            display: flex;
            align-items: flex-start;
            gap: 16px;
        }

        .adduser-page .au-main {
            flex: 1;
            min-width: 0;
        }

        .adduser-page .au-side {
            flex: 0 0 215px;
            width: 215px;
            min-width: 0;
        }

        .adduser-page .au-card {
            margin-bottom: 16px;
            padding: 16px;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .adduser-page .card-head {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 14px;
        }

        .adduser-page .card-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: none;
            width: 20px;
            height: 20px;
            border-radius: 5px;
            background: #E6F2E1;
            color: #1B7A3A;
        }

        .adduser-page .card-badge svg {
            width: 11px;
            height: 11px;
        }

        .adduser-page .card-title {
            margin: 0;
            font-size: 12px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        /* Fields ------------------------------------------------------------------ */
        .adduser-page .field-row {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
            gap: 0 12px;
            align-items: start;
        }

        .adduser-page .field {
            margin-bottom: 13px;
        }

        .adduser-page .field-half {
            width: calc(50% - 6px);
        }

        .adduser-page .field label {
            display: block;
            margin-bottom: 4px;
            font-size: 10px;
            font-weight: 600;
            line-height: 1.4;
            color: #374151;
        }

        .adduser-page .field .req {
            color: #C0392B;
        }

        .adduser-page .input-wrap {
            position: relative;
        }

        .adduser-page .input-wrap > svg {
            position: absolute;
            top: 50%;
            left: 10px;
            width: 12px;
            height: 12px;
            transform: translateY(-50%);
            color: #9CA3AF;
            pointer-events: none;
        }

        .adduser-page .input-wrap > svg.icon-right {
            left: auto;
            right: 10px;
        }

        .adduser-page .field input[type="text"],
        .adduser-page .field input[type="password"] {
            display: block;
            width: 100%;
            height: 32px;
            margin: 0;
            padding: 0 10px 0 30px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 10.5px;
            color: #111827;
            outline: none;
            box-sizing: border-box;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .adduser-page .field input::placeholder {
            color: #9CA3AF;
        }

        .adduser-page .field input[type="text"]:focus,
        .adduser-page .field input[type="password"]:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Mobile: static +91 box joined to the input, phone icon on the right. */
        .adduser-page .mobile-join {
            display: flex;
        }

        .adduser-page .mobile-prefix {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 0 0 26px;
            width: 26px;
            height: 32px;
            border: 1px solid #E1E6EA;
            border-right: 0;
            border-radius: 6px 0 0 6px;
            background: #F3F5F4;
            font-size: 10px;
            color: #6B7280;
            box-sizing: border-box;
        }

        .adduser-page .mobile-join .input-wrap {
            flex: 1;
            min-width: 0;
        }

        .adduser-page .field .mobile-join input[type="text"] {
            padding: 0 28px 0 9px;
            border-radius: 0 6px 6px 0;
        }

        /* Password: lock on the left, eye toggle on the right. */
        .adduser-page .field .pw-wrap input[type="text"],
        .adduser-page .field .pw-wrap input[type="password"] {
            padding-right: 32px;
        }

        .adduser-page .eye-btn {
            position: absolute;
            top: 50%;
            right: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 22px;
            height: 22px;
            padding: 0;
            border: 0;
            border-radius: 5px;
            background: transparent;
            color: #9CA3AF;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .adduser-page .eye-btn svg {
            width: 13px;
            height: 13px;
        }

        .adduser-page .eye-btn .eye-off,
        .adduser-page .eye-btn.is-on .eye-on {
            display: none;
        }

        .adduser-page .eye-btn.is-on .eye-off {
            display: block;
        }

        .adduser-page .eye-btn:hover,
        .adduser-page .eye-btn:focus,
        .adduser-page .eye-btn.is-on {
            color: #1B7A3A;
        }

        /* Validators use Display="Dynamic": no space until shown, and they sit
           after the input inside their own field, so they never break the rows,
           the +91 join or the column alignment. The client script shows them
           with an inline display:inline, so a visible one is forced to block. */
        .adduser-page .field-error {
            display: block;
            margin-top: 3px;
            font-size: 9.5px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        .adduser-page .field-error:not([style*="display:none"]):not([style*="display: none"]) {
            display: block !important;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variants are more specific than the plain :focus rule, so the
           green ring cannot override the red border. */
        .adduser-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"],
        .adduser-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="password"],
        .adduser-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .mobile-prefix {
            border-color: #C0392B;
        }

        .adduser-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus,
        .adduser-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="password"]:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        /* Account settings ---------------------------------------------------------- */
        .adduser-page .status-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 14px;
            padding: 10px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
        }

        .adduser-page .status-title {
            margin: 0;
            font-size: 10.5px;
            font-weight: 600;
            line-height: 1.3;
            color: #1B7A3A;
        }

        .adduser-page .status-sub {
            margin: 2px 0 0;
            font-size: 9px;
            line-height: 1.3;
            color: #6B7280;
        }

        /* Toggle: the real asp:CheckBox is visually hidden; its label is the
           switch, so clicking the switch toggles the checkbox natively. */
        .adduser-page .status-switch {
            position: relative;
            flex: none;
        }

        .adduser-page .status-switch input[type="checkbox"] {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            padding: 0;
            overflow: hidden;
            clip: rect(0 0 0 0);
            opacity: 0;
        }

        .adduser-page .switch {
            position: relative;
            display: block;
            width: 32px;
            height: 18px;
            border-radius: 999px;
            background: #D1D5DB;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .adduser-page .switch::after {
            content: "";
            position: absolute;
            top: 2px;
            left: 2px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #fff;
            box-shadow: 0 1px 2px rgba(17, 24, 39, .2);
            transition: transform .15s ease;
        }

        .adduser-page .status-switch input[type="checkbox"]:checked + .switch {
            background: #1B7A3A;
        }

        .adduser-page .status-switch input[type="checkbox"]:checked + .switch::after {
            transform: translateX(14px);
        }

        .adduser-page .status-switch input[type="checkbox"]:focus-visible + .switch {
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .2);
        }

        .adduser-page .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            overflow: hidden;
            clip: rect(0 0 0 0);
            white-space: nowrap;
        }

        .adduser-page .info-note {
            display: flex;
            align-items: flex-start;
            gap: 6px;
            margin-top: 12px;
            padding: 10px;
            border-radius: 6px;
            background: #EAF3F7;
            font-size: 9px;
            line-height: 1.5;
            color: #4B5563;
        }

        .adduser-page .info-note svg {
            flex: none;
            width: 11px;
            height: 11px;
            margin-top: 1px;
            color: #4B5563;
        }

        .adduser-page .info-note p {
            margin: 0;
        }

        @media screen and (max-width: 1100px) {
            .adduser-page .au-body {
                flex-direction: column;
                align-items: stretch;
                gap: 0;
            }

            .adduser-page .au-side {
                flex-basis: auto;
                width: 100%;
            }
        }

        @media screen and (max-width: 900px) {
            .adduser-page .au-row {
                flex-direction: column;
                gap: 12px;
            }
        }

        @media screen and (max-width: 600px) {
            .admin-shell .adm-main:has(> .adduser-page) {
                padding: 18px 14px;
            }

            .adduser-page .field-row {
                grid-template-columns: minmax(0, 1fr);
            }

            .adduser-page .field-half {
                width: 100%;
            }

            .adduser-page .au-actions {
                flex-direction: column;
                align-items: stretch;
                width: 100%;
            }

            .adduser-page .create-wrap,
            .adduser-page .btn-create,
            .adduser-page .btn-cancel {
                width: 100%;
            }

            .adduser-page .btn-cancel,
            .adduser-page .btn-create {
                height: 32px;
            }

            .adduser-page .create-wrap svg {
                left: calc(50% - 40px);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="AddUserBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="adduser-page">

        <div class="au-header">
            <p class="au-crumbs">
                <span>Admin</span><span class="sep">&#8250;</span><a href="Users.aspx">User Management</a><span class="sep">&#8250;</span><span class="current">Add New User</span>
            </p>
            <div class="au-row">
                <div>
                    <h1 class="au-title">Add New User</h1>
                    <p class="au-sub">Create a new customer profile manually in the Sabzify system.</p>
                </div>
                <div class="au-actions">
                    <%-- UseSubmitBehavior="false" renders type="button", so pressing Enter
                         in a field submits Create User, not Cancel. --%>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel"
                        CausesValidation="false" UseSubmitBehavior="false"
                        PostBackUrl="~/Admin/Users.aspx" />
                    <span class="create-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><line x1="19" y1="8" x2="19" y2="14" /><line x1="22" y1="11" x2="16" y2="11" />
                        </svg>
                        <asp:Button ID="btnCreateUser" runat="server" Text="Create User" CssClass="btn-create"
                            ValidationGroup="AddUser" />
                    </span>
                </div>
            </div>
        </div>

        <%-- Validators carry Text only (no ErrorMessage), so the summary shows
             just this header line once. --%>
        <asp:ValidationSummary ID="vsAddUser" runat="server" ValidationGroup="AddUser"
            DisplayMode="SingleParagraph" HeaderText="Please complete the highlighted fields"
            ShowMessageBox="false" CssClass="summary-error" />

        <div class="au-body">

            <div class="au-main">

                <%-- Personal Information --%>
                <div class="au-card">
                    <div class="card-head">
                        <span class="card-badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" />
                            </svg>
                        </span>
                        <h2 class="card-title">Personal Information</h2>
                    </div>

                    <div class="field-row">
                        <div class="field">
                            <asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName">Full Name <span class="req">*</span></asp:Label>
                            <div class="input-wrap">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" />
                                </svg>
                                <asp:TextBox ID="txtFullName" runat="server" placeholder="Jignesh Mer" autocomplete="off" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                                Text="Full name is required" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revFullName" runat="server" ControlToValidate="txtFullName"
                                ValidationExpression="^(?=.{2,100}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                                Text="Only letters and spaces" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                        </div>

                        <div class="field">
                            <asp:Label ID="lblMobile" runat="server" AssociatedControlID="txtMobile">Mobile Number <span class="req">*</span></asp:Label>
                            <div class="mobile-join">
                                <span class="mobile-prefix">+91</span>
                                <div class="input-wrap">
                                    <asp:TextBox ID="txtMobile" runat="server" placeholder="98765 43210" autocomplete="off" />
                                    <svg class="icon-right" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                        <rect x="5" y="2" width="14" height="20" rx="2" ry="2" /><line x1="12" y1="18" x2="12.01" y2="18" />
                                    </svg>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                                Text="Mobile number is required" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                                ValidationExpression="^[6-9]\d{4}[\s-]?\d{5}$"
                                Text="Enter a valid 10-digit mobile number" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                        </div>
                    </div>

                    <%-- Optional: no RequiredFieldValidator. The regex validator passes
                         on an empty box. --%>
                    <div class="field">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email Address (Optional)" />
                        <div class="input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" /><polyline points="22,6 12,13 2,6" />
                            </svg>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="jignesh@email.com" autocomplete="off" />
                        </div>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            Text="Enter a valid email" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>
                </div>

                <%-- Primary Address --%>
                <div class="au-card">
                    <div class="card-head">
                        <span class="card-badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" /><circle cx="12" cy="10" r="3" />
                            </svg>
                        </span>
                        <h2 class="card-title">Primary Address</h2>
                    </div>

                    <div class="field">
                        <asp:Label ID="lblStreet" runat="server" AssociatedControlID="txtStreet">Street Address / Society Name <span class="req">*</span></asp:Label>
                        <div class="input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" /><polyline points="9 22 9 12 15 12 15 22" />
                            </svg>
                            <asp:TextBox ID="txtStreet" runat="server" placeholder="e.g. 12, Om Nagar, University Road" autocomplete="off" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvStreet" runat="server" ControlToValidate="txtStreet"
                            Text="Street address is required" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revStreet" runat="server" ControlToValidate="txtStreet"
                            ValidationExpression="^.{5,150}$"
                            Text="Enter a complete address" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="field-row">
                        <div class="field">
                            <asp:Label ID="lblCity" runat="server" AssociatedControlID="txtCity">City <span class="req">*</span></asp:Label>
                            <div class="input-wrap">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="4" y="2" width="16" height="20" rx="2" ry="2" /><path d="M9 22v-4h6v4" /><path d="M8 6h.01M16 6h.01M12 6h.01M12 10h.01M12 14h.01M16 10h.01M16 14h.01M8 10h.01M8 14h.01" />
                                </svg>
                                <asp:TextBox ID="txtCity" runat="server" Text="Rajkot" autocomplete="off" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                Text="City is required" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtCity"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .-][A-Za-z]+)*$"
                                Text="Enter a valid city name" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                        </div>

                        <div class="field">
                            <asp:Label ID="lblState" runat="server" AssociatedControlID="txtState">State <span class="req">*</span></asp:Label>
                            <div class="input-wrap">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6" /><line x1="8" y1="2" x2="8" y2="18" /><line x1="16" y1="6" x2="16" y2="22" />
                                </svg>
                                <asp:TextBox ID="txtState" runat="server" Text="Gujarat" autocomplete="off" />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState"
                                Text="State is required" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revState" runat="server" ControlToValidate="txtState"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .-][A-Za-z]+)*$"
                                Text="Enter a valid state name" ValidationGroup="AddUser" Display="Dynamic"
                                CssClass="field-error" SetFocusOnError="true" />
                        </div>
                    </div>

                    <div class="field field-half">
                        <asp:Label ID="lblPincode" runat="server" AssociatedControlID="txtPincode">Pincode <span class="req">*</span></asp:Label>
                        <div class="input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" /><circle cx="12" cy="10" r="3" />
                            </svg>
                            <asp:TextBox ID="txtPincode" runat="server" placeholder="e.g. 360001" autocomplete="off" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPincode" runat="server" ControlToValidate="txtPincode"
                            Text="Pincode is required" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revPincode" runat="server" ControlToValidate="txtPincode"
                            ValidationExpression="^[1-9][0-9]{5}$"
                            Text="Enter a valid 6-digit pincode" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>
                </div>

            </div>

            <div class="au-side">

                <%-- Account Settings --%>
                <div class="au-card">
                    <div class="card-head">
                        <span class="card-badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
                            </svg>
                        </span>
                        <h2 class="card-title">Account Settings</h2>
                    </div>

                    <div class="status-box">
                        <div>
                            <p class="status-title">User Status</p>
                            <p class="status-sub">Allow user to log in</p>
                        </div>
                        <div class="status-switch">
                            <asp:CheckBox ID="chkStatus" runat="server" Checked="true" />
                            <asp:Label ID="lblStatus" runat="server" AssociatedControlID="chkStatus" CssClass="switch"><span class="sr-only">Allow user to log in</span></asp:Label>
                        </div>
                    </div>

                    <div class="field">
                        <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword">Set Password <span class="req">*</span></asp:Label>
                        <div class="input-wrap pw-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" autocomplete="new-password" />
                            <button type="button" class="eye-btn" data-target="<%= txtPassword.ClientID %>" aria-label="Show password" aria-pressed="false">
                                <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" /><circle cx="12" cy="12" r="3" /></svg>
                                <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" /><line x1="1" y1="1" x2="23" y2="23" /></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            Text="Password is required" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                            Text="Min 8 characters with uppercase, lowercase and a number" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="field">
                        <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword">Confirm Password <span class="req">*</span></asp:Label>
                        <div class="input-wrap pw-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" autocomplete="new-password" />
                            <button type="button" class="eye-btn" data-target="<%= txtConfirmPassword.ClientID %>" aria-label="Show password" aria-pressed="false">
                                <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" /><circle cx="12" cy="12" r="3" /></svg>
                                <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" /><line x1="1" y1="1" x2="23" y2="23" /></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            Text="Please confirm the password" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword" Operator="Equal" Type="String"
                            Text="Passwords do not match" ValidationGroup="AddUser" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="info-note">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="10" /><line x1="12" y1="16" x2="12" y2="12" /><line x1="12" y1="8" x2="12.01" y2="8" />
                        </svg>
                        <p>A welcome email will be sent to the user if an email address is provided.</p>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <%-- UI only, no validation: highlights the Users sidebar item (the master's
         path match finds no "AddUser" link) and flips the password inputs
         between password and plain text. The status switch is the checkbox's
         own label, so it needs no script. --%>
    <script>
        (function () {
            var link = document.querySelector('.admin-shell .adm-nav a[href="Users.aspx"]');
            if (link) {
                link.classList.add('is-active');
                link.setAttribute('aria-current', 'page');
            }

            var toggles = document.querySelectorAll('.adduser-page .eye-btn');
            Array.prototype.forEach.call(toggles, function (btn) {
                btn.addEventListener('click', function () {
                    var input = document.getElementById(btn.getAttribute('data-target'));
                    var show = input.getAttribute('type') === 'password';
                    input.setAttribute('type', show ? 'text' : 'password');
                    btn.classList.toggle('is-on', show);
                    btn.setAttribute('aria-pressed', show ? 'true' : 'false');
                    btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
                });
            });
        })();
    </script>
</asp:Content>
