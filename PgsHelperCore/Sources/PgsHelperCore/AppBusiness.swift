// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import CoreImage

import PgsHelperDecoderSup
import PgsHelperDecoderRle
import PgsHelperCommon

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

        // This variable will store the current subtitle identifier
        var currentId: Int = -1

        // for each segments
        for segment in segments {

            // PCS will store current subtitle ID
            if let pcs = segment as? PresentationCompositionSegment {
                currentId = pcs.compositionNumber
            }

            // Only works with ODS
            if let ods = segment as? ObjectDefinitionSegment {

                // Create a bitmap image from RLE object data.
                // Ask the RLE Decoder to decode RLE pictures
                let pixmap: PixmapPicture = RleDecoder.decode(ods.objectData)

                // Convert the pixel map to CI Image
                let image: CIImage = Utils.convert(pixmap)

                // TODO Remove this debug lines
                do {
                    let destination: String = "/Users/yoann/Documents/subs/" + String(currentId) + ".png"
                    try Utils.write(image: image, destination: destination)
                } catch {
                    print("Something gone wrong")
                    exit(-1)
                }
            }
        }
    }
}
