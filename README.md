# CCVolumeHUD
`CCVolumeHUD` changes the default volume HUD for a unobtrusive volume HUD displayed in the status bar.

## Installation
### CocoaPods
* Add `pod 'CCVolumeHUD'` to your Podfile
* Run `pod install`

### Manual
* Drag the `CCVolumeHUD` folder into your project
* Link the `AVFoundation`, `MediaPlayer`, and `QuartzCore` frameworks to your project

## How To Use
* Add `import CCVolumeHUD` in your `AppDelegate` import statements
* On `application:didFinishLaunchingWithOptions:` function, at some point add `CCVolumeHUD.sharedInstance`
* Personalize the volume slider appearance by editing the properties of the [`MPVolumeView`](https://developer.apple.com/library/ios/documentation/MediaPlayer/Reference/MPVolumeView_Class/) named as  `CCVolumeHUD.sharedInstance.volumeView`. For example: `CCVolumeHUD.sharedInstance.volumeView.tintColor = UIColor.redColor()`

## License
This project is under the MIT license (see the LICENSE file for more details).

## Screenshot
![](screenshot.png?raw=true)
