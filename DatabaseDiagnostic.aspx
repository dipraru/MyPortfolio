<%@ Page Title="Database Diagnostic" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatabaseDiagnostic.aspx.cs" Inherits="MyPortfolio.DatabaseDiagnostic" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Database Connection Diagnostic</h2>
        <p class="lead">This page helps diagnose database connection issues.</p>
        
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Connection Tests</h5>
                    </div>
                    <div class="card-body">
                        <asp:Button ID="btnTestSQLServer" runat="server" Text="Test SQL Server Connection" CssClass="btn btn-primary me-2" OnClick="btnTestSQLServer_Click" />
                        <asp:Button ID="btnTestDemo" runat="server" Text="Test Demo Database" CssClass="btn btn-secondary me-2" OnClick="btnTestDemo_Click" />
                        <asp:Button ID="btnTestAnotherDemo" runat="server" Text="Test AnotherDemo Database" CssClass="btn btn-info me-2" OnClick="btnTestAnotherDemo_Click" />
                        <asp:Button ID="btnCreateAnotherDemo" runat="server" Text="Force Create AnotherDemo" CssClass="btn btn-warning" OnClick="btnCreateAnotherDemo_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Test Results</h5>
                    </div>
                    <div class="card-body">
                        <asp:Label ID="lblResults" runat="server" Text="Click a test button to see results..." CssClass="text-info"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-3">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Connection Strings</h5>
                    </div>
                    <div class="card-body">
                        <strong>Demo Database:</strong><br />
                        <code><asp:Label ID="lblDemoConnection" runat="server"></asp:Label></code><br /><br />
                        <strong>AnotherDemo Database:</strong><br />
                        <code><asp:Label ID="lblAnotherDemoConnection" runat="server"></asp:Label></code>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>