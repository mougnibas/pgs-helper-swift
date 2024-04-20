// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import PgsHelperCommon

public class RleDecoder {

    /// Convert from RLE object data to pixel map.
    ///
    /// // See https://developer.apple.com/documentation/coregraphics/cgimage/1455149-init
    ///
    /// - Parameters:
    ///     - fromRLE: RLE object data.
    ///
    /// - Returns: The decoded pixel map representation of RLE image.
    public static func decode( _ fromRLE: [UInt8]) -> PixmapPicture {
        
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
                        let pixels: Int = Int( Utils.convert(firstByte: firstPart, lastByte: lastPart) )
                        
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
                        let pixels: Int = Int( Utils.convert(firstByte: firstPart, lastByte: lastPart) )
                        
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
        let pixmap: PixmapPicture = PixmapPicture(width: width, height: height, buffer: buffer)
        
        // Return the PixelMap
        return pixmap
    }
}
