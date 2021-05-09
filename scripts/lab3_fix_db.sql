use db_artem;
 
-- Add a new column '[NewColumnName]' to table '[TableName]' in schema '[dbo]'
ALTER TABLE building
    ADD test /*new_column_name*/ int /*new_column_datatype*/ NULL /*new_column_nullability*/
GO

ALTER TABLE building
    ALTER COLUMN test VARCHAR(50);
GO

ALTER TABLE building 
    ALTER COLUMN test FLOAT NOT NULL
GO

-- Drop '[ColumnName]' from table '[TableName]' in schema '[dbo]'
ALTER TABLE building
    DROP COLUMN test
GO

ALTER TABLE employee
    ADD test /*new_column_name*/ CHAR /*new_column_datatype*/
GO

ALTER TABLE employee
    ALTER COLUMN test date;
GO

ALTER TABLE employee 
    ALTER COLUMN test VARCHAR(50) NOT NULL
GO

-- Drop '[ColumnName]' from table '[TableName]' in schema '[dbo]'
ALTER TABLE employee
    DROP COLUMN test
GO

-- Add a new column '[NewColumnName]' to table '[TableName]' in schema '[dbo]'
ALTER TABLE room_to_excursion
    ADD date_excursion /*new_column_name*/ date /*new_column_datatype*/ NULL /*new_column_nullability*/
GO

ALTER TABLE room_to_excursion
    ALTER COLUMN date_excursion date NOT NULL
GO

