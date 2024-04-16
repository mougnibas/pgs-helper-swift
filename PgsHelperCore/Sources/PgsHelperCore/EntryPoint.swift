// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import PgsHelperDecoderSup

/// I don't like standalone root level code.
/// Let's add some useless code for feel good purpose.
@main
struct EntryPoint {
    
    /// Application entrypoint function.
    static func main() {
        
        print("Reading and decoding PGS file ...")
        let segments: [AbstractSegment] = PgsDecoder.makeSegments(filepath: "/Users/yoann/Documents/3-subs.sup")
        print("Reading and decoding PGS file done !")
        print()
        
        print("Creating bitmaps from RLE object data ...")
        PgsDecoder.makeBitmaps(segments: segments)
        print("Creating bitmaps from RLE object data done !")
        print()

        // We are done
        exit(0)
    }
}
