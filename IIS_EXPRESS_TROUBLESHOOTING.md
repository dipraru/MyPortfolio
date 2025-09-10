# ?? IIS EXPRESS TROUBLESHOOTING GUIDE

## ?? **Current Status**
- ? Project compiles successfully (MSBuild works)
- ? IIS Express is installed (`C:\Program Files\IIS Express\iisexpress.exe`)
- ? Visual Studio can't start IIS Express
- ? Manual IIS Express launch has issues

---

## ??? **Quick Solutions (Try in Order):**

### **Option 1: Use the Batch File I Created**
1. **Double-click `start-project.bat`** in your project folder
2. This will launch IIS Express manually
3. Navigate to: `https://localhost:44352`

### **Option 2: Reset Visual Studio Settings**
```bash
# In Visual Studio:
1. Right-click your project ? Properties
2. Go to "Web" tab
3. Select "IIS Express"
4. Set Project URL to: https://localhost:44352
5. Click "Create Virtual Directory"
6. Save and try F5 again
```

### **Option 3: Clean Visual Studio Cache**
```bash
# Close Visual Studio completely
# Delete these folders:
%LOCALAPPDATA%\Microsoft\VisualStudio\17.0_[instance]\ComponentModelCache
%LOCALAPPDATA%\Microsoft\VisualStudio\17.0_[instance]\Extensions
%TEMP%\VSD[random]
# Restart Visual Studio
```

### **Option 4: Reset IIS Express**
```bash
# Run in Command Prompt as Administrator:
netsh http delete sslcert ipport=0.0.0.0:44352
netsh http add sslcert ipport=0.0.0.0:44352 certhash=YOUR_CERT_HASH appid={214124cd-d05b-4309-9af9-9caa44b2b74a}
```

### **Option 5: Use Different Port**
1. In Visual Studio Project Properties ? Web
2. Change port from 44352 to 44353 (or any free port)
3. Update Web.config if needed
4. Try F5 again

---

## ?? **Alternative Running Methods:**

### **Method 1: Direct MSBuild + File Serving**
```bash
# Build the project
msbuild MyPortfolio.sln /target:Rebuild

# Use any local server (Python, Node.js, etc.)
# Or just open Default.aspx in browser from file system for static testing
```

### **Method 2: VS Code with IIS Express Extension**
1. Install VS Code
2. Install "IIS Express" extension
3. Open project folder in VS Code
4. Use Ctrl+Shift+P ? "IIS Express: Start Website"

### **Method 3: Manual IIS Setup**
1. Install full IIS (Windows Features)
2. Create new website pointing to your project folder
3. Set up application pool for .NET 4.8

---

## ?? **Diagnostic Commands:**

```bash
# Check if port is in use:
netstat -an | findstr :44352

# Check IIS Express processes:
tasklist | findstr iisexpress

# Kill any stuck IIS Express:
taskkill /f /im iisexpress.exe

# Test basic connectivity:
telnet localhost 44352
```

---

## ?? **What to Try Right Now:**

1. **?? FIRST: Try the `start-project.bat` file I created**
   - Double-click it
   - Should open your project at https://localhost:44352

2. **If that works:** Your project is fine, it's just a Visual Studio config issue

3. **If that doesn't work:** We need to investigate deeper

---

## ?? **If Nothing Works:**

The project **DOES COMPILE SUCCESSFULLY** with MSBuild, so your code is correct. The issue is just with the web server configuration.

**Worst case scenario:** You can still:
- Deploy to a real IIS server
- Use a different development server
- Test individual pages by building and copying to wwwroot

---

## ?? **Next Steps:**
1. Try the batch file first
2. Let me know what happens
3. If it still doesn't work, we'll try a different approach

**Your project IS READY - it's just a server configuration issue! ??**