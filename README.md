# KeyChainManager


**KeychainManager** is a Swift library that provides a convenient way to securely store and retrieve data in the keychain. It allows you to save and retrieve email and password values associated with unique keys. The library utilizes the Security framework to interact with the keychain.

**Installation**

**Swift Package Manager**

The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding KeyChainManager as a dependency is as easy as adding it to the dependencies value of your Package.swift.
```
dependencies: [
    .package(url: "https://github.com/abbasjoyia99/KeyChainManager.git", .upToNextMajor(from: "2.0.0"))
]
```

**Manually**

If you prefer not to use any of the aforementioned dependency managers, you can integrate KeychainManager into your project manually.

1 Download zip file\
2 Open KeyChainManager/Sources/KeyChainManager\
3 Drag and drop KeyChainManager.swift file into project


**Usage**

To use the **KeychainManager** library, follow these steps:

1 Import the **KeychainManager** module in the file where you want to use it:

```
import KeychainManager
```
**Generic Data**

### Saving Generic Data

To save data securely in the keychain, use the `saveData(data:forKey:)` method:

```swift
let keychain = KeychainManager.shared
let email = "user@example.com"

// Save the email securely in the keychain
let success = keychain.saveData(data: email, forKey: "userEmail")

if success {
    print("Email saved successfully.")
} else {
    print("Failed to save email.")
}
```

### Retrieving Generic Data

To retrieve data from the keychain, use the `getData(type:forKey:)` method:

```swift
let keychain = KeychainManager.shared

// Retrieve the saved email from the keychain
if let email: String = keychain.getData(type: String.self, forKey: "userEmail") {
    print("Retrieved email: \(email)")
} else {
    print("Email not found in the keychain.")
}
```

### Updating Generic Data

To update existing data in the keychain, use the `updateData(data:forKey:)` method:

```swift
let keychain = KeychainManager.shared
let newEmail = "newuser@example.com"

// Update the email in the keychain
let success = keychain.updateData(data: newEmail, forKey: "userEmail")

if success {
    print("Email updated successfully.")
} else {
    print("Failed to update email.")
}
```

### Deleting Generic Data

To delete data from the keychain, use the `deleteData(forKey:)` method:

```swift
let keychain = KeychainManager.shared

// Delete the email from the keychain
let success = keychain.deleteData(forKey: "userEmail")

if success {
    print("Email deleted successfully.")
} else {
    print("Failed to delete email.")
}
```
<!--**String**-->
2 Save data securely in the keychain:

```
let key = "emailKey"
let email = "example@example.com"

let success = KeychainManager.shared.saveEmail(email: email, forKey: key)
if success {
    print("Email saved successfully!")
} else {
    print("Failed to save email.")
}

```

3 Retrieve data securely from the keychain:

```
let key = "emailKey"

if let email = KeychainManager.shared.getEmail(forKey: key) {
    print("Retrieved email: \(email)")
} else {
    print("Email not found in the keychain.")
}

```
4 Update data in the keychain:

```
let key = "emailKey"
let newEmail = "new@example.com"

let success = KeychainManager.shared.updateEmail(newEmail: newEmail, forKey: key)
if success {
    print("Email updated successfully!")
} else {
    print("Failed to update email.")
}

```

5 Delete data from the keychain::

```
let key = "emailKey"

let success = KeychainManager.shared.deleteEmail(forKey: key)
if success {
    print("Email deleted successfully!")
} else {
    print("Failed to delete email.")
}
```

**API Reference**

The **KeychainManager** class provides the following methods:

**saveEmail(email: String, forKey: String) -> Bool:** Saves the specified email securely in the keychain.

**savePassword(password: String, forKey: String) -> Bool:** Saves the specified password securely in the keychain.

**getEmail(forKey: String) -> String?:** Retrieves the specified email securely from the keychain.

**getPassword(forKey: String) -> String?:** Retrieves the specified password securely from the keychain.

**updateEmail(newEmail: String, forKey: String) -> Bool:** Updates the specified email securely in the keychain.

**updatePassword(newPassword: String, forKey: String) -> Bool:** Updates the specified password securely in the keychain.

**deleteEmail(forKey: String) -> Bool:** Deletes the specified email securely from the keychain.

**deletePassword(forKey: String) -> Bool:** Deletes the specified password securely from the keychain.


**Requirements**

iOS 9.0+ / macOS 10.12+ / tvOS 9.0+ / watchOS 2.0+

Xcode 11.0+

Swift 5.0+

## Contributing 
Contributions, issues, and feature requests are welcome! See [Contributors](https://github.com/abbasjoyia99/KeyChainManager/graphs/contributors) for details.

###Contributions
Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

### Show your Support
<!--Give a star if this project helped you.-->


**Contact**

abbasjoyia99@gmail.com

