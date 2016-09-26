# Ti.OnePassword

Support for the AgileBits [1Password App Extention](https://github.com/AgileBits/onepassword-app-extension) in Titanium Mobile to open 1Password for selecting credentials.

Features
---------------
- [x] Check if 1Password is installed and can be used
- [x] Receive the login credentials from 1Password

Usage
---------------
Add the following url-scheme to the `<plist>` section of your `tiapp.xml` like this:

```xml
<ios>
    <plist>
        <dict>
            <key>LSApplicationQueriesSchemes</key>
            <array>
            <string>org-appextension-feature-password-management</string>
            </array>
        </dict>
    </plist>
</ios>
```

Require the module:
```js
var OnePassword = require("ti.onepassword");
```

Check if the application supports the 1Password App Extension to show/hide a custom 1Password button:
```js
var isAvailable = OnePassword.isAppExtensionAvailable();
```

Request login credentials from 1Password asynchronously:
```js
OnePassword.findLoginForURLString({
    url: "https://appcelerator.com",
    callback: function(e) {
        // Check if the operation succeeded
        if (!e.success) {
            alert("Login could not be received: " + e.error);
            return;
        }

        // Prefill the form fields
        usernameField.setValue(e.username);
        passwordField.setValue(e.password);
    }
});
```

Example
---------------
Check `example/app.js` for a full example.

Author
---------------
Hans Knoechel ([@hansemannnn](https://twitter.com/hansemannnn) / [Web](http://hans-knoechel.de))

License
---------------
Apache 2.0

Contributing
---------------
Code contributions are greatly appreciated, please submit a new [pull request](https://github.com/hansemannn/ti.onepassword/pull/new/master)!

