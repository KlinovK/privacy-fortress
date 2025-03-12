# privacy-fortress

## Deep Linking Setup
### URI Scheme
To enable deep linking using a custom URL scheme, update your `Info.plist` file with the following configuration:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>PrivacyFortress</string>
        </array>
        <key>CFBundleURLName</key>
        <string>com.yourcompany.PrivacyFortress</string>
    </dict>
</array>
```
### URI link
Link for test "PrivacyFortress://paywall" URI case
You can setup yours

### Universal Links
To enable universal links, follow these steps:
1. Open Xcode and navigate to **Project → Target (Privacy Fortress) → Signing & Capabilities**.
2. Add **Associated Domains** capability.
3. Update the associated domain. Currently, it's set to:
   ```
   applinks:privacyfortressapp.com
   ```
Update Deep link handling CoreLayer -> Constants -> deepLinkURLPath
Add appflyer dev key and appflyer app ID handling CoreLayer -> Constants -> (appsFlyerDevKey, appleFlyerAppID)
Update App store id if needed CoreLayer -> Constants -> appStoreID
Update product ID if needed CoreLayer -> Constants -> productIdentifier
Update apphudAPIKey if needed CoreLayer -> Constants -> apphudAPIKey
Update termsAndConditionsURLString if needed CoreLayer -> Constants -> termsAndConditionsURLString
Update privacyPolicyURLString if needed CoreLayer -> Constants -> privacyPolicyURLString



