
<p align="center">
<img src="Assets/Logo.png"  width="170"/>
</p>
<h1 align="center">Zay Pay for iOS</h1>

![iOS](https://img.shields.io/badge/iOS-16.0%2B-blue.svg) [![Xcode](https://img.shields.io/badge/Xcode-14.0%2B-blue.svg)](https://img.shields.io/badge/Xcode-14.1%2B-blue.svg) [![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/onside-io/OnsideKit-iOS/blob/main/LICENSE)

**Seamlessly convert various cryptocurrencies into SOL and send them to any Solana wallet, directly within your iOS app.**

Our SDK is a powerful yet simple-to-use tool for iOS developers, designed to integrate cross-chain swaps into your application. It enables your users to easily top up their Solana wallet with SOL by converting assets they hold on other blockchains like Ethereum, BNB Chain, Polygon, and more. The SDK abstracts away the underlying complexity of cross-chain bridges and DEXs, offering a single, clean Swift API to handle the entire process: from conversion to the final transfer to the destination Solana wallet.

## Key Features
- ⛓️ **Cross-Chain Swaps:** Convert tokens from popular networks (e.g., Ethereum, BNB Chain, Polygon) into SOL.
- 🚀 **Simple API:** A clean and intuitive API written in pure Swift for fast and easy integration.
- 💸 **Direct-to-Wallet:** Automatically sends the converted SOL to any specified Solana wallet, eliminating extra steps for the user.
- 🛡️ **Secure:** Built with security best practices for handling cryptocurrency transactions in mind.
- 🧩 **Flexible:** Supports a wide range of popular tokens for conversion (e.g., USDT, USDC, ETH).

## Why Use Our SDK?
-  **Save Development Time:** No need to deal with the complexities of cross-chain bridges, DEXs, or different blockchain protocols. We handle it for you.
-  **Enhance User Experience (UX):** Allow users to top up their SOL balance without ever leaving your app or relying on third-party services.
-  **Reliable:** We manage the complex blockchain interactions, providing you with a stable and predictable tool to build upon.

## Installation
You can add `ZayPay` to your project using either Swift Package Manager (SPM) or CocoaPods.

### Swift Package Manager (Recommended)
Swift Package Manager is Apple's official dependency manager, integrated directly into Xcode.

1. In Xcode, open your project and navigate to **File** > **Add Packages...**
2. In the search bar that appears, enter the repository URL:
```
https://github.com/zay-me/zaypay-ios-sdk
```
3. Xcode will fetch the package.
4. Click **Add Package**.
5. Select the `ZayPay` library and add it to your app's target.

### CocoaPods
CocoaPods is a widely used dependency manager for iOS projects.

1. If you don't already have a `Podfile` in your project, run `pod init` in your project's root directory.
2. Add the following line to your `Podfile`:
```ruby
pod 'ZayPay'
```
3. Then, run the following command in your terminal from the project's root directory:
```bash
pod install
```
4. Remember to open the `.xcworkspace` file instead of the `.xcodeproj` file after installation.

## Usage
Integration of Zay Pay is designed to be simple and fast. Follow the steps below to get started.

### 1. Import  Framework
First, import `ZayPay` module in the view controller file where you plan to launch the swap UI.
```swift
import ZayPay
```

### 2. Launch the Swap UI
To present the swap interface, call the static method `Zay.launch(...)`. This method handles the entire UI flow. It's best to call it in response to a user action, such as a button tap.

The method signature is:
```swift
Zay.launch(
    in hostViewController: UIViewController,
    apiKey: String,
    withdrawAddress: String
)
```
**Parameters:**
* `hostViewController` (`UIViewController`): The view controller that will present the SDK's interface.
* `apiKey` (`String`): Your unique API key required to use the service.
* `withdrawAddress` (`String`): The destination Solana wallet address where the converted SOL will be sent after a successful swap.

## UI Customization (Theming)
You can customize the color palette of the SDK's user interface to match your application's design system. This is achieved by creating a custom "assets provider" and registering it with the SDK.

This configuration should be done once, early in the application's lifecycle, for example, in your `AppDelegate`'s `application(_:didFinishLaunchingWithOptions:)` or your `SceneDelegate`'s `scene(_:willConnectTo:options:)`.

### How It Works
To create a custom theme, you need to implement two protocols: `ColorsAssetsProvider` and `AssetsProvider`.

1. **`ColorsAssetsProvider`**: This protocol defines the specific colors for various UI elements. You'll create a type (like a `struct`) that provides static `UIColor` properties for each required asset.
2. **`AssetsProvider`**: This protocol acts as a wrapper. It points to your `ColorsAssetsProvider` implementation.

### Step-by-Step Example
Here’s a complete example of how to create and apply a custom theme.
#### 1. Create a Color Provider
First, create a `struct` that conforms to `ColorsAssetsProvider` and define your custom colors.

```swift
import UIKit
import ZayPay

// 1. Define your custom color palette
struct MyAppColors: ColorsAssetsProvider {
    static var backgroundPrimary: UIColor { .systemGroupedBackground }
    static var backgroundSecondary: UIColor { .secondarySystemGroupedBackground }
    static var backgroundTertiary: UIColor { .tertiarySystemGroupedBackground }
    static var backgroundAttention: UIColor { .systemRed }
    static var backgroundAttentionSuccess: UIColor { .systemGreen }

    static var fillPrimary: UIColor { .secondarySystemFill }
    static var fillSecondary: UIColor { .tertiarySystemFill }
    static var fillTertiary: UIColor { .quaternarySystemFill }

    static var textAttention: UIColor { .white }
    static var textAttentionSuccess: UIColor { .white }

    static var outline: UIColor { .separator }
    
    static var buttonPrimary: UIColor { .systemBlue }
}

```

#### 2. Create the Main Assets Provider
Next, create another `struct` that conforms to `AssetsProvider` and link it to your color provider from the previous step.
```swift
// 2. Create the main provider that points to your colors
struct MyAppTheme: AssetsProvider {
    static var colorsAssetsProviderType: ColorsAssetsProvider.Type {
        MyAppColors.self
    }
}
```

#### 3. Apply the Custom Theme
Finally, call `Zay.setAssetsProviderType(_:)` at the start of your app, passing your main theme provider *type*.
```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

func application(_ application: UIApplication, didFinishLaunchingWithOptions  launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // 3. Apply your custom theme to the SDK
    Zay.setAssetsProviderType(MyAppTheme.self)
    return  true
}

// ... other AppDelegate methods

}
```
Now, whenever you launch the `Zay`, it will use the colors defined in `MyAppColors`.

### Color Properties Reference

Here is a brief description of what each color property in the `ColorsAssetsProvider` protocol controls:
|Property|Description|
|--|--|
|`backgroundPrimary`|The main background color of the screens.|
|`backgroundSecondary`|Background for grouped elements.|
|`backgroundTertiary`|A more subtle background color for nested elements.|
|`backgroundAttention`|Background color for error messages or banners.|
|`backgroundAttentionSuccess`|Background color for success messages or banners. |
|`fillPrimary`|Background color for primary input fields.|
|`fillSecondary`|Background color for secondary input fields/views.|
|`fillTertiary`|A more subtle background fill color.|
|`textAttention`|Text color used on top of `backgroundAttention`.|
|`textAttentionSuccess`|Text color used on top of `backgroundAttentionSuccess`. |
|`outline`|Color for separators and borders.|
|`buttonPrimary`|Background color for primary action buttons.|

## License

`Zay Pay` is released under the MIT License. See the [`LICENSE`](https://github.com/zay-me/zaypay-ios-sdk/blob/main/LICENSE) file for more information.