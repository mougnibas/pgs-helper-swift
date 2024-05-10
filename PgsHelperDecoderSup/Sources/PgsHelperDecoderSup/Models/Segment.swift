// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

public protocol Segment: CustomStringConvertible  {
    
    // Magic numer (should be "PG").
    var magicNumber: String { get set }
    
    /// Presentation Timestamp (converted to ms).
    var pts: Float { get set }
    
    /// Decoding Timestamp (should be 0).
    var dts: Float { get set }
    
    /// Segment type (PDS, ODS, PCS, WDS or END).
    var type: SegmentType { get set }
    
    /// Segment size.
    var size: Int { get set }
}
