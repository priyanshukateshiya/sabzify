<%@ Page Title="Edit Category" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditCategory.aspx.cs" Inherits="sabzify.Admin.EditCategory" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="EditCategoryTitle" ContentPlaceHolderID="TitleContent" runat="server">Edit Category</asp:Content>

<asp:Content ID="EditCategoryHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .editcat-page. --%>
    <style>
        .editcat-page .editcat-bar {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: -24px -28px 26px;
            padding: 14px 28px;
            border-bottom: 1px solid #E8EDF2;
            background: #fff;
        }

        .editcat-page .back-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            border: 0;
            border-radius: 6px;
            background: none;
            font-family: inherit;
            font-size: 17px;
            line-height: 1;
            color: #374151;
            cursor: pointer;
        }

        .editcat-page .back-btn:hover,
        .editcat-page .back-btn:focus {
            background: #F1F5F2;
        }

        .editcat-page .bar-title {
            margin: 0;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
        }

        .editcat-page .bar-sub {
            margin: 2px 0 0;
            font-size: 10.5px;
            line-height: 1.3;
            color: #6B7280;
        }

        /* Form card ------------------------------------------------------------ */
        .editcat-page .editcat-card {
            max-width: 560px;
            margin: 0 auto;
            padding: 26px;
            border: 1px solid #EDF1F5;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .editcat-page .field {
            margin-bottom: 18px;
        }

        .editcat-page .field label {
            display: block;
            margin-bottom: 6px;
            font-size: 11px;
            font-weight: 600;
            color: #374151;
        }

        .editcat-page .field input,
        .editcat-page .field textarea,
        .editcat-page .field select {
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

        .editcat-page .field input,
        .editcat-page .field select {
            height: 38px;
            padding: 0 12px;
        }

        .editcat-page .field textarea {
            min-height: 84px;
            padding: 10px 12px;
            line-height: 1.5;
            resize: vertical;
        }

        .editcat-page .field input::placeholder,
        .editcat-page .field textarea::placeholder {
            color: #9CA3AF;
        }

        .editcat-page .field input:focus,
        .editcat-page .field textarea:focus,
        .editcat-page .field select:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Dropdown with its own chevron. */
        .editcat-page .select-wrap {
            position: relative;
        }

        .editcat-page .field select {
            padding-right: 34px;
            -webkit-appearance: none;
            appearance: none;
            cursor: pointer;
        }

        .editcat-page .select-wrap svg {
            position: absolute;
            top: 50%;
            right: 12px;
            width: 14px;
            height: 14px;
            transform: translateY(-50%);
            color: #374151;
            pointer-events: none;
        }

        /* Validators use Display="Dynamic": no space until shown, and they sit
           under their control, so they never touch the button row. */
        .editcat-page .field-error {
            display: block;
            margin-top: 4px;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        .editcat-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input,
        .editcat-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea {
            border-color: #C0392B;
        }

        .editcat-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input:focus,
        .editcat-page .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) textarea:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        .editcat-page .editcat-divider {
            height: 1px;
            margin: 22px 0 18px;
            border: 0;
            background: #F1F3EF;
        }

        .editcat-page .summary-error {
            margin: 0 0 12px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
            text-align: right;
        }

        .editcat-page .summary-error:empty {
            display: none;
        }

        .editcat-page .editcat-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
        }

        .editcat-page .btn-cancel {
            height: 34px;
            padding: 0 10px;
            border: 0;
            border-radius: 6px;
            background: none;
            font-family: inherit;
            font-size: 12px;
            color: #6B7280;
            cursor: pointer;
        }

        .editcat-page .btn-cancel:hover,
        .editcat-page .btn-cancel:focus {
            color: #111827;
            background: #F1F5F2;
        }

        .editcat-page .save-wrap {
            position: relative;
            display: inline-flex;
        }

        .editcat-page .save-wrap svg {
            position: absolute;
            top: 50%;
            left: 18px;
            width: 13px;
            height: 13px;
            transform: translateY(-50%);
            color: #fff;
            pointer-events: none;
        }

        .editcat-page .btn-save {
            height: 34px;
            padding: 0 18px 0 37px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 12px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .editcat-page .btn-save:hover,
        .editcat-page .btn-save:focus {
            background: #166A32;
        }

        @media screen and (max-width: 700px) {
            .editcat-page .editcat-card {
                max-width: none;
            }
        }

        @media screen and (max-width: 600px) {
            .editcat-page .editcat-bar {
                margin: -18px -16px 22px;
                padding: 12px 16px;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .editcat-page) {
                padding: 18px 14px;
            }

            .editcat-page .editcat-bar {
                margin: -18px -14px 20px;
                padding: 12px 14px;
            }

            .editcat-page .editcat-card {
                padding: 20px 16px;
            }

            .editcat-page .editcat-actions {
                flex-direction: column-reverse;
                align-items: stretch;
                gap: 8px;
            }

            .editcat-page .save-wrap,
            .editcat-page .btn-save,
            .editcat-page .btn-cancel {
                width: 100%;
            }

            .editcat-page .save-wrap {
                justify-content: center;
            }

            .editcat-page .save-wrap svg {
                left: calc(50% - 56px);
            }

            .editcat-page .btn-save {
                padding: 0 18px 0 37px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="EditCategoryBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="editcat-page">

        <div class="editcat-bar">
            <button type="button" class="back-btn" onclick="window.location.href='Categories.aspx'" aria-label="Back to categories" title="Back to categories">&#8592;</button>
            <div>
                <h1 class="bar-title">Edit Category</h1>
                <p class="bar-sub">Update category details and catalog visibility</p>
            </div>
        </div>

        <div class="editcat-card">

            <div class="field">
                <asp:Label ID="lblCategoryName" runat="server" AssociatedControlID="txtCategoryName" Text="Category Name" />
                <asp:TextBox ID="txtCategoryName" MaxLength="50" runat="server" placeholder="e.g., Leafy Greens (Rajkot Local)" autocomplete="off" />
                <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ControlToValidate="txtCategoryName"
                    Text="Category name is required" ValidationGroup="Category" Display="Dynamic"
                    CssClass="field-error" SetFocusOnError="true" />
                <asp:RegularExpressionValidator ID="revCategoryName" runat="server" ControlToValidate="txtCategoryName"
                    ValidationExpression="^(?=.{2,50}$)(?!.*\s{2})[A-Za-z0-9(][A-Za-z0-9 &()\-]*[A-Za-z0-9)]$"
                    Text="Use letters, numbers, spaces and - &amp; ( ) only" ValidationGroup="Category" Display="Dynamic"
                    CssClass="field-error" SetFocusOnError="true" />
            </div>

            <div class="field">
                <asp:Label ID="lblDescription" runat="server" AssociatedControlID="txtDescription" Text="Description" />
                <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" TextMode="MultiLine" Rows="4"
                    placeholder="Briefly describe the types of vegetables in this category." />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                    Text="Description is required" ValidationGroup="Category" Display="Dynamic"
                    CssClass="field-error" SetFocusOnError="true" />
                <asp:RegularExpressionValidator ID="revDescription" runat="server" ControlToValidate="txtDescription"
                    ValidationExpression="^[\s\S]{10,200}$"
                    Text="Description must be 10&#8211;200 characters" ValidationGroup="Category" Display="Dynamic"
                    CssClass="field-error" SetFocusOnError="true" />
            </div>

            <div class="field">
                <asp:Label ID="lblStatus" runat="server" AssociatedControlID="ddlStatus" Text="Status" />
                <div class="select-wrap">
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Text="Active" Value="Active" Selected="True" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polyline points="6 9 12 15 18 9" />
                    </svg>
                </div>
            </div>

            <hr class="editcat-divider" />

            <asp:ValidationSummary ID="vsCategory" runat="server" ValidationGroup="Category"
                DisplayMode="SingleParagraph" HeaderText="Please complete the highlighted fields"
                ShowMessageBox="false" CssClass="summary-error" />

            <div class="editcat-actions">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel"
                    CausesValidation="false" UseSubmitBehavior="false"
                    PostBackUrl="~/Admin/Categories.aspx" />
                <span class="save-wrap">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z" /><polyline points="17 21 17 13 7 13 7 21" /><polyline points="7 3 7 8 15 8" />
                    </svg>
                    <asp:Button ID="btnSaveCategory" runat="server" Text="Save Changes" CssClass="btn-save"
                        ValidationGroup="Category" OnClick="btnSaveCategory_Click" />
                </span>
            </div>

        </div>

    </div>

    <script>
        (function () {
            var link = document.querySelector('.admin-shell .adm-nav a[href="Categories.aspx"]');
            if (link) {
                link.classList.add('is-active');
                link.setAttribute('aria-current', 'page');
            }
        })();
    </script>
</asp:Content>
