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
public class EndSegment : AbstractSegment {
    
    public override var description: String {
        return "EndSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)')"
    }
}
