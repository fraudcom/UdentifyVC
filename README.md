# UdentifyVC SDK

UdentifyVC is a Swift Package that provides video call functionality. It is designed for seamless integration into iOS applications, offering a simple API to manage video calls.

## 🚀 Features
- Easy integration for video calls
- Handles automatic connection and disconnection

## 📦 Installation

### Swift Package Manager (SPM)
You can install UdentifyVC via Swift Package Manager by adding the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/fraudcom/UdentifyVC.git", from: "x.y.z")
]
```

Or in Xcode:
1. Go to **File > Swift Packages > Add Package Dependency**.
2. Enter the repository URL: `https://github.com/fraudcom/UdentifyVC.git`.
3. Select the desired version and add the package.

## 📖 Usage

### Import UdentifyVC
```swift
import UdentifyVC
import UdentifyCommons
```

### Create an instance variable for Camera Controller
Add the following code to create an instance variable of VCCameraController. `VCCameraController` is a `UIViewController` subclass responsible for managing video calls. It handles user state changes, participant connections, video layout updates, and session lifecycle events:
    
```swift
private var cameraController: VCCameraController?
```

## Initialization

To create an instance of VCCameraController, use:

```swift
let cameraController = VCCameraController(
    delegate: self,
    serverURL: "https://your-server-url.com",
    wsURL: "wss://your-websocket-url.com",
    transactionID: "your-transaction-id",
    username: "your-username",
    idleTimeout: 100,
    settings: VCSettings(...),
    logLevel: .info
)
```

### Parameters:
- **delegate**: A delegate conforming to VCCameraControllerDelegate to receive updates
- **serverURL**: A parameter of type `String` representing the URL of the Udentify server. It specifies the location where the requests will be sent. It should be a valid URL. Ensure that this value is properly configured.
- **wsURL**: The WebSocket URL for Video Call connection
- **transactionID**: A parameter of type `String` representing a Udentify transactionID. It helps in tracking and managing the requests. Make sure that a valid transaction ID is provided.
- **username**: The username of the local participant
- **idleTimeout**: The duration before automatic disconnection of the local participant(aka user) if the remote participant is disconnected (default is 100 seconds)
- **settings**: A VCSettings instance for UI and behavior customization
- **logLevel**: Logging verbosity level

## Delegate Methods

To handle session events, implement VCCameraControllerDelegate:

```swift
extension YourViewController: VCCameraControllerDelegate {
    func cameraController(_ controller: VCCameraController, didChangeUserState state: UserState) {
        print("User state changed: \(state)")
    }

    func cameraController(_ controller: VCCameraController, participantType: ParticipantType, didChangeState state: ParticipantState) {
        print("\(participantType) changed state to \(state)")
    }

    func cameraController(_ controller: VCCameraController, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    func cameraControllerDidDismiss(_ controller: VCCameraController) {
        print("Camera controller dismissed")
    }

    func cameraControllerDidEndSessionSuccessfully(_ controller: VCCameraController) {
        print("Session ended successfully")
    }
}
```

## Enum Definitions

### UserState

Indicates the user's connection status:

```swift
public enum UserState {
    case initiating
    case tokenFetching
    case tokenFetched
    case connecting
    case connected
    case disconnected
    case reconnecting
}
```

### ParticipantType

Represents the type of participant:

```swift
public enum ParticipantType {
    case agent
    case supervisor
}
```

### ParticipantState

Tracks participant connection status:

```swift
public enum ParticipantState {
    case connected
    case videoTrackActivated
    case videoTrackPaused
    case disconnected
}
```

## Methods

### dismissController()

Dismisses the camera controller and ends the session.

```swift
cameraController.dismissController()
```

## UI Customization

The UI is configurable via VCSettings. Example usage:

