<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AddStudent.aspx.cs"
    Inherits="student_Management.AddStudent" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add / Edit Student</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #f8f9fa);
        }
        .card {
            background: linear-gradient(180deg, #ffffff, #f1f5f9);
            border-radius: 10px;
        }
    </style>

    <script type="text/javascript">
        function isNumber(evt) {
            var charCode = evt.which ? evt.which : evt.keyCode;
            if (charCode < 48 || charCode > 57)
                return false;
            return true;
        }

        function SingleCheck(chk) {
            var checkboxes = chk.parentNode.getElementsByTagName("input");
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i] !== chk) {
                    checkboxes[i].checked = false;
                }
            }
        }
    </script>
</head>

<body>
<form id="form1" runat="server">

<div class="container mt-4">
<div class="row justify-content-center">
<div class="col-md-10 card shadow p-4">

<h4 class="text-center mb-4">Student Details</h4>

<div class="row">

<div class="col-md-6">

<asp:TextBox ID="txtName" runat="server" CssClass="form-control mb-1"
    placeholder="Student Name" MaxLength="15" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
    ErrorMessage="Name is required" ForeColor="Red" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtName"
    ValidationExpression="^[A-Za-z]{3,15}$"
    ErrorMessage="Enter min 3 and max 15 and no space alphabets only"
    ForeColor="Red" />

<asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-1"
    placeholder="Email" oninput="this.value=this.value.toLowerCase();" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
    ErrorMessage="Email is required" ForeColor="Red" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
    ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$"
    ErrorMessage="Invalid email" ForeColor="Red" />

<asp:TextBox ID="txtPassword" runat="server" CssClass="form-control mb-1"
    TextMode="Password" placeholder="Password" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
    ErrorMessage="Password required" ForeColor="Red" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword"
    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$"
    ErrorMessage="Weak password" ForeColor="Red" />

<asp:TextBox ID="txtDOB" runat="server" CssClass="form-control mb-1"
    TextMode="Date" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtDOB"
    ErrorMessage="DOB required" ForeColor="Red" />

<label class="fw-bold mt-2 d-block text-start">Gender</label>
<asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
    <asp:ListItem>Male</asp:ListItem>
    <asp:ListItem>Female</asp:ListItem>
</asp:RadioButtonList>
<asp:RequiredFieldValidator runat="server" ControlToValidate="rblGender"
    ErrorMessage="Select gender" ForeColor="Red" />

</div>

<div class="col-md-6">

<label class="fw-bold">Course</label>
<asp:CheckBoxList ID="cblCourse" runat="server">
    <asp:ListItem>.Net</asp:ListItem>
    <asp:ListItem>Java</asp:ListItem>
    <asp:ListItem>Python</asp:ListItem>
    <asp:ListItem>Data Science</asp:ListItem>
</asp:CheckBoxList>


<asp:TextBox ID="txtRoll" runat="server"
    CssClass="form-control mb-1"
    placeholder="Roll Number"
    MaxLength="4"
    onkeypress="return isNumber(event)" />

<asp:RequiredFieldValidator runat="server"
    ControlToValidate="txtRoll"
    ErrorMessage="Roll required"
    ForeColor="Red" />

<asp:RegularExpressionValidator runat="server"
    ControlToValidate="txtRoll"
    ValidationExpression="^[A-Za-z0-9]{3,15}$"
    ErrorMessage="Alphanumeric only"
    ForeColor="Red" />

<asp:CustomValidator 
    ID="cvRollDuplicate"
    runat="server"
    ControlToValidate="txtRoll"
    ErrorMessage="Roll number already exists"
    ForeColor="Red"
    OnServerValidate="cvRollDuplicate_ServerValidate" />

<asp:DropDownList ID="ddlState" runat="server" CssClass="form-control mb-1">
    <asp:ListItem Value="">Select State</asp:ListItem>
    <asp:ListItem>Karnataka</asp:ListItem>
    <asp:ListItem>Maharashtra</asp:ListItem>
    <asp:ListItem>Tamil Nadu</asp:ListItem>
    <asp:ListItem>Kerala</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator runat="server" ControlToValidate="ddlState"
    InitialValue="" ErrorMessage="Select state" ForeColor="Red" />

<asp:TextBox ID="txtMobile" runat="server" CssClass="form-control mb-1"
    placeholder="Mobile" MaxLength="10"
    onkeypress="return isNumber(event)" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtMobile"
    ErrorMessage="Mobile required" ForeColor="Red" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtMobile"
    ValidationExpression="^[0-9]{10}$"
    ErrorMessage="10 digits required" ForeColor="Red" />

<asp:TextBox ID="txtTotalFee" runat="server" CssClass="form-control mb-1"
    placeholder="Total Fee" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtTotalFee"
    ErrorMessage="Total fee required" ForeColor="Red" />

<asp:TextBox ID="txtPaidFee" runat="server" CssClass="form-control mb-1"
    placeholder="Paid Fee" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaidFee"
    ErrorMessage="Paid fee required" ForeColor="Red" />

</div>
</div>

<div class="row mt-4 text-center">
    <div class="col-md-3">
        <asp:Button ID="btnSave" runat="server" Text="Save"
            CssClass="btn btn-success px-4"
            OnClick="btnSave_Click" />
    </div>
    <div class="col-md-3">
        <asp:Button ID="btnReset" runat="server" Text="Reset"
            CssClass="btn btn-warning px-4"
            CausesValidation="false"
            OnClick="btnReset_Click" />
    </div>
    <div class="col-md-3">
        <asp:Button ID="btnViewStudents" runat="server" Text="View Students"
            CssClass="btn btn-primary px-4"
            CausesValidation="false"
            OnClick="btnViewStudents_Click" />
    </div>
    <div class="col-md-3">
        <asp:Button ID="btnHome" runat="server" Text="Home"
            CssClass="btn btn-dark px-4"
            CausesValidation="false"
            OnClick="btnHome_Click" />
    </div>
</div>

</div>
</div>
</div>

</form>
</body>
</html>