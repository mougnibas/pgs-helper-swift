// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  Segment.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 10/04/2024.
//

import Foundation

/// A segment.
public class Segment : CustomStringConvertible {
    
    /// Magic numer (should be "PG").
    public let magicNumber: String
    
    /// Presentation Timestamp (converted to ms).
    public let pts: Float
    
    /// Decoding Timestamp (should be 0).
    public let dts: Float
    
    /// Segment type (PDS, ODS, PCS, WDS or END).
    public let type: SegmentType
    
    /// Segment size.
    public let size: UInt16
    
    /// Initiliaze the segment.
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    public init(magicNumber: String, pts: UInt32, dts: UInt32, type: SegmentType, size: UInt16) {
        self.magicNumber = magicNumber
        self.pts  = Float(pts) / 90.0
        self.dts  = Float(dts) / 90.0
        self.type = type
        self.size = size
    }
    
    public var description: String {
        return "Segment(magicNumber=\"\(magicNumber)\", pts=\(pts), dts=\"\(dts)\", type=\"\(type)\", size=\"\(size)\",)"
    }
}
