# MyPortfolio Admin System Guide

## ?? Overview
Your portfolio now has a complete single-page admin dashboard that maintains all your existing frontend styles while adding powerful backend functionality.

## ?? File Structure

### Frontend Files (Unchanged Styling)
- **`Default.aspx`** - Main portfolio page with your existing beautiful design
- **`admin_login.aspx`** - Admin login page with your theme integration
- **`Admin/Dashboard.aspx`** - Single-page admin dashboard with all management features

### Backend Files (Updated Functionality)
- **`admin_login.aspx.cs`** - Handles authentication using AuthHelper
- **`Admin/Dashboard.aspx.cs`** - Manages all CRUD operations
- **`Helpers/AuthHelper.cs`** - Secure authentication system
- **`CreatePortfolioTables.sql`** - Database setup script

### Designer Files (Auto-generated)
- **`admin_login.aspx.designer.cs`** - Server control declarations
- **`Admin/Dashboard.aspx.designer.cs`** - Dashboard control declarations

## ?? Admin Login System

### Default Credentials
- **Username:** `admin`
- **Password:** `admin123`

### Features
- Session-based authentication
- Remember me functionality
- Secure logout
- Theme toggle (matches your portfolio)
- Responsive design

### To Change Credentials
Edit `Helpers/AuthHelper.cs`:
```csharp
private const string AdminUsername = "your_username"; 
private const string AdminPassword = "your_password";
```

## ??? Admin Dashboard Features

### Single-Page Navigation
The dashboard includes all management features in one file:
- **Dashboard Overview** - Statistics and quick actions
- **Projects Management** - Add, edit, delete projects
- **Skills Management** - Manage technical skills with proficiency levels
- **Achievements Management** - Competitive programming achievements
- **Messages Management** - View contact form submissions

### Key Functionality
1. **Projects:** Title, description, technologies, GitHub URL, demo URL
2. **Skills:** Name, proficiency level (1-100), category
3. **Achievements:** Contest name, position, year, description
4. **Messages:** Contact form submissions with read/unread status

## ??? Database Setup

### 1. Create Database Tables
Run the `CreatePortfolioTables.sql` script in SQL Server Management Studio:
```sql
-- This creates all necessary tables with sample data
```

### 2. Connection String
Your `Web.config` already has the connection string:
```xml
<add name="DefaultConnection" 
     connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MyPortfolioDB;..." />
```

### 3. Tables Created
- **Projects** - Portfolio projects with GitHub/demo links
- **Skills** - Technical skills with proficiency levels
- **Achievements** - Competition results and awards
- **ContactMessages** - Contact form submissions
- **AdminUsers** - Admin user management (future enhancement)

## ?? How to Use

### 1. Admin Access
1. Navigate to `/admin_login.aspx`
2. Login with credentials (admin/admin123)
3. Access the dashboard at `/Admin/Dashboard.aspx`

### 2. Managing Content
- **Add Projects:** Fill the form and click "Add Project"
- **Add Skills:** Enter skill name, level (1-100), and category
- **Add Achievements:** Contest details with position and year
- **View Messages:** See contact form submissions

### 3. Security Features
- Session timeout (30 minutes)
- Automatic redirect if not authenticated
- Secure logout
- Input validation

## ?? Frontend Integration

### Maintained Styling
- All your existing CSS styles are preserved
- Dark/Light theme toggle works across all pages
- Responsive design maintained
- Professional admin interface that matches your portfolio

### Future Enhancements
The `Default.aspx.cs` is ready for database integration:
```csharp
// Future method to load dynamic content from database
// private void LoadDynamicContent()
// {
//     // Load projects, skills, achievements from database
// }
```

## ?? Customization

### Adding New Features
1. Add new sections to `Admin/Dashboard.aspx`
2. Update the navigation in the sidebar
3. Add corresponding methods in `Dashboard.aspx.cs`
4. Create new database tables as needed

### Styling Changes
- Modify CSS in each individual file
- All styles are self-contained
- No external stylesheets to maintain

## ?? Responsive Design
- Desktop: Full sidebar navigation
- Tablet/Mobile: Collapsible hamburger menu
- Touch-friendly interface
- Optimized forms for all screen sizes

## ??? Security Considerations

### Current Implementation
- Session-based authentication
- Input validation
- SQL injection protection (parameterized queries)
- XSS protection

### Production Recommendations
1. Use proper password hashing (bcrypt)
2. Implement HTTPS
3. Add CSRF protection
4. Use database user authentication
5. Enable logging and monitoring

## ?? Support

The system is now ready to use! All your existing frontend designs are preserved while adding powerful admin functionality.

### File Locations for Your Code
- **Single Admin Dashboard:** `Admin/Dashboard.aspx` - Put all your admin HTML/CSS/JS here
- **Login Page:** `admin_login.aspx` - Your login frontend goes here
- **Main Portfolio:** `Default.aspx` - Your main portfolio frontend

The backend functionality is already integrated and working with your beautiful frontend designs!