```swift
// Customize settings for the video call interface
        let customSettings = VCSettings(
            backgroundColor: .white,
            backgroundStyle: UdentifyImageStyle(
                image: UIImage(named: "backgroundImage")!,
                contentMode: .scaleAspectFill,
                opacity: 0.8,
                borderColor: .white,
                borderWidth: 2,
                horizontalSizing: .anchors(leading: 0, trailing: 0),
                verticalSizing: .anchors(top: 0, bottom: 0)
            ),
            overlayImageStyle: UdentifyImageStyle(
                image: UIImage(named: "overlay")!,
                contentMode: .scaleAspectFit,
                opacity: 1.0,
                borderColor: .clear,
                borderWidth: 0,
                horizontalSizing: .fixed(width: 300.0, horizontalPosition: .center),
                verticalSizing: .fixed(height: 200, verticalPosition: .custom(y: 140))
            ),
            muteButtonStyle: VCMuteButtonStyle(
                mutedColor: .red,
                unmutedColor: .white,
                size: 50,
                horizontalPosition: .center,
                verticalPosition: .bottom(offset: 20)
            ),
            cameraSwitchButtonStyle: VCCameraSwitchButtonStyle(
                color: .white,
                size: 55,
                horizontalPosition: .left(offset: 16),
                verticalPosition: .bottom(offset: 20)
            ),
            pipViewStyle: UdentifyViewStyle(
                backgroundColor: .clear,
                borderColor: .white,
                cornerRadius: 10,
                borderWidth: 2,
                horizontalSizing: .fixed(width: 120, horizontalPosition: .right(offset: 16)),
                verticalSizing: .fixed(height: 135, verticalPosition: .bottom(offset: 0))
            ),
            instructionLabelStyle: UdentifyTextStyle(
                font: UIFont.systemFont(ofSize: 18, weight: .bold),
                textColor: .black,
                numberOfLines: 2,
                leading: 25,
                trailing: 25,
                verticalPosition: .bottom(offset: 60)
            ),
            requestTimeout: 60
        )
```
### Parameters:
**bundle (Bundle)**  
- *Description:* The resource bundle used for assets and localized strings.  
- *Default Value:* `.main`

**tableName (String?)**  
- *Description:* Optional name of the localization table (for custom `.strings` files).  
- *Default Value:* `nil`

**backgroundColor (UIColor)**  
- *Description:* Sets the primary background color of the video call interface.  
- *Default Value:* `.black`

**backgroundStyle (UdentifyImageStyle?)**  
- *Description:* Optional configuration for a background image, including its content mode, opacity, border, and corner radius.  
- *Default Value:* Not set (nil)

**overlayImageStyle (UdentifyImageStyle?)**  
- *Description:* Optional configuration for an overlay image (e.g., watermark or decorative image).  
- *Default Value:* Not set (nil)

**muteButtonStyle (VCMuteButtonStyle)**  
- *Description:* Determines the appearance and behavior of the mute button (its color, size, etc.).  
- *Default Value:* A new instance of `VCMuteButtonStyle()`

**cameraSwitchButtonStyle (VCCameraSwitchButtonStyle)**  
- *Description:* Determines the appearance and behavior of the camera switch button (its color, size, etc.).  
- *Default Value:* A new instance of `VCCameraSwitchButtonStyle()`

**pipViewStyle (UdentifyViewStyle)**  
- *Description:* Configures the Picture-in-Picture (PiP) view’s layout and appearance. If not provided, it defaults to a fixed size and bottom-right placement (width: 90, height: 135).  
- *Default Value:* Default PiP configuration (bottom-right, fixed size)

**instructionLabelStyle (UdentifyTextStyle)**  
- *Description:* Sets the style for instructional text labels, including font, text color, alignment, and margins.  
- *Default Value:* A style with a 20-point medium system font, white text, unlimited lines, and 35-point margins

**requestTimeout (Double)**  
- *Description:* Specifies the network request timeout in seconds. If this value differs from `WebService.shared.timeout`, a new instance is created with the updated timeout.  
- *Default Value:* `30` seconds

---

## UdentifyTextStyle

This struct defines the styling options for text.

- **font (UIFont):**  
  The font used for displaying the text.
  
- **textColor (UIColor):**  
  The color applied to the text.
  
- **textAlignment (NSTextAlignment):**  
  The alignment of the text (e.g., center, left, right).  
  *Default:* `.center`
  
- **lineBreakMode (NSLineBreakMode):**  
  The mode that determines how text wraps or truncates.  
  *Default:* `.byWordWrapping`
  
- **numberOfLines (Int):**  
  The maximum number of lines the text can occupy (0 means unlimited).  
  *Default:* `0`
  
- **lineHeightMultiple (CGFloat):**  
  A multiplier to adjust the spacing between lines.
  
- **leading (CGFloat):**  
  The left margin for the text.  
  *Default:* `20`
  
- **trailing (CGFloat):**  
  The right margin for the text.  
  *Default:* `20`
  
- **verticalPosition (UdentifyVerticalPosition?):**  
  Optional vertical positioning for the text (e.g., center, top, bottom).

---

## UdentifyViewStyle

This struct configures the appearance of a view.

