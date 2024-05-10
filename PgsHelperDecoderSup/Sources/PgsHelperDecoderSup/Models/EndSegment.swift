// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  EndSegment.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 11/04/2024.
//

import Foundation

/// An End Segment (END).
///
/// The end segment always has a segment size of zero and indicates the end of a Display Set (DS) definition.
/// It appears immediately after the last ODS in one DS.
public struct EndSegment: Segment {
    
    // Magic numer (should be "PG").
    public var magicNumber: String
    
    /// Presentation Timestamp (converted to ms).
    public var pts: Float
    
    /// Decoding Timestamp (should be 0).
    public var dts: Float
    
    /// Segment type (PDS, ODS, PCS, WDS or END).
    public var type: SegmentType
    
    /// Segment size.
    public var size: Int
    
    /// Initiliaze the segment.
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    public init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int) {
        self.magicNumber = magicNumber
        self.pts  = Float(pts) / 90.0
        self.dts  = Float(dts) / 90.0
        self.type = type
        self.size = Int(size)
    }
    
    public var description: String {
        return "EndSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)')"
    }
}
