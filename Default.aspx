<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="student_Management.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Student Management System</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    
    <style>
        
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #e0f2fe, #f8fafc);
            margin: 0;
        }

        
        .page-title {
            font-size: 36px;
            font-weight: 800;
            letter-spacing: 1.5px;
            color: #0d6efd;
            text-align: center;
            margin-top: 40px;
            margin-bottom: 60px;
        }

        
        .login-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            padding: 50px;
        }

        
        .btn-animate {
            transition: all 0.3s ease-in-out;
            font-weight: 600;
            letter-spacing: 0.6px;
        }

        .btn-animate:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.25);
        }

        .btn-animate:active {
            transform: scale(0.97);
        }
    </style>
</head>

<body>
<form id="form1" runat="server">


<div class="page-title">
    Student Management System
</div>


<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4 login-card text-center">

            
            <asp:Button ID="btnAdminLogin" runat="server"
                Text="Admin Login"
                CssClass="btn btn-success btn-lg w-100 mb-4 btn-animate"
                OnClick="btnAdminLogin_Click" />

           
            <asp:Button ID="btnStudentLogin" runat="server"
                Text="Student Login"
                CssClass="btn btn-primary btn-lg w-100 btn-animate"
                OnClick="btnStudentLogin_Click" />

        </div>
    </div>
</div>

</form>
</body>
</html>