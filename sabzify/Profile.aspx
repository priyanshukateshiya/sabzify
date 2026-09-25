<%@ Page Title="Profile Information" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="sabzify.Profile" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="ProfileContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .profile-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.profile-page) {
            background: #F3F7EC;
        }

        .profile-page {
            max-width: 1040px;
            margin: 0 auto;
            padding: 32px 24px 56px;
            color: #111827;
        }

        /* Site.css caps every input at 280px; this page's fields (and the
           Save button, which renders as an input) are full-width instead. */
        .profile-page input,
        .profile-page select {
            max-width: none;
        }

        .profile-page .pf-cols {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }

        .profile-page .pf-side {
            display: flex;
            flex: 0 0 240px;
            flex-direction: column;
            gap: 14px;
            min-width: 0;
        }

        .profile-page .pf-main {
            flex: 1 1 auto;
            min-width: 0;
        }

        .profile-page .pf-card {
            border: 1px solid #EDEFEA;
            border-radius: 10px;
            background: #FFFFFF;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .06);
        }

        /* Sidebar user card ------------------------------------------------ */
        .profile-page .pf-user {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 18px;
        }

        .profile-page .pf-avatar {
            flex: none;
            width: 44px;
            height: 44px;
            border: 1px solid #D8DED4;
            border-radius: 50%;
            background: #FFFFFF;
        }

        .profile-page .pf-user-name {
            font-size: 15px;
            font-weight: 600;
            line-height: 1.25;
            color: #111827;
        }

        .profile-page .pf-user-place {
            display: flex;
            align-items: center;
            gap: 4px;
            margin-top: 4px;
            font-size: 11px;
            color: #6B7280;
        }

        .profile-page .pf-user-place svg {
            flex: none;
            width: 11px;
            height: 11px;
            fill: #1B6E2A;
        }

        /* Sidebar nav ------------------------------------------------------- */
        .profile-page .pf-nav {
            padding: 8px;
        }

        .profile-page .pf-nav-heading {
            padding: 14px 14px 10px;
            margin-bottom: 8px;
            border-bottom: 1px solid #EFF1ED;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .profile-page .pf-nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            box-sizing: border-box;
            width: 100%;
            padding: 10px 12px;
            border: none;
            border-radius: 8px;
            background: none;
            color: #374151;
            font-family: inherit;
            font-size: 12.5px;
            text-align: left;
            text-decoration: none;
            cursor: pointer;
        }

        .profile-page .pf-nav-item svg {
            flex: none;
            width: 15px;
            height: 15px;
            fill: #6B7280;
        }

        .profile-page .pf-nav-item:hover {
            background: #F5F7F3;
            color: #374151;
        }

        .profile-page .pf-nav-item.is-active {
            background: #E9F3E4;
            color: #1B6E2A;
            font-weight: 600;
        }

        .profile-page .pf-nav-item.is-active svg {
            fill: #1B6E2A;
        }

        .profile-page .pf-nav-divider {
            height: 1px;
            margin: 8px 0;
            background: #EFF1ED;
        }

        .profile-page .pf-nav-item--logout {
            color: #C0392B;
            font-weight: 600;
        }

        .profile-page .pf-nav-item--logout svg {
            fill: #C0392B;
        }

        .profile-page .pf-nav-item--logout:hover {
            background: #FDF3F3;
            color: #C0392B;
        }

        /* Content card ------------------------------------------------------ */
        .profile-page .pf-content {
            padding: 24px;
        }

        .profile-page .pf-head {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 8px;
        }

        .profile-page h1.pf-title {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: #111827;
        }

        .profile-page .pf-subtitle {
            margin: 4px 0 0;
            font-size: 12px;
            color: #6B7280;
        }

        .profile-page .pf-divider {
            height: 1px;
            margin: 18px 0 20px;
            background: #F1F3EF;
        }

        /* Edit Profile button ------------------------------------------------ */
        .profile-page .pf-edit {
            display: inline-flex;
            flex: none;
            align-items: center;
            gap: 6px;
            height: 32px;
            padding: 0 16px;
            border: none;
            border-radius: 999px;
            background: #1B7A3A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-page .pf-edit:hover {
            background: #166A32;
        }

        .profile-page .pf-edit svg {
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        .profile-page.is-editing .pf-edit {
            display: none;
        }

        /* Photo panel (edit mode only) --------------------------------------- */
        .profile-page .pf-photo {
            display: none;
            align-items: center;
            gap: 16px;
            margin-bottom: 22px;
            padding: 16px;
            border-radius: 10px;
            background: #EAF3EA;
        }

        .profile-page.is-editing .pf-photo {
            display: flex;
        }

        .profile-page .pf-photo-avatar {
            flex: none;
            width: 52px;
            height: 52px;
            border: 1px solid #D8DED4;
            border-radius: 50%;
            background: #FFFFFF;
        }

        .profile-page .pf-photo-label {
            margin-bottom: 8px;
            font-size: 12px;
            font-weight: 600;
            color: #111827;
        }

        .profile-page .pf-photo-actions {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .profile-page .pf-upload {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            height: 30px;
            padding: 0 14px;
            border: none;
            border-radius: 999px;
            background: #1B7A3A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-page .pf-upload:hover {
            background: #166A32;
        }

        .profile-page .pf-upload svg {
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        .profile-page .pf-change {
            padding: 0;
            border: none;
            background: none;
            color: #1B6E2A;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-page .pf-change:hover {
            text-decoration: underline;
        }

        .profile-page .pf-photo-hint {
            margin-top: 8px;
            font-size: 10px;
            color: #6B7280;
        }

        /* The real file input stays out of sight; the green button opens it. */
        .profile-page .pf-file {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            border: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0 0 0 0);
            white-space: nowrap;
        }

        /* Form grid ---------------------------------------------------------- */
        .profile-page .pf-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px 18px;
        }

        /* padding-bottom reserves the error row so a message never moves the
           grid; the message itself is absolutely positioned inside it. */
        .profile-page .pf-field {
            position: relative;
            min-width: 0;
            padding-bottom: 17px;
        }

        .profile-page .pf-field--wide {
            grid-column: 1 / -1;
        }

        .profile-page .pf-label {
            display: block;
            margin-bottom: 5px;
            font-size: 11px;
            color: #6B7280;
        }

        .profile-page .pf-input {
            box-sizing: border-box;
            width: 100%;
            height: 36px;
            padding: 0 12px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #FFFFFF;
            color: #111827;
            font-family: inherit;
            font-size: 12.5px;
        }

        .profile-page .pf-input:focus {
            border-color: #1B6E2A;
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .14);
            outline: none;
        }

        /* View mode: flat, non-interactive fields. The select keeps its value
           posting (pointer-events, not disabled), so nothing is lost. */
        .profile-page:not(.is-editing) .pf-input,
        .profile-page:not(.is-editing) .pf-code {
            background: #F8FAF7;
            cursor: default;
        }

        .profile-page:not(.is-editing) .pf-input:focus,
        .profile-page:not(.is-editing) .pf-code:focus {
            border-color: #E1E6EA;
            box-shadow: none;
        }

        .profile-page:not(.is-editing) .pf-code {
            pointer-events: none;
        }

        /* Email field: the icon sits inside the input's left padding. */
        .profile-page .pf-input-wrap {
            position: relative;
            display: block;
        }

        .profile-page .pf-input-icon {
            position: absolute;
            top: 50%;
            left: 12px;
            width: 14px;
            height: 14px;
            fill: #9CA3AF;
            pointer-events: none;
            transform: translateY(-50%);
        }

        .profile-page .pf-input--icon {
            padding-left: 36px;
        }

        /* Phone row ----------------------------------------------------------- */
        .profile-page .pf-phone {
            display: flex;
            gap: 8px;
        }

        .profile-page .pf-code {
            box-sizing: border-box;
            flex: none;
            width: 62px;
            height: 36px;
            padding: 0 6px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #FFFFFF;
            color: #111827;
            font-family: inherit;
            font-size: 12.5px;
        }

        .profile-page .pf-code:focus {
            border-color: #1B6E2A;
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .14);
            outline: none;
        }

        .profile-page .pf-phone .pf-input {
            flex: 1 1 auto;
        }

        /* Validation ------------------------------------------------------------
           Overrides the 12px global .field-error for this page only. */
        .profile-page .field-error {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;
            display: block;
            margin-top: 0;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
        }

        /* Same :has() approach as Register/Site.css: a validator span that is
           not display:none means the field is invalid, so the input turns red. */
        .profile-page .pf-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .pf-input,
        .profile-page .pf-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .pf-input:focus {
            border-color: #C0392B;
        }

        .profile-page .pf-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .pf-input:focus {
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .14);
        }

        .profile-page .summary-error {
            display: block;
            margin: 18px 0 0;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
        }

        /* Footer buttons (edit mode only) --------------------------------------- */
        .profile-page .pf-foot-divider {
            display: none;
            height: 1px;
            margin-top: 22px;
            background: #F1F3EF;
        }

        .profile-page.is-editing .pf-foot-divider {
            display: block;
        }

        .profile-page .pf-foot {
            display: none;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 22px;
        }

        .profile-page.is-editing .pf-foot {
            display: flex;
        }

        .profile-page .pf-cancel,
        .profile-page input.pf-save {
            box-sizing: border-box;
            height: 32px;
            padding: 0 18px;
            border-radius: 999px;
            font-family: inherit;
            font-size: 12px;
            cursor: pointer;
        }

        .profile-page .pf-cancel {
            border: 1px solid #C9D3C4;
            background: #FFFFFF;
            color: #374151;
        }

        .profile-page .pf-cancel:hover {
            background: #F6F8F4;
        }

        .profile-page input.pf-save {
            border: none;
            background: #1B7A3A;
            color: #FFFFFF;
            font-weight: 600;
        }

        .profile-page input.pf-save:hover {
            background: #166A32;
        }

        /* Responsive ------------------------------------------------------------ */
        @media (max-width: 900px) {
            .profile-page .pf-cols {
                display: block;
            }

            .profile-page .pf-side {
                margin-bottom: 14px;
            }

            .profile-page .pf-nav-list {
                display: flex;
                gap: 8px;
                overflow-x: auto;
            }

            .profile-page .pf-nav-list .pf-nav-item {
                flex: none;
                width: auto;
                white-space: nowrap;
            }
        }

        @media (max-width: 600px) {
            .profile-page .pf-grid {
                grid-template-columns: 1fr;
            }

            .profile-page .pf-head {
                display: block;
            }

            .profile-page .pf-edit {
                margin-top: 12px;
            }

            .profile-page.is-editing .pf-photo {
                display: block;
            }

            .profile-page .pf-photo-avatar {
                margin-bottom: 12px;
            }

            .profile-page.is-editing .pf-foot {
                display: block;
            }

            .profile-page.is-editing .pf-foot .pf-cancel,
            .profile-page.is-editing .pf-foot input.pf-save {
                display: block;
                width: 100%;
            }

            .profile-page.is-editing .pf-foot input.pf-save {
                margin-top: 10px;
            }
        }
    </style>

    <div class="profile-page" id="pfPage">

        <div class="pf-cols">

            <div class="pf-side">

                <div class="pf-card pf-user">
                    <div class="pf-avatar"></div>
                    <div>
                        <div class="pf-user-name">Pratik Nakum</div>
                        <div class="pf-user-place">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                            </svg>
                            Rajkot, Gujarat
                        </div>
                    </div>
                </div>

                <div class="pf-card pf-nav">
                    <div class="pf-nav-heading">My Account</div>
                    <div class="pf-nav-list">
                        <a class="pf-nav-item is-active" href="Profile.aspx">
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
                        <a class="pf-nav-item" href="Wishlist.aspx">
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

                    <a class="pf-nav-item pf-nav-item--logout" href="Login.aspx">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M10 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h5v-2H5V5h5zm6.6 4L15.2 8.4 17.8 11H9v2h8.8l-2.6 2.6L16.6 17 21.6 12z" />
                        </svg>
                        Logout
                    </a>
                </div>

            </div>

            <div class="pf-main">
                <div class="pf-card pf-content">

                    <div class="pf-head">
                        <div>
                            <h1 class="pf-title">Profile Information</h1>
                            <p class="pf-subtitle">Update your personal details and contact information.</p>
                        </div>
                        <%-- type="button" keeps this out of both validation and postback. --%>
                        <button type="button" class="pf-edit" id="pfEdit">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M3 17.2V21h3.8L17.8 10 14 6.2zm17.7-12.5a1 1 0 0 0 0-1.4L18.7 1.3a1 1 0 0 0-1.4 0l-1.8 1.8L19.3 6.9z" />
                            </svg>
                            Edit Profile
                        </button>
                    </div>

                    <div class="pf-divider"></div>

                    <div class="pf-photo">
                        <div class="pf-photo-avatar"></div>
                        <div>
                            <div class="pf-photo-label">Profile Photo</div>
                            <div class="pf-photo-actions">
                                <button type="button" class="pf-upload" id="pfUpload">
                                    <svg viewBox="0 0 24 24" aria-hidden="true">
                                        <path d="M12 3 7 8h3v7h4V8h3zM5 18h14v2H5z" />
                                    </svg>
                                    Upload New Photo
                                </button>
                                <button type="button" class="pf-change" id="pfChange">Change Photo</button>
                            </div>
                            <div class="pf-photo-hint">Drag and drop or click to upload. JPG, PNG or GIF.</div>
                            <asp:FileUpload ID="fuPhoto" runat="server" CssClass="pf-file" />
                        </div>
                    </div>

                    <div class="pf-grid">

                        <div class="pf-field">
                            <label class="pf-label" for="<%= txtFirstName.ClientID %>">First Name</label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="pf-input" Text="Pratik" />
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txtFirstName"
                                Text="First name is required"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revFirstName" runat="server"
                                ControlToValidate="txtFirstName"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                                Text="Only letters and spaces"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="pf-field">
                            <label class="pf-label" for="<%= txtLastName.ClientID %>">Last Name</label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="pf-input" Text="Nakum" />
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                ControlToValidate="txtLastName"
                                Text="Last name is required"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revLastName" runat="server"
                                ControlToValidate="txtLastName"
                                ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                                Text="Only letters and spaces"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="pf-field pf-field--wide">
                            <label class="pf-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                            <span class="pf-input-wrap">
                                <svg class="pf-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M3 5h18a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1zm9 8L4.4 7.2 3.6 8.4 12 14.5l8.4-6.1-.8-1.2z" />
                                </svg>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="pf-input pf-input--icon" Text="pratik.nakum@example.com" />
                            </span>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail"
                                Text="Email is required"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                ControlToValidate="txtEmail"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                Text="Enter a valid email"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                        <div class="pf-field pf-field--wide">
                            <label class="pf-label" for="<%= txtPhone.ClientID %>">Phone Number</label>
                            <span class="pf-phone">
                                <asp:DropDownList ID="ddlCode" runat="server" CssClass="pf-code">
                                    <asp:ListItem Value="+91" Selected="True">+91</asp:ListItem>
                                    <asp:ListItem Value="+1">+1</asp:ListItem>
                                    <asp:ListItem Value="+44">+44</asp:ListItem>
                                    <asp:ListItem Value="+971">+971</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="pf-input" Text="98765 43210" />
                            </span>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                ControlToValidate="txtPhone"
                                Text="Phone number is required"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ID="revPhone" runat="server"
                                ControlToValidate="txtPhone"
                                ValidationExpression="^[6-9]\d{4}[\s-]?\d{5}$"
                                Text="Enter a valid 10-digit mobile number"
                                ErrorMessage=""
                                ValidationGroup="Profile"
                                Display="Dynamic"
                                CssClass="field-error"
                                SetFocusOnError="true" />
                        </div>

                    </div>

                    <asp:ValidationSummary ID="vsProfile" runat="server"
                        ValidationGroup="Profile"
                        DisplayMode="SingleParagraph"
                        HeaderText="Please fix the highlighted fields"
                        ShowMessageBox="false"
                        CssClass="summary-error" />

                    <div class="pf-foot-divider"></div>

                    <div class="pf-foot">
                        <button type="button" class="pf-cancel" id="pfCancel">Cancel</button>
                        <asp:Button ID="btnSave" runat="server"
                            Text="Save Changes"
                            CssClass="pf-save"
                            ValidationGroup="Profile" />
                    </div>

                </div>
            </div>

        </div>

    </div>

    <%-- UI-only mode switching. No validation lives here: the ASP.NET
         validators own that. Every control below is type="button", so the
         only thing that posts back is Save Changes. --%>
    <script type="text/javascript">
        (function () {
            var page = document.getElementById('pfPage');
            var editBtn = document.getElementById('pfEdit');
            var cancelBtn = document.getElementById('pfCancel');
            if (!page || !editBtn) { return; }

            var texts = page.querySelectorAll('input.pf-input');
            var fields = page.querySelectorAll('.pf-input, .pf-code');
            var original = [];

            function snapshot() {
                original = [];
                for (var i = 0; i < fields.length; i++) {
                    original.push(fields[i].value);
                }
            }

            // readonly is only set on the text boxes; the country code stays a
            // live select (pointer-events off in view mode) so it still posts.
            function setEditing(on) {
                for (var i = 0; i < texts.length; i++) {
                    if (on) {
                        texts[i].removeAttribute('readonly');
                    } else {
                        texts[i].setAttribute('readonly', 'readonly');
                    }
                }
                page.className = on ? 'profile-page is-editing' : 'profile-page';
            }

            // A postback that failed validation comes back with visible
            // messages, so stay in edit mode and keep them on screen.
            function hasVisibleErrors() {
                var spans = page.querySelectorAll('.field-error');
                for (var i = 0; i < spans.length; i++) {
                    if (spans[i].style.display !== 'none' && spans[i].offsetParent !== null) { return true; }
                }
                return false;
            }

            snapshot();
            setEditing(hasVisibleErrors());

            editBtn.onclick = function () {
                snapshot();
                setEditing(true);
            };

            cancelBtn.onclick = function () {
                for (var i = 0; i < fields.length; i++) {
                    fields[i].value = original[i];
                }
                // Clear anything a failed save left behind.
                if (typeof Page_Validators !== 'undefined') {
                    for (var j = 0; j < Page_Validators.length; j++) {
                        Page_Validators[j].style.display = 'none';
                        Page_Validators[j].isvalid = true;
                    }
                }
                var summary = document.getElementById('<%= vsProfile.ClientID %>');
                if (summary) { summary.style.display = 'none'; }
                setEditing(false);
            };

            var upload = document.getElementById('pfUpload');
            var change = document.getElementById('pfChange');
            var file = document.getElementById('<%= fuPhoto.ClientID %>');
            function pick() { if (file) { file.click(); } }
            if (upload) { upload.onclick = pick; }
            if (change) { change.onclick = pick; }
        })();
    </script>

</asp:Content>
