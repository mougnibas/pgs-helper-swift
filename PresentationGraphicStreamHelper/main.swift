// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  main.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 07/04/2024.
//

import Foundation

// Create the input stream
let input: InputStream = InputStream(fileAtPath: "/Users/yoann/Documents/3-subs.sup")!;

// Open it
input.open()

// Segment header buffer stuff
let segmentBufferSize = 13
var segmentBuffer: UnsafeMutablePointer<UInt8>

var magicNumber: String
var pts: UInt32
var dts: UInt32
var type: SegmentType
var size: UInt16
var segment: Segment

// As long as there is stuff in input stream
while input.hasBytesAvailable {
    
    // Read the current segment header
    segmentBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: segmentBufferSize)
    input.read(segmentBuffer, maxLength: segmentBufferSize)
    
    // Create a segment
    magicNumber = String(bytes: [segmentBuffer[0], segmentBuffer[1]], encoding: .ascii)!
    pts = fourUint8ToUint32(firstByte: segmentBuffer[2], secondByte: segmentBuffer[3], thirdByte: segmentBuffer[4], lastByte: segmentBuffer[5])
    dts = fourUint8ToUint32(firstByte: segmentBuffer[6], secondByte: segmentBuffer[7], thirdByte: segmentBuffer[8], lastByte: segmentBuffer[9])
    type = SegmentType(rawValue: segmentBuffer[10])!
    size = twoUInt8ToUInt16(firstByte: segmentBuffer[11], lastByte: segmentBuffer[12])
    segment = Segment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size)
    
    // Debug info
    print(segment)
    
    // TODO Read the next stuff
    print()
    _ = readLine()
}

print("Swift is easy");

/// Transform 4 unsigned bytes (UInt8) to a bigger UInt32 bytes
///
/// - Parameters:
///     - firstByte: First part of an UInt32 bytes
///     - secondByte: Second part of an UInt32 bytes
///     - thirdByte: Third part of an UInt32 bytes
///     - lastByte: Last part of an UInt32 bytes
///
/// - Returns : A full UInt32 bytes
///
func fourUint8ToUint32(firstByte: UInt8, secondByte: UInt8, thirdByte: UInt8, lastByte: UInt8) -> UInt32 {
    
    // Convert UInt8 to UInt32
    var firstPart:  UInt32 = UInt32(firstByte)
    var secondPart: UInt32 = UInt32(secondByte)
    var thirdPart:  UInt32 = UInt32(thirdByte)
    let lastPart:   UInt32 = UInt32(lastByte)
    
    // Shift bytes
    firstPart  = firstPart  << 24
    secondPart = secondPart << 16
    thirdPart  = thirdPart  <<  8
    
    // Finally, make a simple addition
    let fourBytesUnsignedInt: UInt32 = firstPart + secondPart + thirdPart + lastPart
    
    // Return the result
    return fourBytesUnsignedInt
}

/// Transform 2 unsigned bytes (UInt8) to a bigger UInt16 bytes
///
/// - Parameters:
///     - firstByte: First part of an UInt16 bytes
///     - lastByte: Last part of an UInt16 bytes
///
/// - Returns : A full UInt16 bytes
///
func twoUInt8ToUInt16(firstByte: UInt8, lastByte: UInt8) -> UInt16 {
    
    // Convert UInt8 to UInt16
    var firstPart: UInt16 = UInt16(firstByte)
    let lastPart: UInt16  = UInt16(lastByte)
    
    // Shift bytes
    firstPart = firstPart << 8
    
    // Finally, make a simple addition
    let twoBytesUnsignedInt: UInt16 = firstPart + lastPart
    
    // Return the result
    return twoBytesUnsignedInt
}
