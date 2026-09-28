IF OBJECT_ID(N'dbo.usuario', N'U') IS NULL
    THROW 50000, 'Expected table dbo.usuario was not found.', 1;

IF COL_LENGTH(N'dbo.usuario', N'VCHPASSWORD') IS NULL
    THROW 50001, 'Expected column dbo.usuario.VCHPASSWORD was not found.', 1;

DECLARE @passwordColumnLength INT;
SELECT @passwordColumnLength = max_length
FROM sys.columns
WHERE object_id = OBJECT_ID(N'dbo.usuario')
  AND name = N'VCHPASSWORD';

IF @passwordColumnLength < 512
BEGIN
    DECLARE @isNullable BIT;
    SELECT @isNullable = is_nullable
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'dbo.usuario')
      AND name = N'VCHPASSWORD';

    DECLARE @alterColumn NVARCHAR(MAX) =
        N'ALTER TABLE dbo.usuario ALTER COLUMN VCHPASSWORD NVARCHAR(256) ' +
        CASE WHEN @isNullable = 1 THEN N'NULL' ELSE N'NOT NULL' END + N';';

    EXEC sys.sp_executesql @alterColumn;
END;
