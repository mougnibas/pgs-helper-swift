// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  ObjectDefinitionSegment.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 11/04/2024.
//

import Foundation

/// An Object Definition Segment (ODS).
public class ObjectDefinitionSegment : AbstractSegment {
    
    /// ID of this object..
    public let objectId: Int
    
    /// Version of this object.
    public let objectVersionNumber: Int
    
    /// Last in Sequence Flag.
    ///
    /// If the image is split into a series of consecutive fragments, the last fragment has this flag set.
    ///
    /// Possible values:
    /// - 0x40: Last in sequence
    /// - 0x80: First in sequence
    /// - 0xC0: First and last in sequence (0x40 | 0x80)
    public let sequenceFlag: SequenceFlag
    
    /// The length of the Run-length Encoding (RLE) data buffer with the compressed image data.
    public let objectDataLength: Int
    
    /// Width of the image.
    public let width: Int
    
    /// Height of the image.
    public let height: Int
    
    /// This is the image data compressed using Run-length Encoding (RLE).
    ///
    /// The size of the data is defined in the Object Data Length field.
    /// The Run-length encoding method is defined in the US 7912305 B1 patent.
    /// See https://www.google.com/patents/US7912305
    public let objectData: [UInt8]
    
    /// Initiliaze the Window Definition Segment (WDS).
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    ///
    ///     - objectId : ID of this object..
    ///     - objectVersionNumber : Version of this object.
    ///     - sequenceFlag : Last in Sequence Flag.
    ///     - objectDataLength : The length of the Run-length Encoding (RLE) data buffer with the compressed image data.
    ///     - width : Width of the image.
    ///     - height : Height of the image.
    ///     - objectData : This is the image data compressed using Run-length Encoding (RLE).
    ///
    public init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int,
                objectId: Int, objectVersionNumber: Int, sequenceFlag: SequenceFlag, objectDataLength: Int, width: Int, height: Int, objectData: [UInt8]) {
        
        // Assign local members
        self.objectId = objectId
        self.objectVersionNumber = objectVersionNumber
        self.sequenceFlag = sequenceFlag
        self.objectDataLength = objectDataLength
        self.width = width
        self.height = height
        self.objectData = objectData
        
        // Assign super class local members
        super.init(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size)
    }
    
    public override var description: String {
        return "ObjectDefinitionSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)', objectId='\(objectId)', objectVersionNumber='\(objectVersionNumber)', sequenceFlag='\(sequenceFlag)', objectDataLength='\(objectDataLength)', width='\(width)', height='\(height)', objectData='\(objectData)')"
    }
    
    /// Sequence Flag.
    public enum SequenceFlag : UInt8 {
        
        /// Last in sequence (0x40).
        case LAST = 0x40
        
        /// First in sequence (0x80).
        case FIRST = 0x80
        
        /// First and last in sequence (0xC0).
        case FIRST_AND_LAST = 0xC0
    }
}
