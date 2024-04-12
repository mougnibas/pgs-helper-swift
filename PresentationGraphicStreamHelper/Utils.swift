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
import CoreImage

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
    /// - Returns:
    static func convert(fromRLE: [UInt8]) -> PixelMap {
        
        // TODO Write me.
        return PixelMap(width: 3, height: 3, buffer: [ 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF,
                                                       0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF,
                                                       0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF ])
    }
    
    /// Convert from bitmap pixel map to CoreImage Image.
    ///
    /// - Parameters :
    ///     - pixelMap : The pixel map structure.
    ///
    /// - Returns : An image in CoreImage format.
    static func convert(pixelMap: PixelMap) -> CIImage {
        
        // Elements of CI Image
        let bitmapData: Data = Data(pixelMap.buffer)
        let bytesPerRow: Int = pixelMap.width * 4
        let size: CGSize = CGSize(width: pixelMap.width, height: pixelMap.height)
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Create the CI Image
        let ciImage = CIImage(bitmapData: bitmapData,
                              bytesPerRow: bytesPerRow,
                              size: size,
                              format: CIFormat.RGBA8,
                              colorSpace: colorSpace)
        
        // Return the CI Image
        return ciImage
    }
    
    /// Convert from bitmap pixel map to CoreGraphics Image.
    ///
    /// - Parameters :
    ///     - pixelMap : The pixel map structure.
    ///
    /// - Returns : An image in CoreGraphics format.
    static func convert(pixelMap: PixelMap) -> CGImage {
        
        // Create a CI Image
        let image: CIImage = convert(pixelMap: pixelMap)
        
        // Create a default context
        let context: CIContext = CIContext()
        
        // Create a CGImage from CIImage
        let cgimage: CGImage = context.createCGImage(image, from: image.extent)!
        
        // Return the CGImage
        return cgimage
    }
    
    /// Write a CIImage to a destination file, in PNG format.
    ///
    /// - Parameters :
    ///     - image : The CIImage to write
    ///     - destination : The destination file, in PNG format.
    ///
    /// - Throws : An error if we can't write the file.
    static func write(image: CIImage, destination: String) throws {
        
        // Create a default context
        let context: CIContext = CIContext()
        
        // Create a PNG representation of the image
        let format: CIFormat = CIFormat.RGBA8
        let colorSpace: CGColorSpace = image.colorSpace!
        let imageData = context.pngRepresentation(of: image, format: format, colorSpace: colorSpace)!
        
        // Try to write the file
        let url: URL = URL(fileURLWithPath: destination)
        try imageData.write(to: url)
    }
    
    /// A pixel map.
    public struct PixelMap {
        
        /// Width in pixels.
        let width: Int
        
        /// Height in pixels.
        let height: Int
        
        /// A RGBA buffer (Red, Green, Blue, Alpha components). One byte per component.
        let buffer: [UInt8]
    }

}
