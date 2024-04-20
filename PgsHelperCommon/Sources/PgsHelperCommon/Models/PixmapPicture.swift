// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

public struct PixmapPicture {

    /// Width in pixels.
    public let width: Int

    /// Height in pixels.
    public let height: Int

    /// A RGBA buffer (Red, Green, Blue, Alpha components). One byte per component.
    public let buffer: [UInt8]

    public init(width: Int, height: Int, buffer: [UInt8]) {
        self.width = width
        self.height = height
        self.buffer = buffer
    }
}
