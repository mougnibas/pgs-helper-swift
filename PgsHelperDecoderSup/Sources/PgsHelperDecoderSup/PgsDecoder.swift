//
//  File.swift
//  
//
//  Created by Yoann MOUGNIBAS on 14/04/2024.
//

import Foundation
import CoreImage

/// An utility class to decode PGS files.
public class PgsDecoder {

    /// Make segments from a given PGS (sup) file
    ///
    /// - Parameters:
    ///     - filepath: The path to a PGS (sup) file.
    ///
    /// - Returns : An array of segments.
    public static func makeSegments(filepath: String) -> [AbstractSegment] {

        // Create an empty array.
        // It will grow automatically.
        // We don't know the size yet at creation time.
        var segments: [AbstractSegment] = []

        // Create the input stream
        let input: InputStream = InputStream(fileAtPath: filepath)!

        // Open it
        input.open()

        // Buffer to use for reading data
        var buffer: UnsafeMutablePointer<UInt8>

        // Define header buffer size
        let headerSegmentBufferSize = 13

        // As long as there is stuff in input stream
        while input.hasBytesAvailable {

            // Read header segment data
            buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: headerSegmentBufferSize)
            let readed: Int = input.read(buffer, maxLength: headerSegmentBufferSize)

            // If we read 0 byte, we are done
            if (readed == 0) {
                input.close()
                continue
            }

            // Decode header segment data
            let magicNumber: String               = String(bytes: [buffer[0], buffer[1]], encoding: .ascii)!
            let pts: Int                          = Int(Utils.convert(buffer[2], buffer[3], buffer[4], buffer[5]))
            let dts: Int                          = Int(Utils.convert(buffer[6], buffer[7], buffer[8], buffer[9]))
            let type: AbstractSegment.SegmentType = AbstractSegment.SegmentType(rawValue: buffer[10])!
            let size: Int                         = Int(Utils.convert(firstByte: buffer[11], lastByte: buffer[12]))

            // The segment to add later to the list
            let segment: AbstractSegment

            // Change decoding behavior depending on current segment type
            switch (type) {

            // Is it a Presentation Composition Segment (PCS) ?
            case AbstractSegment.SegmentType.PCS :

                // Read PCS data
                buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
                input.read(buffer, maxLength: size)

                // Decode PCS data
                let width: Int                          = Int(Utils.convert(buffer[0], buffer[1]))
                let height: Int                         = Int(Utils.convert(buffer[2], buffer[3]))
                let framerate: Int                      = Int(buffer[4])
                let compositionNumber: Int              = Int(Utils.convert(buffer[5], buffer[6]))
                let compositionState: .CompositionState = .CompositionState(rawValue: buffer[7])!
                let paletteUpdateFlag: Bool             = buffer[8] == 0x80 ? true : false
                let paletteId: Int                      = Int(buffer[9])
                let numberOfCompositionObjects: Int     = Int(buffer[10])
                let objectId: Int                       = Int(Utils.convert(buffer[11], buffer[12]))
                let windowId: Int                       = Int(buffer[13])
                let objectCroppedFlag: Bool             = buffer[14] == 0x40 ? true : false
                let objectHorizontalPosition: Int       = Int(Utils.convert(buffer[15], buffer[16]))
                let objectVerticalPosition: Int         = Int(Utils.convert(buffer[17], buffer[18]))

                // Create the PCS object
                segment = PresentationCompositionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, width: width, height: height, framerate: framerate, compositionNumber: compositionNumber, compositionState: compositionState, paletteUpdateFlag: paletteUpdateFlag, paletteId: paletteId, numberOfCompositionObjects: numberOfCompositionObjects, objectId: objectId, windowId: windowId, objectCroppedFlag: objectCroppedFlag, objectHorizontalPosition: objectHorizontalPosition, objectVerticalPosition: objectVerticalPosition)

            // Is it a Window Definition Segment (WDS) ?
            case AbstractSegment.SegmentType.WDS :

                // Read WDS data
                buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
                input.read(buffer, maxLength: size)

                // Decode WDS data
                let numberOfWindows: Int           = Int(buffer[0])
                let windowsId: Int                 = Int(buffer[1])
                let windowsHorizontalPosition: Int = Int(Utils.convert(firstByte: buffer[2], lastByte: buffer[3]))
                let windowsVerticalPosition: Int   = Int(Utils.convert(firstByte: buffer[4], lastByte: buffer[5]))
                let windowWidth: Int               = Int(Utils.convert(firstByte: buffer[6], lastByte: buffer[7]))
                let windowHeight: Int              = Int(Utils.convert(firstByte: buffer[8], lastByte: buffer[9]))

                // Create the WDS object
                segment = WindowDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, numberOfWindows: numberOfWindows, windowsId: windowsId, windowsHorizontalPosition: windowsHorizontalPosition, windowsVerticalPosition: windowsVerticalPosition, windowWidth: windowWidth, windowHeight: windowHeight)

