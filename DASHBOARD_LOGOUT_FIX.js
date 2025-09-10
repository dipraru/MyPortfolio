// Quick fix for Dashboard.aspx logout functionality
// Find the handleLogout function and replace the redirect URL

// Original problematic line in the JavaScript:
// window.location.href = 'admin-login.html';

// Should be changed to:
// window.location.href = '../admin_login.aspx';

// This maintains all your styling while fixing the logout functionality