// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  AbstractSegment.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 10/04/2024.
//

import Foundation

/// An abstract segment.
public class AbstractSegment : CustomStringConvertible {
    
    /// Magic numer (should be "PG").
    public let magicNumber: String
    
    /// Presentation Timestamp (converted to ms).
    public let pts: Float
    
    /// Decoding Timestamp (should be 0).
    public let dts: Float
    
    /// Segment type (PDS, ODS, PCS, WDS or END).
    public let type: SegmentType
    
    /// Segment size.
    public let size: Int
    
    /// Initiliaze the segment.
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    internal init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int) {
        self.magicNumber = magicNumber
        self.pts  = Float(pts) / 90.0
        self.dts  = Float(dts) / 90.0
        self.type = type
        self.size = Int(size)
    }
    
    public var description: String {
        return "AbstractSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)')"
    }
    
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
}
