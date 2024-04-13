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
    ///     - fromRLE: RLE object data.
    ///
    /// - Returns: The decoded pixel map representation of RLE image.
    static func convert(fromRLE: [UInt8]) -> PixelMap {
        
        // Index used to move
        var index: Int = 0
        
        // Components of pixelmap
        var buffer: [UInt8] = []
        var tempWidth: Int  = 0
        var width: Int      = 0
        var height: Int     = 0
        
        // As long as there is byte to read
        while (index < fromRLE.count - 1) {
            
            // Get the very first byte
            let currentByte: UInt8 = fromRLE[0 + index]
            let nextByte: UInt8
            
            // If this byte is NOT 0x00, then it's "One pixel in color C".
            if (currentByte != 0x00) {
                
                // Get the pixel color
                let color: UInt8 = currentByte
                
                // Move the index
                index = index + 1
                
                // Update width count
                tempWidth = tempWidth + 1
                
                // Add pixel to buffer
                buffer.append(color)
                buffer.append(color)
                buffer.append(color)
                buffer.append(0xFF)
                
            } else {
                
                // Read next byte
                nextByte = fromRLE[1 + index]
                
                // If this next byte is 0x00, then it's "End of line".
                if (nextByte == 0x00) {
                    
                    // Move the index
                    index = index + 2
                    
                    // Update height count
                    height = height + 1
                    
                    // Reset width counters
                    width = tempWidth
                    tempWidth = 0
                    
                    
                } else {
                    
                    // Compute the discriminator
                    let discriminator = (nextByte & 0xC0) >> 6
                    
                    // Act according to the discriminator
                    switch (discriminator) {
                        
                    // If discriminiator is 0x00, then it's "L pixels in color 0 (L between 1 and 63)".
                    case 0x00 :
                        
                        // We take a subpart
                        let pixels: Int = Int( nextByte & 0x3F )
                        
                        // Move the index
                        index = index + 2
                        
                        // Update width count
                        tempWidth = tempWidth + pixels
                        
                        // Add pixels to buffer
                        for index in 0 ... pixels {
                            buffer.append(0x00)
                            buffer.append(0x00)
                            buffer.append(0x00)
                            buffer.append(0xFF)
                        }
                        
                    // If discriminiator is 0x01, then it's "L pixels in color 0 (L between 64 and 16383)".
                    case 0x01 :
                        
                        // We take a subpart of next byte
                        let firstPart: UInt8 = nextByte & 0x3F
                        
                        // We need the next next byte
                        let lastPart: UInt8 = fromRLE[2 + index]
                        
                        // Convert the result
                        let pixels: Int = Int( convert(firstByte: firstPart, lastByte: lastPart) )
                        
                        // Move the index
                        index = index + 3
                        
                        // Update width count
                        tempWidth = tempWidth + pixels
                        
                        // Add pixel to buffer
                        for index in 0 ... pixels {
                            buffer.append(0x00)
                            buffer.append(0x00)
                            buffer.append(0x00)
                            buffer.append(0xFF)
                        }
                        
                    // If discriminiator is 0x02, then it's "L pixels in color C (L between 3 and 63)".
                    case 0x02 :
                        
                        // Compute the pixels count
                        let pixels: Int = Int( nextByte & 0x3F )
                        
                        // Get color
                        let color: UInt8  = fromRLE[2 + index]
                        
                        // Move the index
                        index = index + 3
                        
                        // Update width count
                        tempWidth = tempWidth + pixels
                        
                        // Add pixel to buffer
                        for index in 0 ... pixels {
                            buffer.append(color)
                            buffer.append(color)
                            buffer.append(color)
                            buffer.append(0xFF)
                        }
                        
                    // If discriminiator is 0x03, then it's "L pixels in color C (L between 64 and 16383)".
                    case 0x03 :
                        
                        // We take a subpart of next byte
                        let firstPart: UInt8 = nextByte & 0x3F
                        
                        // We need the next next byte
                        let lastPart: UInt8 = fromRLE[2 + index]
                        
                        //  Convert the pixels count
                        let pixels: Int = Int( convert(firstByte: firstPart, lastByte: lastPart) )
                        
                        // Get color
                        let color: UInt8  = fromRLE[3 + index]
                        
                        // Move the index
                        index = index + 4
                        
                        // Update width count
                        tempWidth = tempWidth + pixels
                        
                        // Add pixel to buffer
                        for index in 0 ... pixels {
                            buffer.append(color)
                            buffer.append(color)
                            buffer.append(color)
                            buffer.append(0xFF)
                        }
                        
                    default :
                        print("We shouldn't be here")
                        exit(-1)
                    }
                }
            }
        }
        
        // Create the PixelMap
        let pixelMap : PixelMap = PixelMap(width: width, height: height, buffer: buffer)
        
        // Return the PixelMap
        return pixelMap
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
