<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="sabzify.Admin.EditProfile" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="EditProfileTitle" ContentPlaceHolderID="TitleContent" runat="server">Edit Profile</asp:Content>

<asp:Content ID="EditProfileHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .profile-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        .profile-page .ep-header {
            margin-bottom: 20px;
        }

        .profile-page .ep-header h1 {
            margin: 0;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .profile-page .ep-form {
            max-width: 640px;
            margin: 0 auto;
        }

        /* Section cards --------------------------------------------------------- */
        .profile-page .ep-card {
            margin-bottom: 16px;
            padding: 16px 18px 6px;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .profile-page .ep-card-head {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid #E5E9E3;
        }

        .profile-page .ep-card-head svg {
            flex: none;
            width: 14px;
            height: 14px;
            color: #1B7A3A;
        }

        .profile-page .ep-card-head h2 {
            margin: 0;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        /* Profile photo ----------------------------------------------------------- */
        .profile-page .photo-block {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 18px;
            padding-bottom: 18px;
            border-bottom: 1px solid #F1F3EF;
        }

        .profile-page .photo-avatar {
            position: relative;
            flex-shrink: 0;
            width: 64px;
            height: 64px;
            overflow: hidden;
            border: 1px solid #D8DED4;
            border-radius: 50%;
            background: #F3F6F2;
        }

        .profile-page .photo-avatar img {
            display: none;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-page .photo-initials {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            font-size: 20px;
            font-weight: 600;
            color: #1B7A3A;
        }

        .profile-page .photo-avatar.has-photo img {
            display: block;
        }

        .profile-page .photo-avatar.has-photo .photo-initials {
            display: none;
        }

        /* flex: 1 gives the error line the full row width, so it stays on one line. */
        .profile-page .photo-side {
            flex: 1;
            min-width: 0;
        }

        .profile-page .photo-title {
            margin: 0 0 8px;
            font-size: 11.5px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .profile-page .photo-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-page .btn-upload {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            height: 28px;
            padding: 0 14px;
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

        .profile-page .btn-upload svg {
            width: 11px;
            height: 11px;
        }

        .profile-page .btn-upload:hover,
        .profile-page .btn-upload:focus-visible {
            background: #166A32;
        }

        .profile-page .btn-remove {
            display: none;
            padding: 0;
            border: 0;
            background: none;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            color: #C0392B;
            cursor: pointer;
        }

        .profile-page .btn-remove.is-shown {
            display: inline-block;
        }

        .profile-page .btn-remove:hover,
        .profile-page .btn-remove:focus-visible {
            text-decoration: underline;
        }

        /* The real file input: out of sight, clicked by "Upload New Photo". */
        .profile-page .photo-file {
            position: absolute;
            width: 0;
            height: 0;
            opacity: 0;
            overflow: hidden;
        }

        /* Hint line. Photo errors are laid over it (absolute, white background), so
           showing one never moves the avatar or the Full Name row below. */
        .profile-page .photo-msgs {
            position: relative;
            margin-top: 8px;
        }

        .profile-page .photo-hint {
            margin: 0;
            font-size: 9.5px;
            line-height: 1.4;
            color: #9CA3AF;
        }

        .profile-page .photo-errors {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
        }

        .profile-page .photo-errors .field-error {
            margin: 0;
            background: #fff;
            font-size: 10px;
            line-height: 1.35;
        }

        /* Fields ------------------------------------------------------------------ */
        .profile-page .field-row {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
            gap: 0 14px;
            align-items: start;
        }

        .profile-page .field {
            margin-bottom: 13px;
        }

        .profile-page .field-narrow {
            max-width: 320px;
        }

        .profile-page .field-label,
        .profile-page .field > label {
            display: block;
            margin-bottom: 5px;
            font-size: 10px;
            font-weight: 500;
            line-height: 1.4;
            color: #374151;
        }

        .profile-page .field input[type="text"],
        .profile-page .field input[type="password"],
        .profile-page .field select {
            display: block;
            width: 100%;
            height: 32px;
            margin: 0;
            padding: 0 10px;
            border: 1px solid #DCE4EC;
            border-radius: 6px;
            background: #F5F9FC;
            font-family: inherit;
            font-size: 10.5px;
            color: #111827;
            outline: none;
            box-sizing: border-box;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .profile-page .field input::placeholder {
            color: #9CA3AF;
        }

        .profile-page .field input[type="text"]:focus,
        .profile-page .field input[type="password"]:focus,
        .profile-page .field select:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        .profile-page .field select {
            padding-right: 30px;
            appearance: none;
            -webkit-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%236B7280' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px 12px;
            cursor: pointer;
        }

        /* Validators use Display="Dynamic"; the client script shows them with an
           inline display:inline, so a visible one is forced to block. */
        .profile-page .field-error {
            display: block;
            margin-top: 3px;
            font-size: 9.5px;
            line-height: 1.35;
            color: #C0392B;
        }

        .profile-page .field-error:not([style*="display:none"]):not([style*="display: none"]) {
            display: block !important;
        }

        /* Invalid-field red border - same :has() technique as Register.aspx. The
           :focus variants are more specific than the plain :focus rule, so the
           green ring cannot override the red border. */
        .profile-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"],
        .profile-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="password"] {
            border-color: #C0392B;
        }

        .profile-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="text"]:focus,
        .profile-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input[type="password"]:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        /* Notification toggles: the real asp:CheckBox is visually hidden; its label
           holds the switch and the text, so clicking either toggles it natively. */
        .profile-page .toggle-list {
            display: flex;
            flex-direction: column;
            gap: 9px;
            padding-top: 2px;
        }

        .profile-page .toggle-item {
            position: relative;
        }

        .profile-page .toggle-item input[type="checkbox"] {
            position: absolute;
            width: 1px;
            height: 1px;
            margin: 0;
            padding: 0;
            overflow: hidden;
            clip: rect(0 0 0 0);
            opacity: 0;
        }

        .profile-page .toggle-item label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 10.5px;
            color: #374151;
            cursor: pointer;
        }

        .profile-page .switch {
            position: relative;
            flex: none;
            width: 26px;
            height: 15px;
            border-radius: 999px;
            background: #D1D5DB;
            transition: background-color .15s ease;
        }

        .profile-page .switch::after {
            content: "";
            position: absolute;
            top: 2px;
            left: 2px;
            width: 11px;
            height: 11px;
            border-radius: 50%;
            background: #fff;
            box-shadow: 0 1px 2px rgba(17, 24, 39, .2);
            transition: transform .15s ease;
        }

        .profile-page .toggle-item input[type="checkbox"]:checked + label .switch {
            background: #1B7A3A;
        }

        .profile-page .toggle-item input[type="checkbox"]:checked + label .switch::after {
            transform: translateX(11px);
        }

        .profile-page .toggle-item input[type="checkbox"]:focus-visible + label .switch {
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .2);
        }

        /* Footer actions ------------------------------------------------------------ */
        .profile-page .ep-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding-top: 14px;
            border-top: 1px solid #E5E9E3;
        }

        .profile-page .btn-cancel,
        .profile-page .btn-save {
            height: 30px;
            padding: 0 18px;
            border-radius: 6px;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .profile-page .btn-cancel {
            border: 1px solid #1B7A3A;
            background: #fff;
            color: #1B7A3A;
        }

        .profile-page .btn-cancel:hover,
        .profile-page .btn-cancel:focus {
            background: #F1F7F2;
        }

        .profile-page .btn-save {
            border: 0;
            background: #1B7A3A;
            color: #fff;
        }

        .profile-page .btn-save:hover,
        .profile-page .btn-save:focus {
            background: #166A32;
        }

        /* Responsive ------------------------------------------------------------ */
        @media screen and (max-width: 600px) {
            .admin-shell .adm-main:has(> .profile-page) {
                padding: 18px 14px;
            }

            .profile-page .field-row {
                grid-template-columns: minmax(0, 1fr);
            }

            .profile-page .field-narrow {
                max-width: none;
            }

            .profile-page .ep-actions {
                flex-direction: column-reverse;
            }

            .profile-page .btn-cancel,
            .profile-page .btn-save {
                width: 100%;
                height: 34px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="EditProfileBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="profile-page">

        <div class="ep-header">
            <h1>Edit Admin Profile</h1>
        </div>

        <div class="ep-form">

            <%-- Personal Details --%>
            <div class="ep-card">
                <div class="ep-card-head">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" />
                    </svg>
                    <h2>Personal Details</h2>
                </div>

                <%-- Profile photo. Optional (keeping the current photo is normal), so
                     there is no RequiredFieldValidator. --%>
                <div class="photo-block">
                    <div class="photo-avatar" id="photoAvatar">
                        <img id="imgPreview" alt="Profile photo preview" />
                        <span class="photo-initials" aria-hidden="true">PK</span>
                    </div>
                    <div class="photo-side">
                        <p class="photo-title">Profile Photo</p>
                        <div class="photo-actions">
                            <button type="button" class="btn-upload" id="btnUploadPhoto">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="17 8 12 3 7 8" /><line x1="12" y1="3" x2="12" y2="15" />
                                </svg>
                                <span>Upload New Photo</span>
                            </button>
                            <button type="button" class="btn-remove" id="btnRemovePhoto">Remove</button>
                            <asp:FileUpload ID="fuPhoto" runat="server" CssClass="photo-file" aria-label="Profile photo" />
                        </div>
                        <div class="photo-msgs">
                            <p class="photo-hint">JPG, PNG or GIF. Max 2 MB.</p>
                            <div class="photo-errors">
                                <%-- Case-insensitive via character classes: the client
                                     script runs this pattern as a JavaScript RegExp,
                                     which does not understand the .NET (?i) flag. --%>
                                <asp:RegularExpressionValidator ID="revPhotoType" runat="server" ControlToValidate="fuPhoto"
                                    ValidationExpression="^$|.+\.([Jj][Pp][Gg]|[Jj][Pp][Ee][Gg]|[Pp][Nn][Gg]|[Gg][Ii][Ff])$"
                                    ErrorMessage="Use a JPG, PNG or GIF file" Display="Dynamic"
                                    CssClass="field-error" ValidationGroup="AdminProfile" />
                                <%-- Server-side only (no ClientValidationFunction). --%>
                                <asp:CustomValidator ID="cvPhotoSize" runat="server" ControlToValidate="fuPhoto"
                                    ValidateEmptyText="true" OnServerValidate="cvPhotoSize_ServerValidate"
                                    ErrorMessage="Photo must be 2 MB or smaller" Display="Dynamic"
                                    CssClass="field-error" ValidationGroup="AdminProfile" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="field-row">
                    <div class="field">
                        <asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName" Text="Full Name" />
                        <asp:TextBox ID="txtFullName" runat="server" Text="Priyanshu kateshiya" autocomplete="name" />
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                            ErrorMessage="Full name is required" ValidationGroup="AdminProfile" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revFullName" runat="server" ControlToValidate="txtFullName"
                            ValidationExpression="^(?=.{2,100}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                            ErrorMessage="Only letters and spaces" ValidationGroup="AdminProfile" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <div class="field">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email Address" />
                        <asp:TextBox ID="txtEmail" runat="server" Text="admin@sabzify.com" autocomplete="email" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email address is required" ValidationGroup="AdminProfile" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email" ValidationGroup="AdminProfile" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>
                </div>

                <div class="field">
                    <asp:Label ID="lblMobile" runat="server" AssociatedControlID="txtMobile" Text="Mobile Number" />
                    <asp:TextBox ID="txtMobile" runat="server" Text="+91 8401368370" autocomplete="tel" />
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                        ErrorMessage="Mobile number is required" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                        ValidationExpression="^(\+91[\s-]?)?[6-9]\d{4}[\s-]?\d{5}$"
                        ErrorMessage="Enter a valid 10-digit mobile number" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>
            </div>

            <%-- Security. Changing the password is optional: all three boxes may be
                 left empty. Once a new password is typed, the current password and
                 the confirmation are required (server-side CustomValidators, since a
                 RequiredFieldValidator cannot be conditional). --%>
            <div class="ep-card">
                <div class="ep-card-head">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                    <h2>Security</h2>
                </div>

                <div class="field field-narrow">
                    <asp:Label ID="lblOldPassword" runat="server" AssociatedControlID="txtOldPassword" Text="Old Password" />
                    <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" autocomplete="current-password" />
                    <asp:CustomValidator ID="cvOldPassword" runat="server" ControlToValidate="txtOldPassword"
                        ValidateEmptyText="true" OnServerValidate="cvOldPassword_ServerValidate"
                        ErrorMessage="Enter your current password to change it" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" />
                </div>

                <div class="field field-narrow">
                    <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="txtNewPassword" Text="New Password" />
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Enter new password" autocomplete="new-password" />
                    <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                        ErrorMessage="Min 8 characters with uppercase, lowercase and a number" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>

                <div class="field field-narrow">
                    <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword" Text="Confirm New Password" />
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm new password" autocomplete="new-password" />
                    <asp:CustomValidator ID="cvConfirmRequired" runat="server" ControlToValidate="txtConfirmPassword"
                        ValidateEmptyText="true" OnServerValidate="cvConfirmRequired_ServerValidate"
                        ErrorMessage="Please confirm the new password" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" />
                    <asp:CompareValidator ID="cmpConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtNewPassword" Operator="Equal" Type="String"
                        ErrorMessage="Passwords do not match" ValidationGroup="AdminProfile" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>
            </div>

            <%-- Preferences. A dropdown and two switches always hold a valid value,
                 so they carry no validators. --%>
            <div class="ep-card">
                <div class="ep-card-head">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
                    </svg>
                    <h2>Preferences</h2>
                </div>

                <div class="field-row">
                    <div class="field">
                        <asp:Label ID="lblLanguage" runat="server" AssociatedControlID="ddlLanguage" Text="System Language" />
                        <asp:DropDownList ID="ddlLanguage" runat="server">
                            <asp:ListItem Text="English" Value="en" Selected="True" />
                            <asp:ListItem Text="Hindi" Value="hi" />
                            <asp:ListItem Text="Gujarati" Value="gu" />
                        </asp:DropDownList>
                    </div>

                    <div class="field">
                        <span class="field-label">Notifications</span>
                        <div class="toggle-list">
                            <div class="toggle-item">
                                <asp:CheckBox ID="chkEmailNotifications" runat="server" Checked="true" />
                                <asp:Label ID="lblEmailNotifications" runat="server" AssociatedControlID="chkEmailNotifications"><span class="switch" aria-hidden="true"></span>Email Notifications</asp:Label>
                            </div>
                            <div class="toggle-item">
                                <asp:CheckBox ID="chkSmsAlerts" runat="server" />
                                <asp:Label ID="lblSmsAlerts" runat="server" AssociatedControlID="chkSmsAlerts"><span class="switch" aria-hidden="true"></span>SMS Alerts</asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ep-actions">
                <%-- UseSubmitBehavior="false" renders type="button", so pressing Enter
                     in a field submits Save Changes, not Cancel. --%>
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel"
                    CausesValidation="false" UseSubmitBehavior="false"
                    PostBackUrl="~/Admin/Dashboard.aspx" />
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn-save"
                    ValidationGroup="AdminProfile" />
            </div>

        </div>

    </div>

    <%-- UI only: photo preview. It never blocks or rejects a file; the type and
         size rules belong to the validators above. --%>
    <script>
        (function () {
            var fileInput = document.getElementById('<%= fuPhoto.ClientID %>');
            var avatar = document.getElementById('photoAvatar');
            var preview = document.getElementById('imgPreview');
            var uploadBtn = document.getElementById('btnUploadPhoto');
            var removeBtn = document.getElementById('btnRemovePhoto');

            function showInitials() {
                avatar.classList.remove('has-photo');
                preview.removeAttribute('src');
            }

            uploadBtn.addEventListener('click', function () {
                fileInput.click();
            });

            // A file that is not a picture simply leaves the initials in place.
            preview.addEventListener('error', showInitials);

            fileInput.addEventListener('change', function () {
                var file = fileInput.files && fileInput.files[0];
                if (!file) {
                    showInitials();
                    removeBtn.classList.remove('is-shown');
                    return;
                }
                removeBtn.classList.add('is-shown');
                var reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    avatar.classList.add('has-photo');
                };
                reader.readAsDataURL(file);
            });

            removeBtn.addEventListener('click', function () {
                fileInput.value = '';
                showInitials();
                removeBtn.classList.remove('is-shown');
                uploadBtn.focus();
            });
        })();
    </script>
</asp:Content>
