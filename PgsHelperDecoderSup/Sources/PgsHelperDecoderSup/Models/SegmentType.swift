// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation


/// A segment type.
public enum SegmentType: UInt8 {
    
    /// Presentation Composition Segment.
    case PCS = 0x16
    
    /// Window Definition Segment.
    case WDS = 0x17
    
    /// Palette Definition Segment.
    case PDS = 0x14
    
    /// Object Definition Segment.
    case ODS = 0x15
    
    /// End of Display Set Segment.
    case END = 0x80
}
