// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import ArgumentParser
import PgsHelperCore

/// I don't like standalone root level code.
/// Let's add some useless code for feel good purpose.
@main
struct main: ParsableCommand {
    
    
    mutating func run() throws {
        
        // TODO See Swift Argument Parser
        // https://swiftpackageindex.com/apple/swift-argument-parser/documentation
        
        // Create an app instance
        let appBusiness: AppBusiness = AppBusiness()

        // Decode PGS
        print("Reading and decoding PGS file ...")
        appBusiness.decodePgsFile(filepath: "/Users/yoann/Documents/3-subs.sup")
        print("Reading and decoding PGS file done !")
        print()

        // Decode RLE
        print("Creating bitmaps from RLE object data ...")
        appBusiness.makeBitmaps()
        print("Creating bitmaps from RLE object data done !")
        print()
        
        // Use Apple AI
        print("Recognize text from bitmap using Apple AI ...")
        appBusiness.recognizeTextFromBitmap()
        print("Recognize text from bitmap using Apple AI done !")
        print()
    }
}
