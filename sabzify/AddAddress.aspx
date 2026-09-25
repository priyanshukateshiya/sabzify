<%@ Page Title="Add New Address" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddAddress.aspx.cs" Inherits="sabzify.AddAddress" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="AddAddressContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .acct-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.acct-page) {
            background: #F3F7EC;
        }

        .acct-page {
            padding: 0 24px;
            color: #111827;
        }

        /* Site.css caps every input at 280px; this form's fields (and the
           Save button, which renders as an input) are full-width instead. */
        .acct-page input,
        .acct-page select {
            max-width: none;
        }

        .acct-page .aa-card {
            box-sizing: border-box;
            max-width: 560px;
            margin: 32px auto 56px;
            padding: 28px;
            border: 1px solid #EDEFEA;
            border-radius: 12px;
            background: #FFFFFF;
        }

        /* Header ------------------------------------------------------------ */
        .acct-page .aa-head {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 22px;
        }

        .acct-page .aa-back {
            padding: 0;
            border: none;
            background: none;
            color: #111827;
            font-family: inherit;
            font-size: 18px;
            line-height: 1;
            cursor: pointer;
        }

        .acct-page h1.aa-title {
            margin: 0;
            font-size: 19px;
            font-weight: 700;
            color: #111827;
        }

        /* Fields ------------------------------------------------------------- */
        .acct-page .aa-row {
            display: grid;
            gap: 16px;
        }

        .acct-page .aa-row--2 {
            grid-template-columns: 1fr 1fr;
        }

        .acct-page .aa-row--3 {
            grid-template-columns: 1fr 1fr 1fr;
            gap: 12px;
        }

        /* padding-bottom reserves the error row so a message never shifts the
           grid; the message itself is absolutely positioned inside it. */
        .acct-page .aa-field {
            position: relative;
            min-width: 0;
            margin-bottom: 16px;
            padding-bottom: 16px;
        }

        .acct-page .aa-label {
            display: block;
            margin-bottom: 5px;
            font-size: 11px;
            color: #6B7280;
        }

        .acct-page .aa-input {
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

        .acct-page .aa-input:focus {
            border-color: #1B6E2A;
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .14);
            outline: none;
        }

        .acct-page .aa-input--filled {
            background: #EAF3EA;
        }

        .acct-page .aa-phone {
            display: flex;
            gap: 8px;
        }

        .acct-page .aa-code {
            box-sizing: border-box;
            flex: none;
            width: 52px;
            height: 36px;
            padding: 0 4px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #FFFFFF;
            color: #111827;
            font-family: inherit;
            font-size: 12.5px;
        }

        .acct-page .aa-code:focus {
            border-color: #1B6E2A;
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .14);
            outline: none;
        }

        .acct-page .aa-phone .aa-input {
            flex: 1 1 auto;
        }

        /* Address type chips --------------------------------------------------
           The RadioButtons keep their real inputs (so the group still posts);
           only the visual is a chip on the adjacent label. */
        .acct-page .aa-types {
            display: flex;
            gap: 10px;
            margin-top: 5px;
        }

        .acct-page .aa-type input {
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

        .acct-page .aa-type label {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-sizing: border-box;
            height: 30px;
            padding: 0 14px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #FFFFFF;
            color: #374151;
            font-size: 11.5px;
            cursor: pointer;
        }

        .acct-page .aa-type label svg {
            flex: none;
            width: 12px;
            height: 12px;
            fill: currentColor;
        }

        .acct-page .aa-type input:checked + label {
            border-color: transparent;
            background: #1B7A3A;
            color: #FFFFFF;
        }

        .acct-page .aa-type input:focus + label {
            box-shadow: 0 0 0 3px rgba(27, 110, 42, .14);
        }

        /* Default checkbox ----------------------------------------------------- */
        .acct-page .aa-check {
            margin-top: 14px;
            font-size: 11.5px;
            color: #374151;
        }

        .acct-page .aa-check input {
            width: auto;
            margin-right: 7px;
            accent-color: #1B7A3A;
            vertical-align: middle;
        }

        .acct-page .aa-check label {
            vertical-align: middle;
            cursor: pointer;
        }

        .acct-page .aa-divider {
            height: 1px;
            margin: 22px 0 18px;
            background: #F1F3EF;
        }

        /* Validation ------------------------------------------------------------
           Overrides the 12px global .field-error for this page only. */
        .acct-page .field-error {
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
        .acct-page .aa-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .aa-input,
        .acct-page .aa-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .aa-input:focus {
            border-color: #C0392B;
        }

        .acct-page .aa-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) .aa-input:focus {
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .14);
        }

        .acct-page .summary-error {
            display: block;
            margin: 0 0 12px;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
        }

        /* Footer buttons --------------------------------------------------------- */
        .acct-page .aa-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .acct-page input.aa-save {
            box-sizing: border-box;
            width: 100%;
            height: 38px;
            padding: 0;
            border: none;
            border-radius: 6px;
            background: #1B7A3A;
            color: #FFFFFF;
            font-family: inherit;
            font-size: 12.5px;
            font-weight: 600;
            cursor: pointer;
        }

        .acct-page input.aa-save:hover {
            background: #166A32;
        }

        .acct-page .aa-cancel {
            display: flex;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
            width: 100%;
            height: 36px;
            border: 1px solid #C9D3C4;
            border-radius: 6px;
            background: #FFFFFF;
            color: #374151;
            font-family: inherit;
            font-size: 12.5px;
            text-decoration: none;
            cursor: pointer;
        }

        .acct-page .aa-cancel:hover {
            background: #F6F8F4;
            color: #374151;
        }

        /* Responsive ---------------------------------------------------------- */
        @media (max-width: 700px) {
            .acct-page .aa-row--2,
            .acct-page .aa-row--3 {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .acct-page .aa-types {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .acct-page {
                padding: 0 16px;
            }

            .acct-page .aa-card {
                margin: 20px auto;
                padding: 20px;
            }

            .acct-page h1.aa-title {
                font-size: 15px;
            }
        }
    </style>

    <div class="acct-page">

        <div class="aa-card">

            <div class="aa-head">
                <%-- type="button" keeps the back arrow out of validation. --%>
                <button type="button" class="aa-back" id="aaBack" aria-label="Back to saved addresses">&#8592;</button>
                <h1 class="aa-title">Add New Address</h1>
            </div>

            <div class="aa-row aa-row--2">

                <div class="aa-field">
                    <label class="aa-label" for="<%= txtFullName.ClientID %>">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="aa-input" placeholder="Enter your full name" />
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                        ControlToValidate="txtFullName"
                        Text="Full name is required"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ValidationExpression="^(?=.{2,100}$)[A-Za-z]+(?:[ .'][A-Za-z]+)*$"
                        Text="Only letters and spaces"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                </div>

                <div class="aa-field">
                    <label class="aa-label" for="<%= txtPhone.ClientID %>">Phone Number</label>
                    <span class="aa-phone">
                        <asp:DropDownList ID="ddlCode" runat="server" CssClass="aa-code">
                            <asp:ListItem Value="+91" Selected="True">+91</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="aa-input" placeholder="10-digit mobile number" />
                    </span>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                        ControlToValidate="txtPhone"
                        Text="Phone number is required"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revPhone" runat="server"
                        ControlToValidate="txtPhone"
                        ValidationExpression="^[6-9]\d{9}$"
                        Text="Enter a valid 10-digit mobile number"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                </div>

            </div>

            <div class="aa-field">
                <label class="aa-label" for="<%= txtBuilding.ClientID %>">Flat, House no., Building, Company, Apartment</label>
                <asp:TextBox ID="txtBuilding" runat="server" CssClass="aa-input" placeholder="Enter building details" />
                <asp:RequiredFieldValidator ID="rfvBuilding" runat="server"
                    ControlToValidate="txtBuilding"
                    Text="Building details are required"
                    ErrorMessage=""
                    ValidationGroup="Address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true" />
                <asp:RegularExpressionValidator ID="revBuilding" runat="server"
                    ControlToValidate="txtBuilding"
                    ValidationExpression="^.{3,150}$"
                    Text="Enter at least 3 characters"
                    ErrorMessage=""
                    ValidationGroup="Address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true" />
            </div>

            <div class="aa-field">
                <label class="aa-label" for="<%= txtArea.ClientID %>">Area, Colony, Street, Sector, Village</label>
                <asp:TextBox ID="txtArea" runat="server" CssClass="aa-input" placeholder="Enter area details" />
                <asp:RequiredFieldValidator ID="rfvArea" runat="server"
                    ControlToValidate="txtArea"
                    Text="Area details are required"
                    ErrorMessage=""
                    ValidationGroup="Address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true" />
                <asp:RegularExpressionValidator ID="revArea" runat="server"
                    ControlToValidate="txtArea"
                    ValidationExpression="^.{3,150}$"
                    Text="Enter at least 3 characters"
                    ErrorMessage=""
                    ValidationGroup="Address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true" />
            </div>

            <%-- Landmark is optional: no RequiredFieldValidator, and a
                 RegularExpressionValidator passes on empty input. --%>
            <div class="aa-field">
                <label class="aa-label" for="<%= txtLandmark.ClientID %>">Landmark (Optional)</label>
                <asp:TextBox ID="txtLandmark" runat="server" CssClass="aa-input" placeholder="E.g. Near Apollo Hospital" />
                <asp:RegularExpressionValidator ID="revLandmark" runat="server"
                    ControlToValidate="txtLandmark"
                    ValidationExpression="^.{0,100}$"
                    Text="Landmark is too long"
                    ErrorMessage=""
                    ValidationGroup="Address"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true" />
            </div>

            <div class="aa-row aa-row--3">

                <div class="aa-field">
                    <label class="aa-label" for="<%= txtPincode.ClientID %>">Pincode</label>
                    <asp:TextBox ID="txtPincode" runat="server" CssClass="aa-input" Text="360001" />
                    <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                        ControlToValidate="txtPincode"
                        Text="Pincode is required"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revPincode" runat="server"
                        ControlToValidate="txtPincode"
                        ValidationExpression="^[1-9][0-9]{5}$"
                        Text="Enter a valid 6-digit pincode"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                </div>

                <div class="aa-field">
                    <label class="aa-label" for="<%= txtCity.ClientID %>">City</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="aa-input aa-input--filled" Text="Rajkot" />
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        Text="City is required"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revCity" runat="server"
                        ControlToValidate="txtCity"
                        ValidationExpression="^(?=.{2,50}$)[A-Za-z]+(?:[ .-][A-Za-z]+)*$"
                        Text="Enter a valid city name"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                </div>

                <%-- The blank first item is what InitialValue="" tests against,
                     so "Select a state" fires when nothing is chosen. --%>
                <div class="aa-field">
                    <label class="aa-label" for="<%= ddlState.ClientID %>">State</label>
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="aa-input">
                        <asp:ListItem Value="">Select</asp:ListItem>
                        <asp:ListItem Value="Gujarat" Selected="True">Gujarat</asp:ListItem>
                        <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                        <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                        <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server"
                        ControlToValidate="ddlState"
                        InitialValue=""
                        Text="Select a state"
                        ErrorMessage=""
                        ValidationGroup="Address"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true" />
                </div>

            </div>

            <label class="aa-label">Address Type</label>
            <div class="aa-types">
                <span class="aa-type">
                    <asp:RadioButton ID="rbHome" runat="server" GroupName="AddrType" Checked="true" Text="" />
                    <label for="<%= rbHome.ClientID %>">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 3 3 10.5V21h6v-6h6v6h6V10.5z" />
                        </svg>
                        Home
                    </label>
                </span>
                <span class="aa-type">
                    <asp:RadioButton ID="rbOffice" runat="server" GroupName="AddrType" Text="" />
                    <label for="<%= rbOffice.ClientID %>">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M9 3h6a1 1 0 0 1 1 1v2h4a1 1 0 0 1 1 1v13H3V7a1 1 0 0 1 1-1h4V4a1 1 0 0 1 1-1zm1 2v1h4V5z" />
                        </svg>
                        Office
                    </label>
                </span>
                <span class="aa-type">
                    <asp:RadioButton ID="rbOther" runat="server" GroupName="AddrType" Text="" />
                    <label for="<%= rbOther.ClientID %>">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                        </svg>
                        Other
                    </label>
                </span>
            </div>

            <div class="aa-check">
                <asp:CheckBox ID="chkDefault" runat="server" Text="Make this my default address" />
            </div>

            <div class="aa-divider"></div>

            <asp:ValidationSummary ID="vsAddress" runat="server"
                ValidationGroup="Address"
                DisplayMode="SingleParagraph"
                HeaderText="Please complete the highlighted fields"
                ShowMessageBox="false"
                CssClass="summary-error" />

            <div class="aa-actions">
                <asp:Button ID="btnSave" runat="server"
                    Text="Save Address"
                    CssClass="aa-save"
                    ValidationGroup="Address" />
                <%-- A plain link, so Cancel can never trigger validation. --%>
                <a class="aa-cancel" href="SavedAddresses.aspx">Cancel</a>
            </div>

        </div>

    </div>

    <%-- UI only: the back arrow. Validation belongs to the ASP.NET validators
         above, and this button is type="button" so it never posts back. --%>
    <script type="text/javascript">
        (function () {
            var back = document.getElementById('aaBack');
            if (back) {
                back.onclick = function () { window.location.href = 'SavedAddresses.aspx'; };
            }
        })();
    </script>

</asp:Content>
