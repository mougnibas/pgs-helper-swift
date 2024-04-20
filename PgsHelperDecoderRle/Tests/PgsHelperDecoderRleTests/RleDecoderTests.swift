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
    
    /// Decode a 1x1 RLE object.
    func testDecode1x1() {
        
        // Arrange
        let fromRLE: [UInt8] = []
        
        // Act
        let pixmapPicture: PixmapPicture = RleDecoder.decode(fromRLE)
        
        // Assert
        XCTAssertTrue(false)
    }
}
