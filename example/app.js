var OnePassword = require("ti.onepassword");
var available = OnePassword.isAppExtensionAvailable();

var win = Ti.UI.createWindow({
    backgroundColor: "#fff"
});

var btn = Ti.UI.createButton({
    title: available ? "Get appcelerator.com credentials" : "1Password not available",
    enabled: available
});

btn.addEventListener("click", function() {
    OnePassword.findLoginForURLString({
        url: "https://appcelerator.com",
        callback: function(e) {
            // Check if the operation succeeded
            if (!e.success) {
                alert("Login could not be received: " + e.error);
                return;
            }
            
            Ti.API.info(JSON.stringify(e));

            // Prefill the form fields
            // usernameField.setValue(e.username);
            // passwordField.setValue(e.password);
        }
    });
});

win.add(btn);
win.open();
