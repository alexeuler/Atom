# Atom

[![CI Status](http://img.shields.io/travis/Alexey Karasev/Atom.svg?style=flat)](https://travis-ci.org/Alexey Karasev/Atom)
[![Version](https://img.shields.io/cocoapods/v/Atom.svg?style=flat)](http://cocoapods.org/pods/Atom)
[![License](https://img.shields.io/cocoapods/l/Atom.svg?style=flat)](http://cocoapods.org/pods/Atom)
[![Platform](https://img.shields.io/cocoapods/p/Atom.svg?style=flat)](http://cocoapods.org/pods/Atom)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Description

### State

State is the minimal required data to reconstruct the whole state of the app. State is constructed
to be as close to view model as possible

### Event

Event is the simple change of state

### Action

Action emits one or more events. Every state change is made by actions
 
### Props

Props are the viewmodel required to render a view (including that of viewcontroller)

### Transformers

Transform state into props. The simpiest transformer just selects a part of the state relevant for 
 the current view.
 

## Installation

Atom is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Atom"
```

## Author

Alexey Karasev, karasev.alexey@gmail.com

## License

Atom is available under the MIT license. See the LICENSE file for more info.
