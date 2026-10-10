/* ============================================================================
   Sabzify - PROPOSED MIGRATION 01: foreign-key index coverage
   ----------------------------------------------------------------------------
   STATUS: OPTIONAL. Nothing in the current schema is broken, and no feature is
   blocked without this file. Every table in SabzifyDatabase currently holds
   between 0 and 48 rows, so none of these indexes changes a query plan today.

   WHY IT EXISTS AT ALL
   SQL Server indexes the PARENT side of a foreign key automatically (the PK or
   UNIQUE constraint it points at). It never indexes the CHILD side. Nine of the
   seventeen foreign keys in this database therefore have no usable index on the
   referencing column, which costs a full table scan in two situations:

     a) deleting or updating a PARENT row - SQL Server must prove no child row
        references it (NO_ACTION), or find every child row to remove (CASCADE);
     b) joining child to parent in a list screen.

   Each index below is created ONLY if absent, is non-unique, non-filtered,
   adds no constraint, and rejects no data that is accepted today. Dropping any
   of them later restores the present state exactly.

   TARGET: SQL Server 2025 (17.0), database compatibility level 170.
   Syntax used (CREATE NONCLUSTERED INDEX, sys.indexes guard) is valid on
   SQL Server 2008 and later, so it is safe if this database is ever restored
   to an older instance.

   SAFETY: no DROP, no ALTER COLUMN, no RENAME, no DELETE, no UPDATE, no new
   constraint. Read the per-index note before running any single statement.
   ============================================================================ */

SET NOCOUNT ON;
GO

/* ---------------------------------------------------------------------------
   1. Addresses.UserId          FK_Addresses_Users          ON DELETE CASCADE
   Addresses.UserId already has IX_Addresses_UserId, but that index is FILTERED
   to WHERE IsActive = 1. A filtered index cannot serve the cascade, because the
   cascade must also find the user's IsActive = 0 rows. This unfiltered index is
   what the CASCADE actually needs; the existing filtered one stays for the
   SavedAddresses list query, which only ever wants active rows.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.Addresses')
                 AND name = N'IX_Addresses_UserId_All')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Addresses_UserId_All
        ON dbo.Addresses (UserId);
END
GO

/* ---------------------------------------------------------------------------
   2. CartItems.ProductId       FK_CartItems_Products       ON DELETE NO_ACTION
   Deleting or deactivating a product must verify that no cart line references
   it. Without this index that check scans CartItems every time.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.CartItems')
                 AND name = N'IX_CartItems_ProductId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_CartItems_ProductId
        ON dbo.CartItems (ProductId);
END
GO

/* ---------------------------------------------------------------------------
   3. WishlistItems.ProductId   FK_WishlistItems_Products   ON DELETE NO_ACTION
   Same reason as CartItems. UQ_WishlistItems_UserProduct leads on UserId, so it
   cannot serve a lookup by ProductId alone.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.WishlistItems')
                 AND name = N'IX_WishlistItems_ProductId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_WishlistItems_ProductId
        ON dbo.WishlistItems (ProductId);
END
GO

/* ---------------------------------------------------------------------------
   4. Payments.UserId           FK_Payments_Users           ON DELETE NO_ACTION
   The highest-value index in this file. Admin/Payments.aspx renders a "User
   Name" column per ledger row, which means Payments -> Users on every row, and
   a customer delete must check Payments.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.Payments')
                 AND name = N'IX_Payments_UserId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Payments_UserId
        ON dbo.Payments (UserId);
END
GO

/* ---------------------------------------------------------------------------
   5. OrderStatusHistory.ChangedByAdminUserId
                                FK_OrderStatusHistory_Admin ON DELETE NO_ACTION
   Deactivating or removing an administrator must check this column. It is also
   the only audit link from a status change back to the admin who made it, so an
   "actions by admin X" query would use this index.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.OrderStatusHistory')
                 AND name = N'IX_OrderStatusHistory_AdminUserId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_OrderStatusHistory_AdminUserId
        ON dbo.OrderStatusHistory (ChangedByAdminUserId);
END
GO

/* ---------------------------------------------------------------------------
   6. Orders.DeliveryAddressId  FK_Orders_Addresses         ON DELETE NO_ACTION
   An address cannot be deleted while an order points at it. Note the schema is
   already correct here: Orders also stores DeliveryAddress as a flat snapshot,
   so a past order keeps its shipping text even if the address row is retired.
   This index only speeds the referential check.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.Orders')
                 AND name = N'IX_Orders_DeliveryAddressId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Orders_DeliveryAddressId
        ON dbo.Orders (DeliveryAddressId);
END
GO

/* ---------------------------------------------------------------------------
   7. Orders.PaymentMethodId    FK_Orders_PaymentMethods    ON DELETE NO_ACTION
   8. Payments.PaymentMethodId  FK_Payments_PaymentMethods  ON DELETE NO_ACTION
   Lowest value of the set: PaymentMethods holds one row and no admin screen can
   delete a payment method. Included for completeness so that all seventeen
   foreign keys have child-side index coverage. Skip both if you prefer to add
   only indexes that a real query needs.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.Orders')
                 AND name = N'IX_Orders_PaymentMethodId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Orders_PaymentMethodId
        ON dbo.Orders (PaymentMethodId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'dbo.Payments')
                 AND name = N'IX_Payments_PaymentMethodId')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Payments_PaymentMethodId
        ON dbo.Payments (PaymentMethodId);
END
GO

PRINT N'Proposed migration 01 complete: foreign-key index coverage.';
GO
