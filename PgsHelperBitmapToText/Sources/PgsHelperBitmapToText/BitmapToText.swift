// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import CoreImage
import Vision

import PgsHelperCommon

/// A class to use AI to make text from bitmap.
///
/// Actually based on Apple AI.
/// See https://developer.apple.com/documentation/vision/recognizing_text_in_images
public class BitmapToText {
    
    /// Recognize text from an image.
    ///
    /// - Parameters :
    ///     - image : The  image
    ///     - language : Language to use. If omited, default will be "en-US".
    ///
    /// - Returns : An array of String.
    public static func recognizeText(image: PixmapPicture, language: String = "en-US") -> [String] {
        
        // Get the CGImage on which to perform requests.
        let cgImage: CGImage = Utils.convert(image)
        
        // Create a new image-request handler.
        let requestHandler: VNImageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        let request: VNRecognizeTextRequest = VNRecognizeTextRequest()
        
        // Set the prefered language
        request.recognitionLanguages = [ language ]

        // Perform the text-recognition request.
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
        // Prepare for results
        var results: [String] = []
        
        // Iterate over results
        for result: VNRecognizedTextObservation in request.results! {
            
            // At this point, we could pick more candidates.
            // However, first candidate will always be the best guess (maximum confidence score).
            let maxCandidateCount: Int = 1
            let candidate: VNRecognizedText = result.topCandidates(maxCandidateCount)[0]
            let text: String = candidate.string
            
            // Add the candidate to the results
            results.append(text)
        }
        
        // Return the results
        return results
    }
    
    /// Return the supported recognized languages.
    public static func supportedLanguages() -> [String] {

        do {
            let languages = try VNRecognizeTextRequest().supportedRecognitionLanguages()
            return languages
        } catch {
            return [ "" ]
        }
    }
}
