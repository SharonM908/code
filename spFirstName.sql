
CREATE PROCEDURE spFirstName 

	@Param1 VARCHAR(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT FirstName, LastName, MobilePhone
	FROM AddressBook
	WHERE FirstName = @Param1
END
GO
