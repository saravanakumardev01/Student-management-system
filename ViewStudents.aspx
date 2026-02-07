<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ViewStudents.aspx.cs"
    Inherits="student_Management.ViewStudents" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>View Students</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

<div class="container mt-4">

    
    <div class="d-flex align-items-center mb-3">
        <asp:Button ID="btnBack" runat="server"
            Text="← Back"
            CssClass="btn btn-secondary"
            OnClick="btnBack_Click" />

        <div class="flex-grow-1 text-center">
            <h4 class="mb-0">Students List</h4>
        </div>

        <asp:Button ID="btnLogout" runat="server"
            Text="Logout"
            CssClass="btn btn-danger"
            OnClick="btnLogout_Click" />
    </div>

    
  <asp:GridView ID="gvStudents" runat="server"
    CssClass="table table-bordered table-striped"
    AutoGenerateColumns="False"
    DataKeyNames="StudentId"
    OnRowCommand="gvStudents_RowCommand"
    OnRowDeleting="gvStudents_RowDeleting">

    <Columns>

        <asp:BoundField DataField="StudentId" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="Password" HeaderText="Password" />
        <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
        <asp:BoundField DataField="Gender" HeaderText="Gender" />
        <asp:BoundField DataField="Department" HeaderText="Department" />
        <asp:BoundField DataField="State" HeaderText="State" />
        <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
        <asp:BoundField DataField="TotalFee" HeaderText="Total Fee" />
        <asp:BoundField DataField="PaidFee" HeaderText="Paid Fee" />
        <asp:BoundField DataField="PendingFee" HeaderText="Pending Fee" ReadOnly="True" />

 
        <asp:ButtonField
            Text="Edit"
            CommandName="EditStudent"
            ButtonType="Button"
            ControlStyle-CssClass="btn btn-primary btn-sm" />

        
        <asp:CommandField
            ShowDeleteButton="True"
            DeleteText="Delete"
            ControlStyle-CssClass="btn btn-danger btn-sm" />

    </Columns>
</asp:GridView>


</div>

</form>
</body>
</html>