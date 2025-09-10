<%@ Page Title="Another Database Test" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatabaseTest2.aspx.cs" Inherits="MyPortfolio.DatabaseTest2" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Another Database Test - anotherDemo</h2>
        <p class="lead">This page demonstrates connection to the 'anotherDemo' database with 'test2' table.</p>
        
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Add Student Record</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="txtRoll" class="form-label">Roll Number (Primary Key):</label>
                            <asp:TextBox ID="txtRoll" runat="server" CssClass="form-control" placeholder="Enter roll number" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtStudentName" class="form-label">Student Name:</label>
                            <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control" placeholder="Enter student name"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAdd" runat="server" Text="Add Student" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Delete Student Record</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="txtDeleteRoll" class="form-label">Roll Number to Delete:</label>
                            <asp:TextBox ID="txtDeleteRoll" runat="server" CssClass="form-control" placeholder="Enter roll number to delete" TextMode="Number"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete Student" CssClass="btn btn-danger" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh Data" CssClass="btn btn-secondary ms-2" OnClick="btnRefresh_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Database Status</h5>
                    </div>
                    <div class="card-body">
                        <asp:Label ID="lblConnectionStatus" runat="server" CssClass="badge fs-6 mb-3" Text=""></asp:Label>
                        <br />
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-info" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Student Records from 'test2' table</h5>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvStudentData" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="false" EmptyDataText="No student records found in database.">
                            <Columns>
                                <asp:BoundField DataField="roll" HeaderText="Roll Number (PK)" />
                                <asp:BoundField DataField="name" HeaderText="Student Name" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>