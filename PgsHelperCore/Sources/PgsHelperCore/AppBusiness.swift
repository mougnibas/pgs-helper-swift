// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

import PgsHelperDecoderSup

/// Business app class.
public class AppBusiness {

    /// PGS segments.
    var segments : [AbstractSegment]

    /// Initialize app business members.
    public init() {

        // Just reference an empty array.
        segments = []
    }

    /// Internally decode a PGS file.
    public func decodePgsFile(filepath: String) {

        // Ask the PGS Decoder to decode the file.
        segments = PgsDecoder.makeSegments(filepath: filepath)
    }

    /// Internally make bitmaps from RLE from decoded pgs file.
    ///
    /// 'decodePgsFile' must be called before.
    public func makeBitmaps() {

        // Ask the RLE Decoder to decode RLE pictures
        // TODO Write an actual decoder ...
        PgsDecoder.makeBitmaps(segments: segments)
    }
}