            // Is it a Palette Definition Segment (PDS) ?
            case AbstractSegment.SegmentType.PDS :

                // Read PDS data
                buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
                input.read(buffer, maxLength: size)

                // Decode PDS data
                let paletteId: Int            = Int(buffer[0])
                let paletteVersionNumber: Int = Int(buffer[1])
                let paletteEntryId: Int       = Int(buffer[2])
                let luminance: Int            = Int(buffer[3])
                let colorDifferenceRed: Int   = Int(buffer[4])
                let colorDifferenceBlue: Int  = Int(buffer[5])
                let transparency: Int         = Int(buffer[6])

                // Create PDS object
                segment = PaletteDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, paletteId: paletteId, paletteVersionNumber: paletteVersionNumber, paletteEntryId: paletteEntryId, luminance: luminance, colorDifferenceRed: colorDifferenceRed, colorDifferenceBlue: colorDifferenceBlue, transparency: transparency)

            // Is it an Object Definition Segment (ODS) ?
            case AbstractSegment.SegmentType.ODS :

                // Read ODS data
                buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
                input.read(buffer, maxLength: size)

                // Decode ODS data
                let objectId: Int               = Int(Utils.convert(firstByte: buffer[0], lastByte: buffer[1]))
                let objectVersionNumber: Int    = Int(buffer[2])
                let sequenceFlag: .SequenceFlag = .SequenceFlag(rawValue: buffer[3])!
                let objectDataLength: Int       = Int(Utils.convert(firstByte: 0x00, secondByte: buffer[4], thirdByte: buffer[5], lastByte: buffer[6]))
                let width: Int                  = Int(Utils.convert(firstByte: buffer[7], lastByte: buffer[8]))
                let height: Int                 = Int(Utils.convert(firstByte: buffer[9], lastByte: buffer[10]))
                // TODO Find a better way to populate this array of bytes...
                var pleaseMakeMeBetter: [UInt8] = []
                for index in 11 ... size {
                    pleaseMakeMeBetter.append(buffer[index])
                }
                let objectData: [UInt8]                                = pleaseMakeMeBetter

                // Create ODS object
                segment = ObjectDefinitionSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size, objectId: objectId, objectVersionNumber: objectVersionNumber, sequenceFlag: sequenceFlag, objectDataLength: objectDataLength, width: width, height: height, objectData: objectData)

            // Is it and End Segment (END) ?
            case AbstractSegment.SegmentType.END :

                // Nothing more to read.
                // Just create END object
                segment = EndSegment(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size)
            }

            // Add the current segment to the list of segments
            segments.append(segment)
        }

        // Return the segments
        return segments
    }

    /// Make bitmaps from segments.
    ///
    /// - Parameters :
    ///     - segments: Segments to make bitmaps from
    public static func makeBitmaps(segments: [AbstractSegment]) {

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
                let pixelMap: Utils.PixelMap = Utils.convert(fromRLE: ods.objectData)

                // Convert the pixel map to CI Image
                let image: CIImage = Utils.convert(pixelMap: pixelMap)

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