- **backgroundColor (UIColor):**  
  The background color of the view.
  
- **borderColor (UIColor):**  
  The color of the view’s border.
  
- **cornerRadius (CGFloat):**  
  The radius used to round the view’s corners.
  
- **borderWidth (CGFloat):**  
  The width of the view’s border. This value is clamped between 0 and 15.
  
- **horizontalSizing (UdentifyHorizontalSizing?):**  
  Optional horizontal sizing and positioning settings.
  
- **verticalSizing (UdentifyVerticalSizing?):**  
  Optional vertical sizing and positioning settings.

---

## UdentifyImageStyle

This struct configures how an image is displayed.

- **image (UIImage):**  
  The image to be displayed.
  
- **contentMode (UIView.ContentMode):**  
  Determines how the image is scaled or resized.  
  *Default:* `.scaleAspectFit`
  
- **opacity (CGFloat):**  
  The transparency of the image, clamped between 0 (fully transparent) and 1 (fully opaque).  
  *Default:* `1.0`
  
- **borderColor (UIColor):**  
  The color of the image’s border.
  
- **borderWidth (CGFloat):**  
  The width of the image’s border, clamped between 0 and 15.
  
- **horizontalSizing (UdentifyHorizontalSizing):**  
  Specifies horizontal sizing and positioning of the image.
  
- **verticalSizing (UdentifyVerticalSizing):**  
  Specifies vertical sizing and positioning of the image.
  
- **cornerRadius (CGFloat):**  
  The radius for rounding the corners of the image.

---

### UdentifyHorizontalSizing

Specifies how an element is sized and positioned horizontally.

- **fixed(width: CGFloat, horizontalPosition: UdentifyHorizontalPosition):**  
  Uses a fixed width with a defined horizontal position.
  
- **anchors(leading: CGFloat, trailing: CGFloat):**  
  Positions the element using leading and trailing anchors.

---

### UdentifyVerticalSizing

Specifies how an element is sized and positioned vertically.

- **fixed(height: CGFloat, verticalPosition: UdentifyVerticalPosition):**  
  Uses a fixed height with a defined vertical position.
  
- **anchors(top: CGFloat, bottom: CGFloat):**  
  Positions the element using top and bottom anchors.

---

### UdentifyHorizontalPosition

Defines horizontal alignment options.

- **center:**  
  Centers the element horizontally.
  
- **left(offset: CGFloat):**  
  Positions the element to the left with a specified offset.
  
- **right(offset: CGFloat):**  
  Positions the element to the right with a specified offset.
  
- **custom(x: CGFloat):**  
  Positions the element at an absolute x-coordinate.

---

### UdentifyVerticalPosition

Defines vertical alignment options.

- **center:**  
  Centers the element vertically.
  
- **top(offset: CGFloat):**  
  Positions the element at the top with a specified offset.
  
- **bottom(offset: CGFloat):**  
  Positions the element at the bottom with a specified offset.
  
- **custom(y: CGFloat):**  
  Positions the element at an absolute y-coordinate.
  

## Connection Flow

1. The controller fetches an access token
2. It connects to the LiveKit room
3. The UI updates based on user state and participants
4. The user can mute/unmute, and interact with video streams
5. Upon session completion or idle timeout, the controller dismisses

## Error Handling

If an error occurs, it is reported through:

```swift
func cameraController(_ controller: VCCameraController, didFailWithError error: Error)
```

## 🔑 Permissions

For the video call feature to work correctly, your app must have permission to access the device’s camera and microphone. To do this, add the following keys to your application’s Info.plist file with appropriate usage descriptions:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera for video calling.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app requires access to the microphone for audio during video calls.</string>
```

## 🛠 Dependencies
- [LiveKit Client SDK for Swift](https://github.com/livekit/client-sdk-swift) - Apache 2.0 License
- [UdentifyCommons](https://github.com/fraudcom/UdentifyCommons.git)

## 📄 License

UdentifyVC is proprietary software. Copyright © 2026 Fraud.com International Ltd. All rights reserved. See the [LICENSE](LICENSE) file for more info.

## 🙏 Third-Party Licenses

This project uses the following third-party libraries:

### LiveKit Client SDK for Swift
- **License:** Apache License 2.0
- **Repository:** [https://github.com/livekit/client-sdk-swift](https://github.com/livekit/client-sdk-swift)
- **Copyright:** © 2024 LiveKit, Inc.

For complete third-party license information, please refer to the respective repositories.
