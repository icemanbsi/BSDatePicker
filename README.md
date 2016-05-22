# BSDatePicker

[![CI Status](http://img.shields.io/travis/Bobby Stenly/BSDatePicker.svg?style=flat)](https://travis-ci.org/Bobby Stenly/BSDatePicker)
[![Version](https://img.shields.io/cocoapods/v/BSDatePicker.svg?style=flat)](http://cocoapods.org/pods/BSDatePicker)
[![License](https://img.shields.io/cocoapods/l/BSDatePicker.svg?style=flat)](http://cocoapods.org/pods/BSDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/BSDatePicker.svg?style=flat)](http://cocoapods.org/pods/BSDatePicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BSDatePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BSDatePicker"
```

## How To Use

First thing first, you need to create the BSDatePicker element. If you are using the storyboard or xib, create a UIButton then change the class name to BSDatePicker and the module to BSDatePicker. Please set the viewController attribute and run the setup function.

```swift
self.bsdFirst.viewController = self
self.bsdFirst.title = "First Date Picker"
self.bsdFirst.defaultTitle = "Default"
self.bsdFirst.setup()
```

## Author

Bobby Stenly, iceman.bsi@gmail.com

## License

BSDatePicker is available under the MIT license. See the LICENSE file for more info.
