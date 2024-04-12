// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  Utils.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 07/04/2024.
//

import Foundation

/// Utility class.
public class Utils {
    
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
    static func convert(firstByte: UInt8, secondByte: UInt8, thirdByte: UInt8, lastByte: UInt8) -> UInt32 {
        
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
    static func convert(firstByte: UInt8, lastByte: UInt8) -> UInt16 {
        
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
    
    /// Convert from RLE object data to pixel map.
    ///
    /// // See https://developer.apple.com/documentation/coregraphics/cgimage/1455149-init
    ///
    /// - Parameters:
    ///     - fromRLE: RLE object data
    ///
    /// - Returns: A pixel map (bitmal).
    static func convert(fromRLE: [UInt8]) -> [ [UInt8] ] {
        
        // TODO Write me.
        return [ [], [] ]
    }

}
