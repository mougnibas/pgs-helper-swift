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
    
    /// Input file path.
    @Argument(help: "Input file to read. Must be a PGS/SUP file.")
    var input: String
    
    /// Output file path.
    @Argument(help: "Output file to write. Will be a SRT file.")
    var output: String
    
    /// Language to use for text recognization.
    @Option(help: "The language to use. if omited, default will be 'en-US'. Common values are 'en-US', 'fr-FR', ' it-IT', 'de-DE', 'es-ES', 'pt-BR', 'zh-Hans', 'zh-Hant', 'yue-Hans', 'yue-Hant', 'ko-KR', 'ja-JP', 'ru-RU', 'uk-UA', 'th-TH' and 'vi-VT' ")
    var language: String? = nil
    
    mutating func run() throws {
        
        // Create an app instance
        let appBusiness: AppBusiness = AppBusiness()
        
        // Usage languages
        print("Supported languages :")
        for language: String in appBusiness.supportedLanguages() {
            print(" - \(language)")
        }
        print()

        // Decode PGS
        print("Reading and decoding PGS file ...")
        appBusiness.decodePgsFile(filepath: input)
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
