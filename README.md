create database StudentSystemDB
CREATE TABLE Admin (
    AdminId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL
);

INSERT INTO Admin (Username, Password)
VALUES ('admin01', 'Admin@123');

CREATE PROCEDURE sp_AdminLogin
    @Username VARCHAR(50),
    @Password varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AdminId, Username
    FROM Admin
    WHERE Username = @Username
      AND Password = @Password;
END;
EXEC sp_AdminLogin 'admin01', 'A12345678';

CREATE TABLE Students (
    StudentId INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Password VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    BloodGroup VARCHAR(10),
    RollNo VARCHAR(20),
    Department VARCHAR(50),
    State VARCHAR(50),
    Mobile VARCHAR(15),
    TotalFee DECIMAL(10,2),
    PaidFee DECIMAL(10,2),
    PendingFee AS (TotalFee - PaidFee)
);

select * from Students

CREATE PROCEDURE sp_AddStudent
(
    @Name VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(50),
    @DOB DATE,
    @Gender VARCHAR(10),
    @BloodGroup VARCHAR(10),
    @RollNo VARCHAR(20),
    @Department VARCHAR(50),
    @State VARCHAR(50),
    @Mobile VARCHAR(15),
    @TotalFee DECIMAL(10,2),
    @PaidFee DECIMAL(10,2)
)
AS
BEGIN
    INSERT INTO Students
    (Name, Email, Password, DOB, Gender, BloodGroup, RollNo, Department, State, Mobile, TotalFee, PaidFee)
    VALUES
    (@Name, @Email, @Password, @DOB, @Gender, @BloodGroup, @RollNo, @Department, @State, @Mobile, @TotalFee, @PaidFee)
END



CREATE PROCEDURE sp_GetStudents
AS
BEGIN
    SELECT 
        StudentId,
        Name,
        Email,
        RollNo,
        Gender,
        Department AS Course,
        State,
        Mobile,
        TotalFee,
        PaidFee,
        PendingFee
    FROM Students
END

CREATE PROCEDURE sp_UpdateStudent
(
    @StudentId INT,
    @Name VARCHAR(100),
    @Email VARCHAR(100),
    @RollNo VARCHAR(20),
    @Gender VARCHAR(10),
    @Department VARCHAR(200),
    @State VARCHAR(50),
    @Mobile VARCHAR(15),
    @TotalFee DECIMAL(10,2),
    @PaidFee DECIMAL(10,2)
)
AS
BEGIN
    UPDATE Students
    SET Name=@Name,
        Email=@Email,
        RollNo=@RollNo,
        Gender=@Gender,
        Department=@Department,
        State=@State,
        Mobile=@Mobile,
        TotalFee=@TotalFee,
        PaidFee=@PaidFee
    WHERE StudentId=@StudentId
END

CREATE PROCEDURE sp_DeleteStudent
(
    @StudentId INT
)
AS
BEGIN
    DELETE FROM Students WHERE StudentId=@StudentId
END



EXEC sp_GetStudents;
