<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="sabzify.Register" UnobtrusiveValidationMode="None" %>

<asp:Content ID="RegisterContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-page">
        <div class="auth-card auth-card--wide">

            <div class="auth-brand">
                <svg class="auth-brand-leaf" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                </svg>
                <span class="auth-brand-name">Sabzify</span>
            </div>

            <p class="auth-subtitle">Create your account for fresh deliveries.</p>

            <%-- Row 1: Full Name | Mobile Number --%>
            <div class="auth-row">

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtFullName.ClientID %>">Full Name</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0 2c-4.4 0-8 2.2-8 5v1h16v-1c0-2.8-3.6-5-8-5z" />
                        </svg>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="vivek makvana" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full name is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:RegularExpressionValidator ID="revFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ValidationExpression="^.{2,100}$"
                        ErrorMessage="Enter your full name"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtMobile.ClientID %>">Mobile Number</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.4.6 3.6.1.3 0 .7-.2 1l-2.3 2.2z" />
                        </svg>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="98765 43210" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                        ControlToValidate="txtMobile"
                        ErrorMessage="Mobile number is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:RegularExpressionValidator ID="revMobile" runat="server"
                        ControlToValidate="txtMobile"
                        ValidationExpression="^[6-9]\d{9}$"
                        ErrorMessage="Enter a valid 10-digit mobile number"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

            </div>

            <%-- Row 2: Email Address --%>
            <div class="auth-field">
                <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                    </svg>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="vivek@example.com" />
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email is required"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Register" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Enter a valid email"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Register" />
            </div>

            <%-- Row 3: Password | Confirm Password --%>
            <div class="auth-row">

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtPassword.ClientID %>">Password</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                        </svg>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Create a password" />
                        <button type="button" class="auth-eye" data-toggle-password="<%= txtPassword.ClientID %>" aria-label="Show password">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 5c-5 0-9.3 3.1-11 7 1.7 3.9 6 7 11 7s9.3-3.1 11-7c-1.7-3.9-6-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z" />
                            </svg>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:RegularExpressionValidator ID="revPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                        ErrorMessage="Min 8 characters with uppercase, lowercase and a number"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                        </svg>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Re-enter your password" />
                        <button type="button" class="auth-eye" data-toggle-password="<%= txtConfirmPassword.ClientID %>" aria-label="Show password">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 5c-5 0-9.3 3.1-11 7 1.7 3.9 6 7 11 7s9.3-3.1 11-7c-1.7-3.9-6-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z" />
                            </svg>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Confirm password is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtPassword"
                        Operator="Equal"
                        Type="String"
                        ErrorMessage="Passwords do not match"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

            </div>

            <%-- Row 4: Delivery Address --%>
            <div class="auth-field">
                <label class="auth-label" for="<%= txtAddress.ClientID %>">Delivery Address</label>
                <div class="auth-input-wrap auth-input-wrap--area">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 3 2 12h3v8h6v-5h2v5h6v-8h3L12 3z" />
                    </svg>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="auth-input auth-input--area" TextMode="MultiLine" Rows="2" placeholder="House No., Street Name, Area" />
                </div>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                    ControlToValidate="txtAddress"
                    ErrorMessage="Delivery address is required"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Register" />
                <asp:RegularExpressionValidator ID="revAddress" runat="server"
                    ControlToValidate="txtAddress"
                    ValidationExpression="^[\s\S]{10,250}$"
                    ErrorMessage="Enter a complete delivery address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Register" />
            </div>

            <%-- Row 5: City | State --%>
            <div class="auth-row">

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtCity.ClientID %>">City</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M4 22V2h10v6h6v14H4zm2-2h6V4H6v16zm8 0h4V10h-4v10zM8 6h2v2H8V6zm0 4h2v2H8v-2zm0 4h2v2H8v-2z" />
                        </svg>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="Rajkot" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        ErrorMessage="City is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:RegularExpressionValidator ID="revCity" runat="server"
                        ControlToValidate="txtCity"
                        ValidationExpression="^[A-Za-z][A-Za-z\s.'-]{1,49}$"
                        ErrorMessage="Enter a valid city"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtState.ClientID %>">State</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z" />
                        </svg>
                        <asp:TextBox ID="txtState" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="Gujarat" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server"
                        ControlToValidate="txtState"
                        ErrorMessage="State is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                    <asp:RegularExpressionValidator ID="revState" runat="server"
                        ControlToValidate="txtState"
                        ValidationExpression="^[A-Za-z][A-Za-z\s.'-]{1,49}$"
                        ErrorMessage="Enter a valid state"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="Register" />
                </div>

            </div>

            <asp:Button ID="btnRegister" runat="server"
                CssClass="auth-btn"
                Text="Register"
                OnClick="btnRegister_Click"
                ValidationGroup="Register" />

            <p class="auth-foot">Already have an account? <a href="Login.aspx">Login</a></p>

        </div>
    </div>

    <script type="text/javascript">
        (function () {
            var toggles = document.querySelectorAll('[data-toggle-password]');
            for (var i = 0; i < toggles.length; i++) {
                toggles[i].addEventListener('click', function () {
                    var input = document.getElementById(this.getAttribute('data-toggle-password'));
                    if (!input) { return; }
                    var hidden = input.type === 'password';
                    input.type = hidden ? 'text' : 'password';
                    this.classList.toggle('is-on', hidden);
                    this.setAttribute('aria-label', hidden ? 'Hide password' : 'Show password');
                });
            }
        })();
    </script>

</asp:Content>
