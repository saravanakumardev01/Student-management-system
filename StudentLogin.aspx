<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="StudentLogin.aspx.cs"
    Inherits="student_Management.StudentLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Student Login</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        min-height: 100vh;
        background-color: #f3f4f6;
        font-family: Arial, Helvetica, sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .login-card {
        width: 680px;
        padding: 55px 60px;
        background-color: #ffffff;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        text-align: center;
    }

    .login-title {
        font-size: 34px;
        font-weight: bold;
        margin-bottom: 30px;
        color: #111827;
    }

    .form-control {
        width: 100%;
        height: 60px;
        font-size: 18px;
        padding: 0 18px;
        margin-bottom: 18px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
    }

    span[style*="Red"] {
        font-size: 15px;
        display: block;
        margin-bottom: 8px;
    }

    .captcha-text {
        padding: 12px 22px;
        background-color: #e5e7eb;
        border: 1px solid #cbd5e1;
        font-size: 20px;
        font-weight: bold;
        letter-spacing: 4px;
    }

    .btn {
        height: 60px;
        font-size: 20px;
        font-weight: bold;
        border-radius: 6px;
    }
</style>
</head>

<body>
<form id="form1" runat="server">


<div style="position:absolute; top:20px; left:20px;">
    <asp:Button ID="btnBackHome" runat="server"
        Text="← Back"
        CssClass="btn btn-secondary"
        CausesValidation="false"
        OnClick="btnBackHome_Click" />
</div>

<div class="login-card">

    <h3 class="login-title">Student Login</h3>

    <asp:TextBox ID="txtEmail" runat="server"
        CssClass="form-control mb-1"
        placeholder="Email"
        oninput="this.value=this.value.toLowerCase();" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtEmail"
        ErrorMessage="Email is required"
        ForeColor="Red" />

    <asp:TextBox ID="txtPassword" runat="server"
        CssClass="form-control mb-1"
        TextMode="Password"
        placeholder="Password" />

    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtPassword"
        ErrorMessage="Password is required"
        ForeColor="Red" />

    
    <div class="d-flex align-items-center mt-3 mb-3">
        <asp:Label ID="lblCaptcha" runat="server"
            CssClass="fw-bold text-primary me-2 captcha-text"></asp:Label>

        <asp:LinkButton ID="lnkRefreshCaptcha" runat="server"
            CausesValidation="false"
            OnClick="lnkRefreshCaptcha_Click"
            Style="text-decoration:none; font-size:24px;">
            🔄
        </asp:LinkButton>
    </div>

    <asp:TextBox ID="txtCaptcha" runat="server"
        CssClass="form-control mb-4"
        placeholder="Enter Captcha" />

    <asp:Button ID="btnLogin" runat="server"
        Text="Login"
        CssClass="btn btn-primary w-100"
        OnClick="btnLogin_Click" />

</div>

</form>
</body>
</html>