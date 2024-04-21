# pgs-helper-swift
A swift project to work with PGS subtitle format commonly found on bluray discs.

Main usage is decoding PGS (metadata and bitmap pictures), then use Apple machine learning to recognize text in images to produce SubRip (SRT) files.

# Usage

TODO

# Dev notes

## Xcode integration

Xcode integration is actually fairly limited in this project. Only workspace view is here.

## Swift CLI integration

Build, test and run is done throw swift CLI.

On all library projects :

```
swift build
swift test
```

On the executable project :

```
swift build
swift test
swift run
```

## Supported platform

Excluding BitmapToText, Core and Cli packages, all package can run on any platform supported by swift.

BitmapToText use Apple Technologies ([Framework "Vision"](https://developer.apple.com/documentation/vision)) to recognize text in images, restricting
usage to Apple platform only (iOS 11.0+, macOS 10.13+, Mac Catalyst 13.0+, tvOS 11.0+ and visionOS 1.0+).

# Reference documentations

## Core projects

### [SUP/PGS specification (blog post)](https://blog.thescorpius.com/index.php/2017/07/15/presentation-graphic-stream-sup-files-bluray-subtitle-format/)

### [SUP/PGS specification (patent information)](https://encrypted.google.com/patents/US20090185789?cl=da)

### [Run-length encoding specification (patent information)](https://patents.google.com/patent/US7912305)

## Swift (multi-platform)

### [Swift Programming Language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)

### [Swift package manager](https://www.swift.org/documentation/package-manager/)

### [Swift Argument Parser](https://swiftpackageindex.com/apple/swift-argument-parser/documentation)

## [Apple Technologies](https://developer.apple.com/documentation/technologies)

### [Recognizing Text in Images (Vision API)](https://developer.apple.com/documentation/vision/recognizing_text_in_images)
