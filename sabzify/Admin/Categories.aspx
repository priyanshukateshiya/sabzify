<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="sabzify.Admin.Categories" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="CategoriesTitle" ContentPlaceHolderID="TitleContent" runat="server">Categories</asp:Content>

<asp:Content ID="CategoriesHead" ContentPlaceHolderID="HeadContent" runat="server">
    <%-- Page-scoped styles; every selector starts with .cat-page (the one
         exception reaches the master's main area to change its padding). --%>
    <style>
        .cat-page .cat-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 18px;
        }

        .cat-page .cat-title {
            margin: 0 0 5px;
            font-size: 21px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .cat-page .cat-sub {
            margin: 0;
            font-size: 11.5px;
            color: #6B7280;
        }

        .cat-page .cat-btn {
            display: inline-flex;
            align-items: center;
            flex: none;
            gap: 6px;
            height: 32px;
            padding: 0 16px;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            white-space: nowrap;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .cat-page .cat-btn:hover,
        .cat-page .cat-btn:focus {
            background: #166A32;
        }

        .cat-page .cat-btn svg {
            width: 12px;
            height: 12px;
        }

        /* Table card ------------------------------------------------------------ */
        .cat-page .cat-card {
            overflow: hidden;
            border: 1px solid #EDF1F5;
            border-radius: 9px;
            background: #fff;
            box-shadow: 0 1px 3px rgba(17, 24, 39, .04);
        }

        .cat-page .cat-table-wrap {
            width: 100%;
        }

        .cat-page .cat-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cat-page .cat-table th {
            padding: 11px 18px;
            border-bottom: 1px solid #EDF1F5;
            background: #F7F9F4;
            font-size: 10px;
            font-weight: 600;
            text-align: left;
            color: #6B7280;
            white-space: nowrap;
        }

        .cat-page .cat-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #F3F5F1;
            vertical-align: middle;
        }

        .cat-page .cat-table tbody tr:last-child td {
            border-bottom: 0;
        }

        .cat-page .cat-table .col-name { width: 22%; }
        .cat-page .cat-table .col-desc { width: 42%; }
        .cat-page .cat-table .col-status { width: 18%; }
        .cat-page .cat-table .col-actions { width: 18%; }

        .cat-page .cat-name {
            font-size: 12.5px;
            font-weight: 600;
            color: #111827;
        }

        .cat-page .cat-desc {
            max-width: 260px;
            font-size: 11px;
            line-height: 1.6;
            color: #6B7280;
        }

        .cat-page .pill {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 9.5px;
            font-weight: 600;
            line-height: 1.3;
        }

        .cat-page .pill-active {
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .cat-page .pill-inactive {
            background: #F1F3F5;
            color: #6B7280;
        }

        .cat-page .actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cat-page .icon-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 2px;
            border: 0;
            border-radius: 4px;
            background: none;
            color: #6B7280;
            cursor: pointer;
            transition: color .15s ease;
        }

        .cat-page .icon-btn svg {
            display: block;
            width: 14px;
            height: 14px;
        }

        .cat-page .icon-edit:hover,
        .cat-page .icon-edit:focus {
            color: #1B7A3A;
        }

        .cat-page .icon-delete:hover,
        .cat-page .icon-delete:focus {
            color: #C0392B;
        }

        /* Inline delete confirmation (replaces the icons in that row). */
        .cat-page .confirm {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 6px 8px;
            font-size: 11px;
            color: #374151;
        }

        .cat-page .confirm[hidden],
        .cat-page .actions[hidden] {
            display: none;
        }

        .cat-page .confirm-text {
            font-weight: 600;
            color: #C0392B;
            white-space: nowrap;
        }

        .cat-page .confirm-btn {
            height: 24px;
            padding: 0 10px;
            border: 1px solid #E1E6EA;
            border-radius: 5px;
            background: #fff;
            font-family: inherit;
            font-size: 10.5px;
            font-weight: 600;
            color: #374151;
            cursor: pointer;
        }

        .cat-page .confirm-yes {
            border-color: #C0392B;
            background: #C0392B;
            color: #fff;
        }

        .cat-page .confirm-yes:hover {
            background: #A93226;
        }

        .cat-page .confirm-no:hover {
            background: #F7F9FA;
        }

        /* Empty state ----------------------------------------------------------- */
        .cat-page .cat-empty {
            padding: 44px 20px;
            text-align: center;
        }

        .cat-page .cat-empty[hidden] {
            display: none;
        }

        .cat-page .cat-empty-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 0 auto 12px;
            border-radius: 50%;
            background: #DFF5E3;
            color: #1B7A3A;
        }

        .cat-page .cat-empty-icon svg {
            width: 20px;
            height: 20px;
        }

        .cat-page .cat-empty-title {
            margin: 0 0 14px;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        @media screen and (max-width: 900px) {
            .cat-page .cat-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }

        @media screen and (max-width: 700px) {
            .cat-page .cat-table-wrap {
                overflow-x: auto;
            }

            .cat-page .cat-table {
                min-width: 620px;
            }
        }

        @media screen and (max-width: 480px) {
            .admin-shell .adm-main:has(> .cat-page) {
                padding: 18px 14px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="CategoriesBody" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="cat-page">

        <div class="cat-header">
            <div>
                <h1 class="cat-title">Category Management</h1>
                <p class="cat-sub">Manage your product categories, organize inventory, and control visibility.</p>
            </div>
            <a class="cat-btn" href="AddCategory.aspx">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" />
                </svg>
                Add New Category
            </a>
        </div>

        <div class="cat-card">
            <div class="cat-table-wrap" id="catTableWrap">
                <table class="cat-table">
                    <thead>
                        <tr>
                            <th scope="col" class="col-name">Category Name</th>
                            <th scope="col" class="col-desc">Description</th>
                            <th scope="col" class="col-status">Status</th>
                            <th scope="col" class="col-actions">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="catRows">
                        <tr>
                            <td class="cat-name">Vegetables</td>
                            <td><div class="cat-desc">Fresh from farm, daily arrivals of seasonal vegetables.</div></td>
                            <td><span class="pill pill-active">Active</span></td>
                            <td>
                                <div class="actions">
                                    <button type="button" class="icon-btn icon-edit" aria-label="Edit Vegetables" title="Edit">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 20h9" /><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg>
                                    </button>
                                    <button type="button" class="icon-btn icon-delete" aria-label="Delete Vegetables" title="Delete">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="3 6 5 6 21 6" /><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" /><path d="M10 11v6M14 11v6" /><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2" /></svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="cat-name">Organic</td>
                            <td><div class="cat-desc">Pesticide free, certified organic produce.</div></td>
                            <td><span class="pill pill-active">Active</span></td>
                            <td>
                                <div class="actions">
                                    <button type="button" class="icon-btn icon-edit" aria-label="Edit Organic" title="Edit">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 20h9" /><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg>
                                    </button>
                                    <button type="button" class="icon-btn icon-delete" aria-label="Delete Organic" title="Delete">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="3 6 5 6 21 6" /><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" /><path d="M10 11v6M14 11v6" /><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2" /></svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="cat-name">Root Vegetables</td>
                            <td><div class="cat-desc">Direct harvest potatoes, carrots, onions, and garlic.</div></td>
                            <td><span class="pill pill-inactive">Inactive</span></td>
                            <td>
                                <div class="actions">
                                    <button type="button" class="icon-btn icon-edit" aria-label="Edit Root Vegetables" title="Edit">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 20h9" /><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" /></svg>
                                    </button>
                                    <button type="button" class="icon-btn icon-delete" aria-label="Delete Root Vegetables" title="Delete">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="3 6 5 6 21 6" /><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" /><path d="M10 11v6M14 11v6" /><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2" /></svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="cat-empty" id="catEmpty" hidden="hidden">
                <div class="cat-empty-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z" /><line x1="7" y1="7" x2="7.01" y2="7" />
                    </svg>
                </div>
                <p class="cat-empty-title">No categories yet</p>
                <a class="cat-btn" href="AddCategory.aspx">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true">
                        <line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" />
                    </svg>
                    Add New Category
                </a>
            </div>
        </div>

    </div>

    <%-- UI only (no validation, no postback): edit navigates, delete asks inline
         and removes the row, and the empty state shows when no rows are left. --%>
    <script>
        (function () {
            var rows = document.getElementById('catRows');

            function confirmBlock() {
                var box = document.createElement('div');
                box.className = 'confirm';
                box.innerHTML = '<span class="confirm-text">Delete this category?</span>' +
                    '<button type="button" class="confirm-btn confirm-yes">Yes</button>' +
                    '<button type="button" class="confirm-btn confirm-no">No</button>';
                return box;
            }

            rows.addEventListener('click', function (e) {
                var btn = e.target.closest('button');
                if (!btn) {
                    return;
                }
                var row = btn.closest('tr');
                var actions = row.querySelector('.actions');

                if (btn.classList.contains('icon-edit')) {
                    window.location.href = 'AddCategory.aspx';
                } else if (btn.classList.contains('icon-delete')) {
                    actions.hidden = true;
                    var box = row.querySelector('.confirm');
                    if (!box) {
                        box = confirmBlock();
                        actions.parentNode.appendChild(box);
                    }
                    box.hidden = false;
                    box.querySelector('.confirm-no').focus();
                } else if (btn.classList.contains('confirm-no')) {
                    row.querySelector('.confirm').hidden = true;
                    actions.hidden = false;
                    actions.querySelector('.icon-delete').focus();
                } else if (btn.classList.contains('confirm-yes')) {
                    row.parentNode.removeChild(row);
                    if (!rows.querySelector('tr')) {
                        document.getElementById('catTableWrap').hidden = true;
                        document.getElementById('catEmpty').hidden = false;
                    }
                }
            });
        })();
    </script>
</asp:Content>
