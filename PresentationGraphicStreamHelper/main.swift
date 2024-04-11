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

// Buffer to use for reading data
var buffer: UnsafeMutablePointer<UInt8>

// Define header buffer size
let headerSegmentBufferSize = 13

// As long as there is stuff in input stream
while input.hasBytesAvailable {
    
    // Read header segment data
    buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: headerSegmentBufferSize)
    input.read(buffer, maxLength: headerSegmentBufferSize)
    
    // Decode header segment data
    let magicNumber: String               = String(bytes: [buffer[0], buffer[1]], encoding: .ascii)!
    let pts: Int                          = Int(fourUint8ToUint32(firstByte: buffer[2], secondByte: buffer[3], thirdByte: buffer[4], lastByte: buffer[5]))
    let dts: Int                          = Int(fourUint8ToUint32(firstByte: buffer[6], secondByte: buffer[7], thirdByte: buffer[8], lastByte: buffer[9]))
    let type: AbstractSegment.SegmentType = AbstractSegment.SegmentType(rawValue: buffer[10])!
    let size: Int                         = Int(twoUInt8ToUInt16(firstByte: buffer[11], lastByte: buffer[12]))
    
    // Change decoding behavior depending on current segment type
    switch (type) {
        
    // Is it a Presentation Composition Segment (PCS) ?
    case AbstractSegment.SegmentType.PCS :
    
        // Read PCS data
        buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        input.read(buffer, maxLength: size)
        
        // Decode PCS data
        let width: Int                                                        = Int(twoUInt8ToUInt16(firstByte: buffer[0], lastByte: buffer[1]))
        let height: Int                                                       = Int(twoUInt8ToUInt16(firstByte: buffer[2], lastByte: buffer[3]))
        let framerate: Int                                                    = Int(buffer[4])
        let compositionNumber: Int                                            = Int(twoUInt8ToUInt16(firstByte: buffer[5], lastByte: buffer[6]))
        let compositionState: PresentationCompositionSegment.CompositionState = PresentationCompositionSegment.CompositionState(rawValue: buffer[7])!
        let paletteUpdateFlag: Bool                                           = buffer[8] == 0x80 ? true : false
        let paletteId: Int                                                    = Int(buffer[9])
        let numberOfCompositionObjects: Int                                   = Int(buffer[10])
        let objectId: Int                                                     = Int(twoUInt8ToUInt16(firstByte: buffer[11], lastByte: buffer[12]))
        let windowId: Int                                                     = Int(buffer[13])
        let objectCroppedFlag: Bool                                           = buffer[14] == 0x40 ? true : false
        let objectHorizontalPosition: Int                                     = Int(twoUInt8ToUInt16(firstByte: buffer[15], lastByte: buffer[16]))
        let objectVerticalPosition: Int                                       = Int(twoUInt8ToUInt16(firstByte: buffer[17], lastByte: buffer[18]))
    
        // Create the PCS object
        let pcs = PresentationCompositionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, width: width, height: height, framerate: framerate, compositionNumber: compositionNumber, compositionState: compositionState, paletteUpdateFlag: paletteUpdateFlag, paletteId: paletteId, numberOfCompositionObjects: numberOfCompositionObjects, objectId: objectId, windowId: windowId, objectCroppedFlag: objectCroppedFlag, objectHorizontalPosition: objectHorizontalPosition, objectVerticalPosition: objectVerticalPosition)
        
        // TODO Remove this debug message
        print(pcs)
        
    // Is it a Window Definition Segment (WDS) ?
    case AbstractSegment.SegmentType.WDS :
        
        // Read WDS data
        buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        input.read(buffer, maxLength: size)
        
        // Decode WDS data
        let numberOfWindows: Int           = Int(buffer[0])
        let windowsId: Int                 = Int(buffer[1])
        let windowsHorizontalPosition: Int = Int(twoUInt8ToUInt16(firstByte: buffer[2], lastByte: buffer[3]))
        let windowsVerticalPosition: Int   = Int(twoUInt8ToUInt16(firstByte: buffer[4], lastByte: buffer[5]))
        let windowWidth: Int               = Int(twoUInt8ToUInt16(firstByte: buffer[6], lastByte: buffer[7]))
        let windowHeight: Int              = Int(twoUInt8ToUInt16(firstByte: buffer[8], lastByte: buffer[9]))
        
        // Create the WDS object
        let wds: WindowDefinitionSegment = WindowDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, numberOfWindows: numberOfWindows, windowsId: windowsId, windowsHorizontalPosition: windowsHorizontalPosition, windowsVerticalPosition: windowsVerticalPosition, windowWidth: windowWidth, windowHeight: windowHeight)
        
        // TODO Remove this debug message
        print(wds)
        
    // Is it a Palette Definition Segment (PDS) ?
    case AbstractSegment.SegmentType.PDS :
        
        // Read PDS data
        buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        input.read(buffer, maxLength: size)
        
        // Decode PDS data
        let paletteId: Int            = Int(buffer[0])
        let paletteVersionNumber: Int = Int(buffer[1])
        let paletteEntryId: Int       = Int(buffer[2])
        let luminance: Int            = Int(buffer[3])
        let colorDifferenceRed: Int   = Int(buffer[4])
        let colorDifferenceBlue: Int  = Int(buffer[5])
        let transparency: Int         = Int(buffer[6])
        
        // Create PDS object
        let wds: PaletteDefinitionSegment = PaletteDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, paletteId: paletteId, paletteVersionNumber: paletteVersionNumber, paletteEntryId: paletteEntryId, luminance: luminance, colorDifferenceRed: colorDifferenceRed, colorDifferenceBlue: colorDifferenceBlue, transparency: transparency)
        
        // TODO Remove this debug message
        print(wds)
        
    // Is it an Object Definition Segment (ODS) ?
    case AbstractSegment.SegmentType.ODS :
        
        // Read ODS data
        buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        input.read(buffer, maxLength: size)
        
        // Decode ODS data
        let objectId: Int                                      = Int(twoUInt8ToUInt16(firstByte: buffer[0], lastByte: buffer[1]))
        let objectVersionNumber: Int                           = Int(buffer[2])
        let sequenceFlag: ObjectDefinitionSegment.SequenceFlag = ObjectDefinitionSegment.SequenceFlag(rawValue: buffer[3])!
        let objectDataLength: Int                              = Int(fourUint8ToUint32(firstByte: 0x00, secondByte: buffer[4], thirdByte: buffer[5], lastByte: buffer[6]))
        let width: Int                                         = Int(twoUInt8ToUInt16(firstByte: buffer[7], lastByte: buffer[8]))
        let height: Int                                        = Int(twoUInt8ToUInt16(firstByte: buffer[9], lastByte: buffer[10]))
        // TODO Find a better way to populate this array of bytes...
        var pleaseMakeMeBetter: [UInt8] = []
        for index in 11 ... size {
            pleaseMakeMeBetter.append(buffer[index])
        }
        let objectData: [UInt8]                                = pleaseMakeMeBetter
        
        // Create ODS object
        let ods: ObjectDefinitionSegment = ObjectDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, objectId: objectId, objectVersionNumber: objectVersionNumber, sequenceFlag: sequenceFlag, objectDataLength: objectDataLength, width: width, height: height, objectData: objectData)
        
        // TODO Remove this debug message
        print(ods)
        
    // Is it and End Segment (END) ?
    case AbstractSegment.SegmentType.END :
        
        // Nothing more to read.
        // Just create END object
        let end: EndSegment = EndSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size)
        
        // TODO Remove this debug message
        print(end)
    }
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
