<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MessagesSection.ascx.cs" Inherits="MyPortfolio.Admin.Sections.MessagesSection" %>

<!-- Messages Page -->
<div class="page" id="messages-page" style="display: none;">
    <div class="page-header">
        <h1 class="page-title">Messages Management</h1>
        <p class="page-subtitle">View and manage contact form submissions.</p>
    </div>
    
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">All Messages</h2>
            <div class="tabs">
                <button class="tab active" data-tab="all">All Messages</button>
                <button class="tab" data-tab="unread">Unread</button>
                <button class="tab" data-tab="read">Read</button>
            </div>
        </div>
        
        <div class="tab-content active" id="all-tab">
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="allMessagesTableBody">
                        <!-- Messages will be loaded here from server via AJAX -->
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 40px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                                <div style="margin-top: 10px; color: var(--text-secondary);">Loading messages...</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="tab-content" id="unread-tab">
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="unreadMessagesTableBody">
                        <!-- Unread messages will be loaded here -->
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                                <div style="margin-top: 10px; color: var(--text-secondary);">Loading messages...</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="tab-content" id="read-tab">
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="readMessagesTableBody">
                        <!-- Read messages will be loaded here -->
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                                <div style="margin-top: 10px; color: var(--text-secondary);">Loading messages...</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('MessagesSection: DOM loaded');
});

function loadMessages() {
    console.log('Loading messages...');
    const allMessagesBody = document.getElementById('allMessagesTableBody');
    if (!allMessagesBody) {
        console.error('Messages table body not found');
        return;
    }

    // Show loading state
    allMessagesBody.innerHTML = `
        <tr>
            <td colspan="6" style="text-align: center; padding: 40px;">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary);"></i>
                <div style="margin-top: 10px; color: var(--text-secondary);">Loading messages...</div>
            </td>
        </tr>
    `;

    // First test connection
    fetch('/Admin/Dashboard.aspx/TestMessagesConnection', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('Connection test response received:', response);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log('Connection test data:', data);
        const result = JSON.parse(data.d);
        
        if (result.success) {
            console.log('Connection test successful, loading messages...');
            // Connection works, now load messages
            loadActualMessages();
        } else {
            console.error('Connection test failed:', result.message);
            allMessagesBody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                        <div style="color: var(--text-secondary); margin-bottom: 15px;">Database Setup Required</div>
                        <div style="color: var(--text-tertiary); font-size: 0.9rem; margin-bottom: 20px;">${result.message}</div>
                        <div style="color: var(--text-tertiary); font-size: 0.9rem;">
                            Please run the CreateMessagesTable.sql script in SQL Server Management Studio to set up the Messages table.
                        </div>
                    </td>
                </tr>
            `;
        }
    })
    .catch(error => {
        console.error('Error testing connection:', error);
        allMessagesBody.innerHTML = `
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                    <div style="color: var(--text-secondary);">Error testing database connection. Please check console for details.</div>
                </td>
            </tr>
        `;
    });
}

function loadActualMessages() {
    const allMessagesBody = document.getElementById('allMessagesTableBody');
    
    // Make AJAX call to get messages
    fetch('/Admin/Dashboard.aspx/GetAllMessagesData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify({})
    })
    .then(response => {
        console.log('Messages response received:', response);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log('Messages data:', data);
        const result = JSON.parse(data.d);
        
        if (result.success) {
            allMessagesBody.innerHTML = result.messagesHtml;
            console.log('Messages loaded successfully');
            
            // Separate messages by read status for tabs
            separateMessagesByStatus();
        } else {
            console.error('Error loading messages:', result.message);
            allMessagesBody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                        <div style="color: var(--text-secondary);">Error loading messages: ${result.message}</div>
                    </td>
                </tr>
            `;
        }
    })
    .catch(error => {
        console.error('Error loading messages:', error);
        allMessagesBody.innerHTML = `
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: var(--danger); margin-bottom: 10px;"></i>
                    <div style="color: var(--text-secondary);">Error loading messages. Please try again.</div>
                </td>
            </tr>
        `;
    });
}

function separateMessagesByStatus() {
    const allMessages = document.querySelectorAll('#allMessagesTableBody tr[data-message-id]');
    const unreadBody = document.getElementById('unreadMessagesTableBody');
    const readBody = document.getElementById('readMessagesTableBody');
    
    if (!unreadBody || !readBody) return;
    
    let unreadHtml = '';
    let readHtml = '';
    
    allMessages.forEach(row => {
        const statusElement = row.querySelector('.message-status');
        if (statusElement) {
            const isUnread = statusElement.classList.contains('status-unread');
            const rowClone = row.cloneNode(true);
            
            // Remove status column for tab views
            const statusCell = rowClone.querySelector('td:nth-child(4)');
            if (statusCell) statusCell.remove();
            
            if (isUnread) {
                unreadHtml += rowClone.outerHTML;
            } else {
                readHtml += rowClone.outerHTML;
            }
        }
    });
    
    unreadBody.innerHTML = unreadHtml || `
        <tr>
            <td colspan="5" style="text-align: center; padding: 40px;">
                <i class="fas fa-envelope-open" style="font-size: 2rem; color: var(--text-tertiary); margin-bottom: 10px;"></i>
                <div style="color: var(--text-secondary);">No unread messages</div>
            </td>
        </tr>
    `;
    
    readBody.innerHTML = readHtml || `
        <tr>
            <td colspan="5" style="text-align: center; padding: 40px;">
                <i class="fas fa-envelope" style="font-size: 2rem; color: var(--text-tertiary); margin-bottom: 10px;"></i>
                <div style="color: var(--text-secondary);">No read messages</div>
            </td>
        </tr>
    `;
}

// Load messages when the messages page is shown
function showMessagesPage() {
    console.log('Showing messages page');
    loadMessages();
}

// Export function for dashboard navigation
window.showMessagesPage = showMessagesPage;
window.loadMessages = loadMessages;
</script>

<style>
.message-status {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 0.85rem;
    font-weight: 500;
}

.status-unread {
    background-color: rgba(var(--primary-rgb), 0.1);
    color: var(--primary);
}

.status-read {
    background-color: rgba(var(--success-rgb), 0.1);
    color: var(--success);
}

.status-unread i {
    color: var(--primary);
}

.status-read i {
    color: var(--success);
}

.tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}

.tab {
    padding: 8px 16px;
    border: none;
    background: transparent;
    color: var(--text-secondary);
    cursor: pointer;
    border-radius: 6px;
    transition: all 0.3s ease;
    font-weight: 500;
}

.tab:hover {
    background-color: var(--bg-secondary);
    color: var(--text-primary);
}

.tab.active {
    background-color: var(--primary);
    color: white;
}

.tab-content {
    display: none;
}

.tab-content.active {
    display: block;
}
</style>