<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Toast.ascx.cs" Inherits="MyPortfolio.Admin.Controls.Toast" %>

<!-- Toast Notification -->
<div class="toast" id="toast">
    <div class="toast-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <div class="toast-message">
        <div class="toast-title">Success</div>
        <div class="toast-description">Your action was completed successfully.</div>
    </div>
    <button class="toast-close" type="button" aria-label="Close notification">
        <i class="fas fa-times"></i>
    </button>
</div>