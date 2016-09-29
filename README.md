# Ti.OnePassword

Support for the AgileBits [1Password App Extention](https://github.com/AgileBits/onepassword-app-extension) in Titanium Mobile to open 1Password for selecting credentials.

<img src="https://abload.de/img/img_965973ke9.png" height="375" alt="1Password with Titanium" />

Features
---------------
- [x] Check if 1Password is installed and can be used
- [x] Receive login credentials from 1Password
- [x] Store login credentials in 1Password
- [x] Change login credentials in 1Password

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

Request login credentials from 1Password:
```js
OnePassword.findLoginForURLString({
    url: "https://appcelerator.com",
    callback: function(e) {
        // Check if the operation succeeded
        if (!e.success) {
            alert("Login could not be received: " + e.error);
            return;
        }

        // Success - Prefill the form fields
        usernameField.setValue(e.credentials.username);
        passwordField.setValue(e.credentials.password);
    }
});
```
Add a new login to 1Password:
```js
OnePassword.storeLoginForURLString({
    url: "https://appcelerator.com",
    credentials: {
        username: "my_username",
        password: "my_password"
    },
    options: {
        password_min_length: 6,
        password_max_length: 18
    },
    callback: function(e) {
        if (!e.success) {
            alert("Credentials could not be added to 1Password: " + e.error);
            return;
        }

        // Success
    }
});
```
Change an existing login in 1Password:
```js
OnePassword.changePasswordForLoginForURLString({
    url: "https://appcelerator.com",
    credentials: {
        username: "my_username",
        password: "my_new_password"
    },
    options: {
        password_min_length: 6,
        password_max_length: 18
    },
    callback: function(e) {
        if (!e.success) {
            alert("Credentials could not be added to 1Password: " + e.error);
            return;
        }

        // Success
    }
});

#### Available credentials
- [x] url_string
- [x] username
- [x] password
- [x] totp
- [x] login_title
- [x] notes
- [x] section_title
- [x] fields
- [x] returned_fields
- [x] old_password
- [x] password_generator_options

#### Available options
- [x] password_min_length
- [x] password_max_length
- [x] password_require_digits
- [x] password_require_symbols
- [x] password_forbidden_characters

Example
---------------
Check `example/app.js` for a basic example.

Author
---------------
Hans Knoechel ([@hansemannnn](https://twitter.com/hansemannnn) / [Web](http://hans-knoechel.de))

License
---------------
Apache 2.0

Contributing
---------------
Code contributions are greatly appreciated, please submit a new [pull request](https://github.com/hansemannn/ti.onepassword/pull/new/master)!

