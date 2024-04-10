// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  SegmentType.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 10/04/2024.
//

import Foundation

/// A segment type.
public enum SegmentType: UInt8 {
    
    /// Presentation Composition Segment.
    case PCS = 22
    
    /// Window Definition Segment.
    case WDS = 23
    
    /// Palette Definition Segment.
    case PDS = 24
    
    /// Object Definition Segment.
    case ODS = 25
    
    /// End of Display Set Segment.
    case END = 26
}
