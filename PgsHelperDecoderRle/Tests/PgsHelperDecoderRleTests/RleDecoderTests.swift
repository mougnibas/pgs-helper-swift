// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

// Import public dependency
import XCTest

// Import private depency
import PgsHelperCommon

// Import private dependency as testable dependency
@testable import PgsHelperDecoderRle

/// Unit test class of RleDecoder.
final class RleDecoderTests: XCTestCase {

    /// Decode a RLE object 1x1 white, then the result should be 1px width.
    func testDecodeOnePixelPerOnePixelBlackIsOnePixelWidthFromOnePixelInColorC() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 1, height: 1, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.width, actual.width, "I should have 1 pixel of width")
    }

    /// Decode a RLE object 1x1 white, then the result should be 1px height.
    func testDecodeOnePixelPerOnePixelBlackIsOnePixelHeightFromOnePixelInColorC() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 1, height: 1, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.height, actual.height, "I should have 1 pixel of height")
    }
    /// Decode a RLE object 1x1 white, then the result should be 1px white.
    func testDecodeOnePixelPerOnePixelBlackIsOnePixelWhiteFromOnePixelInColorC() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 1, height: 1, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.buffer, actual.buffer, "I should have the same pixel buffer")
    }
    
    /// Decode a RLE object 2x1 white, then the result should be 2px width.
    func testDecodeOnePixelPerOnePixelBlackIsTwoPixelWidthFromOnePixelInColorC() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 2, height: 1, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.width, actual.width, "I should have 2 pixel of width")
    }

    /// Decode a RLE object 2x1 white, then the result should be 2px height.
    func testDecodeOnePixelPerOnePixelBlackIsTwoPixelHeightFromOnePixelInColorC() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 1, height: 2, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.height, actual.height, "I should have 2 pixel of height")
    }
    
    /// Decode a RLE object 2x2 white, then the result should be 2x2 white.
    func testDecode2x2WhiteFromOnePixelInColorC() {
        
        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 2, height: 2, buffer: [
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,

            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.buffer, actual.buffer, "I should have the same pixel buffer")
    }
    
    /// Decode a RLE object 3x3 white border black center, then the result should be that.
    func testDecode3x3BlackAndWhiteFromOnePixelInColorC() {
        
        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 3, height: 3, buffer: [
            
            // First line, full white
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            
            // Second line, white, black, white
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b00000001, 0b00000001, 0b00000001, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            
            // Third line, full white
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111,
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ])
        let fromRLE: [UInt8] = [

            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b11111111,
            
            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,
            
            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b00000001,
            
            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,
            
            // One pixel in color C
            0b11111111,

            // One pixel in color C
            0b11111111,
            
            // One pixel in color C
            0b11111111,

            // End of line
            0b00000000, 0b00000000,
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.buffer, actual.buffer, "I should have the same pixel buffer")
    }

    func testDecode3x3BlackFromLPixelsInColor0() {

        // Arrange
        let expected: PixmapPicture = PixmapPicture(width: 3, height: 3, buffer: [

            // First line, full black
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,

            // Second line, full black
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,

            // Third line, full black
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
            0b00000000, 0b00000000, 0b00000000, 0b11111111,
        ])
        let fromRLE: [UInt8] = [

            // L pixels (9) in color 0
            0b00000000, 0b00001001,

            // End of line
            0b00000000, 0b00000000
        ]

        // Act
        let actual: PixmapPicture = RleDecoder.decode(fromRLE)

        // Assert
        XCTAssertEqual(expected.buffer, actual.buffer, "I should have the same pixel buffer")
    }
}
