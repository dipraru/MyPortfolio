<%@ Page Title="Database Test" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatabaseTest.aspx.cs" Inherits="MyPortfolio.DatabaseTest" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Database Connection Test</h2>
        <p class="lead">This page demonstrates that the database is connected to your portfolio project.</p>
        
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Add Test Data</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="txtName" class="form-label">Name (Primary Key):</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter a unique name"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtAddress" class="form-label">Address:</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter an address"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAdd" runat="server" Text="Add to Database" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
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
                        <h5>Database Records from 'test' table</h5>
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnRefresh_Click" />
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvTestData" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="false" EmptyDataText="No records found in database.">
                            <Columns>
                                <asp:BoundField DataField="name" HeaderText="Name (PK)" />
                                <asp:BoundField DataField="address" HeaderText="Address" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>