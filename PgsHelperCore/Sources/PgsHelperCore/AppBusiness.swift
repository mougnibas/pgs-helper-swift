// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import CoreImage

import PgsHelperBitmapToText
import PgsHelperDecoderSup
import PgsHelperDecoderRle
import PgsHelperCommon

/// Business app class.
public class AppBusiness {

    /// PGS segments.
    var segments: [AbstractSegment]
    
    /// Pixel map pictures.
    var pixmaps: [PixmapPicture]
    
    // Array of subtitles.
    var subtitles: [ [String] ]

    /// Initialize app business members.
    public init() {

        // Just reference an empty array.
        segments = []
        pixmaps = []
        subtitles = []
    }
    
    /// Return the supported recognized languages.
    public func supportedLanguages() -> [String] {
        
        // Ask for supported languages
        let supportedLanguages: [String] = BitmapToText.supportedLanguages()
        
        // Return the result
        return supportedLanguages
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

        // for each segments
        for segment: AbstractSegment in segments {

            // Only works with ODS
            if let ods = segment as? ObjectDefinitionSegment {

                // Create a bitmap image from RLE object data.
                // Ask the RLE Decoder to decode RLE pictures
                let pixmap: PixmapPicture = RleDecoder.decode(ods.objectData)
                
                // Add the current pixmap to pixmaps
                pixmaps.append(pixmap)
            }
        }
    }
    
    /// Use machine learning to recognize text from bitmap.
    public func recognizeTextFromBitmap(language: String = "en-US") {
        
        // This variable will store the current subtitle identifier
        var id: Int = 0
        
        // Iterate over pixmaps
        for pixmap in pixmaps {
            
            // Increment counter
            id += 1
            
            // Use bitmap to text component
            let lines: [String] = BitmapToText.recognizeText(image: pixmap, language: language)
            
            // Add the lines to the subtitles
            subtitles.append(lines)
            
            // TODO Remove this debug lines
            /*
            print("Subtitle \(id) / \(pixmaps.count)")
            for line: String in lines {
                print(line)
            }
            let image: CIImage = Utils.convert(pixmap)
            do {
                let destination: String = "/Users/yoann/Documents/subs/" + String(id) + ".png"
                try Utils.write(image: image, destination: destination)
                print("Writing to '\(destination)'")
            } catch {
                print("Something gone wrong")
                exit(-1)
            }
            print()
             */
            
        }
    }
    
    /// Make Srt from previously called steps.
    public func makeSrt(filepath: String) {
        
        // TODO This is one of my most terrible code ever...
        // TODO Make a SRT model and business logic code.
        
        // SRT lines
        var lines: [String] = []
        
        // Get start and end times
        var starts: [Float] = []
        var ends: [Float] = []
        var start: Float = 0.0
        var end: Float = 0.0
        for segment: AbstractSegment in segments {
            
            if let wds = segment as? WindowDefinitionSegment {
                
                // It's a start ?
                if start == 0.0 && end == 0.0 {
                    start = wds.pts
                    continue
                }
                
                // It's and end ?
                if start != 0.0 && end == 0.0 {
                    end = wds.pts
                }
                
                // Are we done for that subtitle ?
                if start != 0.0 && end != 0.0 {
                    
                    // Add to the arrays
                    starts.append(start)
                    ends.append(end)
                    
                    // Reset them
                    start = 0.0
                    end = 0.0
                }
            }
        }
        
        // Create date formater
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss,SSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Build SRT content
        for index in 0...subtitles.count - 1 {
            
            // Counter
            let counter: Int = index + 1
            lines.append(String(counter))
            
            // Create and format start time
            let start: Float = starts[index]
            let millisecondsStart: Double = Double(start)
            let secondsStart: Double = TimeInterval(millisecondsStart) / 1000.0
            let dateStart: Date = Date(timeIntervalSince1970: secondsStart)
            let dateStartFormated = dateFormatter.string(from: dateStart)
            
            // Create and format end time
            let end: Float = ends[index]
            let millisecondsEnd: Double = Double(end)
            let secondsEnd: Double = TimeInterval(millisecondsEnd) / 1000.0
            let dateEnd: Date = Date(timeIntervalSince1970: secondsEnd)
            let dateEndFormated = dateFormatter.string(from: dateEnd)

            // Start and end time
            lines.append(dateStartFormated + " --> " + dateEndFormated)
            
            // Subtitles
            let currentSubtitle: [String] = subtitles[index]
            for subtitle: String in currentSubtitle {
                lines.append(subtitle)
            }
            
            // Blank line
            lines.append("")
        }
        
        // Write subtitles
        Utils.write(lines: lines, destination: filepath)
    }
}
