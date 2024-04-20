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
    
    public static func recognizeText(image: PixmapPicture) -> String {
        
        // Get the CGImage on which to perform requests.
        let cgImage: CGImage = Utils.convert(image)
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
        return "TODO"
    }
    
    static func recognizeTextHandler(request: VNRequest, error: Error?) {
        
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        print("omg : '\(recognizedStrings)'");
    }
}
