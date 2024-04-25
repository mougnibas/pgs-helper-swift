import XCTest
@testable import PgsHelperCommon

final class PgsHelperCommonTests: XCTestCase {
    
    func testConvertYuvToRgbPart1() throws {
        
        // TODO I'm not sure about those numbers...
        // Arrange
        let y: UInt8 = 128
        let cb: UInt8 = 64
        let cr: UInt8 = 192
        let expected: [UInt8] = [ 208, 16, 144 ]

        // Act
        let actual: [UInt8] = Utils.convert(y, cb, cr)

        // Assert
        XCTAssertEqual(expected, actual, "Those arrays should be equals")
    }
}
