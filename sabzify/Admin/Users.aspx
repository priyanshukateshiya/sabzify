<%@ Page Title="Users" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="sabzify.Admin.Users" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="UsersTitle" ContentPlaceHolderID="TitleContent" runat="server">Users</asp:Content>

<asp:Content ID="UsersHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .users-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        .users-page .users-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .users-page .users-title {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .users-page .users-add {
            display: inline-flex;
            align-items: center;
            flex: none;
            gap: 6px;
            height: 30px;
            padding: 0 15px;
            border-radius: 6px;
            background: #1B7A3A;
            font-size: 11px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            white-space: nowrap;
            transition: background-color .15s ease;
        }

        .users-page .users-add:hover,
        .users-page .users-add:focus {
            background: #166A32;
        }

        .users-page .users-add svg {
            width: 11px;
            height: 11px;
        }

        /* Toolbar -------------------------------------------------------------- */
        .users-page .users-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 12px;
        }

        .users-page .users-tools {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .users-page .tool-btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            height: 28px;
            padding: 0 11px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 10.5px;
            color: #374151;
            cursor: pointer;
            transition: border-color .15s ease;
        }

        .users-page .tool-btn:hover,
        .users-page .tool-btn:focus {
            border-color: #1B7A3A;
        }

        .users-page .tool-btn svg {
            width: 11px;
            height: 11px;
            color: #6B7280;
        }

        .users-page .users-count {
            font-size: 10.5px;
            color: #6B7280;
            white-space: nowrap;
        }

        /* Table card ----------------------------------------------------------- */
        .users-page .users-card {
            overflow: hidden;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .users-page .users-table-wrap {
            width: 100%;
        }

        .users-page .users-table {
            width: 100%;
            border-collapse: collapse;
        }

        .users-page .users-table th {
            padding: 10px 14px;
            border-bottom: 1px solid #EDF1F5;
            background: #F7F9F4;
            font-size: 9.5px;
            font-weight: 600;
            text-align: left;
            color: #6B7280;
            white-space: nowrap;
        }

        .users-page .users-table td {
            padding: 12px 14px;
            border-bottom: 1px solid #F3F5F1;
            font-size: 10.5px;
            vertical-align: middle;
            white-space: nowrap;
        }

        .users-page .users-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .users-page .users-table .col-check {
            width: 40px;
            padding-right: 0;
        }

        /* Wide enough for the inline confirm, so opening it never shifts the
           other columns. */
        .users-page .users-table .col-action {
            width: 180px;
            text-align: right;
        }

        .users-page .users-table input[type="checkbox"] {
            display: block;
            width: 13px;
            height: 13px;
            margin: 0;
            accent-color: #1B7A3A;
            cursor: pointer;
        }

        .users-page .user-name {
            font-size: 11px;
            font-weight: 600;
            color: #111827;
        }

        .users-page .user-muted {
            color: #6B7280;
        }

        .users-page .pill {
            display: inline-block;
            padding: 3px 9px;
            border-radius: 999px;
            font-size: 9px;
            font-weight: 600;
            line-height: 1.3;
        }

        .users-page .pill-active {
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .users-page .pill-blocked {
            background: #EDEFF2;
            color: #6B7280;
        }

        /* Block / Unblock and the inline confirm ------------------------------- */
        .users-page .act-btn {
            height: 24px;
            padding: 0 12px;
            border: 1px solid;
            border-radius: 5px;
            background: #fff;
            font-family: inherit;
            font-size: 9.5px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .users-page .act-block {
            border-color: #E8B4B4;
            color: #C0392B;
        }

        .users-page .act-block:hover,
        .users-page .act-block:focus {
            background: #FDF3F3;
        }

        .users-page .act-unblock {
            border-color: #B9D9BE;
            color: #1B7A3A;
        }

        .users-page .act-unblock:hover,
        .users-page .act-unblock:focus {
            background: #F2F9F3;
        }

        .users-page .act-confirm {
            display: none;
            align-items: center;
            justify-content: flex-end;
            gap: 6px;
        }

        .users-page tr.is-confirming .act-confirm {
            display: inline-flex;
        }

        .users-page tr.is-confirming .act-toggle {
            display: none;
        }

        .users-page .act-question {
            font-size: 9.5px;
            font-weight: 600;
            color: #374151;
        }

        .users-page .act-yes,
        .users-page .act-no {
            height: 22px;
            padding: 0 9px;
            border-radius: 5px;
            font-family: inherit;
            font-size: 9.5px;
            font-weight: 600;
            cursor: pointer;
        }

        .users-page .act-yes {
            border: 1px solid #1B7A3A;
            background: #1B7A3A;
            color: #fff;
        }

        .users-page .act-yes:hover,
        .users-page .act-yes:focus {
            background: #166A32;
        }

        .users-page .act-no {
            border: 1px solid #E1E6EA;
            background: #fff;
            color: #374151;
        }

        .users-page .act-no:hover,
        .users-page .act-no:focus {
            background: #F1F5F2;
        }

        @media screen and (max-width: 900px) {
            .users-page .users-header,
            .users-page .users-toolbar {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media screen and (max-width: 700px) {
            .users-page .users-table-wrap {
                overflow-x: auto;
            }

            .users-page .users-table {
                min-width: 760px;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .users-page) {
                padding: 18px 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="UsersBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="users-page">

        <div class="users-header">
            <h1 class="users-title">User Management</h1>
            <a class="users-add" href="AddUser.aspx">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" />
                </svg>
                Add User
            </a>
        </div>

        <div class="users-toolbar">
            <div class="users-tools">
                <button type="button" class="tool-btn">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" />
                    </svg>
                    Filter
                </button>
                <button type="button" class="tool-btn">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M7 4v16M3 8l4-4 4 4M17 20V4M13 16l4 4 4-4" />
                    </svg>
                    Sort
                </button>
            </div>
            <span class="users-count">Showing 2 users</span>
        </div>

        <div class="users-card">
            <div class="users-table-wrap">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th scope="col" class="col-check"><input type="checkbox" id="chkAllUsers" aria-label="Select all users" /></th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Mobile</th>
                            <th scope="col">City</th>
                            <th scope="col">Status</th>
                            <th scope="col" class="col-action">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="col-check"><input type="checkbox" class="row-check" aria-label="Select Kiran Patel" /></td>
                            <td class="user-name">Kiran Patel</td>
                            <td class="user-muted">kiran@email.com</td>
                            <td class="user-muted">+91 98765 43210</td>
                            <td class="user-muted">Rajkot</td>
                            <td><span class="pill pill-active">Active</span></td>
                            <td class="col-action">
                                <button type="button" class="act-btn act-toggle act-block">Block</button>
                                <span class="act-confirm">
                                    <span class="act-question">Block this user?</span>
                                    <button type="button" class="act-yes">Yes</button>
                                    <button type="button" class="act-no">No</button>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="col-check"><input type="checkbox" class="row-check" aria-label="Select Rakesh Sheth" /></td>
                            <td class="user-name">Rakesh Sheth</td>
                            <td class="user-muted">rakesh@email.com</td>
                            <td class="user-muted">+91 91234 56789</td>
                            <td class="user-muted">Rajkot</td>
                            <td><span class="pill pill-blocked">Blocked</span></td>
                            <td class="col-action">
                                <button type="button" class="act-btn act-toggle act-unblock">Unblock</button>
                                <span class="act-confirm">
                                    <span class="act-question">Unblock this user?</span>
                                    <button type="button" class="act-yes">Yes</button>
                                    <button type="button" class="act-no">No</button>
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <%-- UI only (no validation, no postback): select-all, and the inline
         Block/Unblock confirm that flips the row's status pill. --%>
    <script>
        (function () {
            var all = document.getElementById('chkAllUsers');
            var rows = document.querySelectorAll('.users-page .row-check');

            all.addEventListener('change', function () {
                Array.prototype.forEach.call(rows, function (box) {
                    box.checked = all.checked;
                });
            });

            Array.prototype.forEach.call(rows, function (box) {
                box.addEventListener('change', function () {
                    all.checked = Array.prototype.every.call(rows, function (b) { return b.checked; });
                });
            });

            var toggles = document.querySelectorAll('.users-page .act-toggle');
            Array.prototype.forEach.call(toggles, function (btn) {
                var row = btn.closest('tr');
                var pill = row.querySelector('.pill');
                var question = row.querySelector('.act-question');

                btn.addEventListener('click', function () {
                    row.classList.add('is-confirming');
                    row.querySelector('.act-no').focus();
                });

                row.querySelector('.act-no').addEventListener('click', function () {
                    row.classList.remove('is-confirming');
                    btn.focus();
                });

                row.querySelector('.act-yes').addEventListener('click', function () {
                    var block = btn.classList.contains('act-block');
                    pill.textContent = block ? 'Blocked' : 'Active';
                    pill.className = 'pill ' + (block ? 'pill-blocked' : 'pill-active');
                    btn.textContent = block ? 'Unblock' : 'Block';
                    btn.className = 'act-btn act-toggle ' + (block ? 'act-unblock' : 'act-block');
                    question.textContent = block ? 'Unblock this user?' : 'Block this user?';
                    row.classList.remove('is-confirming');
                    btn.focus();
                });
            });
        })();
    </script>
</asp:Content>
