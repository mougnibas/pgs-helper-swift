// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

//
//  PresentationCompositionSegment.swift
//  PresentationGraphicStreamHelper
//
//  Created by Yoann MOUGNIBAS on 11/04/2024.
//

import Foundation

/// A Presentation Composition Segment (PCS).
public class PresentationCompositionSegment : AbstractSegment {
    
    /// Video width in pixels.
    public let width: Int
    
    /// Video height in pixels.
    public let height: Int
    
    /// Frame rate.
    public let framerate: Int
    
    /// Number of this specific composition.
    ///
    /// It is incremented by one every time a graphics update occurs.
    public let compositionNumber: Int
    
    /// Type of this composition.
    public let compositionState: CompositionState
    
    /// Indicates if this PCS describes a Palette only Display Update.
    public let paletteUpdateFlag: Bool
    
    /// ID of the palette to be used in the Palette only Display Update.
    public let paletteId: Int
    
    /// Number of composition objects defined in this segment.
    public let numberOfCompositionObjects: Int
    
    /// ID of the ODS segment that defines the image to be shown.
    public let objectId: Int
    
    /// Id of the WDS segment to which the image is allocated in the PCS.
    ///
    /// Up to two images may be assigned to one window.
    public let windowId: Int
    
    /// true : Force display of the cropped image object. false : Off.
    public let objectCroppedFlag: Bool
    
    /// X offset from the top left pixel of the image on the screen.
    public let objectHorizontalPosition: Int
    
    /// Y offset from the top left pixel of the image on the screen.
    public let objectVerticalPosition: Int
    
    /// Initiliaze the Presentation Composition Segment (PCS).
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    ///     - width: Video width in pixels.
    ///     - height: Video height in pixels.
    ///     - framerate: Frame rate.
    ///     - compositionNumber: Number of this specific composition.
    ///     - compositionState: Type of this composition.
    ///     - paletteUpdateFlag: Indicates if this PCS describes a Palette only Display Update.
    ///     - paletteId: Decoding: ID of the palette to be used in the Palette only Display Update.
    ///     - numberOfCompositionObjects: Number of composition objects defined in this segment.
    ///     - objectId : ID of the ODS segment that defines the image to be shown.
    ///     - windowId : Id of the WDS segment to which the image is allocated in the PCS.
    ///     - objectCroppedFlag : true : Force display of the cropped image object. false : Off.
    ///     - objectHorizontalPosition : X offset from the top left pixel of the image on the screen.
    ///     - objectVerticalPosition : Y offset from the top left pixel of the image on the screen.
    ///
    public init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int,
                width: Int, height: Int, framerate: Int, compositionNumber: Int, compositionState: CompositionState, paletteUpdateFlag: Bool, paletteId: Int, numberOfCompositionObjects: Int, objectId: Int, windowId: Int, objectCroppedFlag: Bool, objectHorizontalPosition: Int, objectVerticalPosition: Int) {
        
        // Assign local members
        self.width = width
        self.height = height
        self.framerate = framerate
        self.compositionNumber = compositionNumber
        self.compositionState = compositionState
        self.paletteUpdateFlag = paletteUpdateFlag
        self.paletteId = paletteId
        self.numberOfCompositionObjects = numberOfCompositionObjects
        self.objectId = objectId
        self.windowId = windowId
        self.objectCroppedFlag = objectCroppedFlag
        self.objectHorizontalPosition = objectHorizontalPosition
        self.objectVerticalPosition = objectVerticalPosition
        
        // Assign super class local members
        super.init(magicNumber: magicNumber, pts: pts, dts: dts, type: type, size: size)
    }
    
    public override var description: String {
        return "PresentationCompositionSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)', width='\(width)', height='\(height)', framerate='\(framerate)', compositionNumber='\(compositionNumber)', compositionState='\(compositionState)', paletteUpdateFlag='\(paletteUpdateFlag)', paletteId='\(paletteId)', numberOfCompositionObjects='\(numberOfCompositionObjects)', objectId='\(objectId)', windowId='\(windowId)', objectCroppedFlag='\(objectCroppedFlag)', objectHorizontalPosition='\(objectHorizontalPosition)', objectVerticalPosition='\(objectVerticalPosition)')"
    }
    
    /// Composition state.
    public enum CompositionState : UInt8 {
        
        /// Normal.
        case NORMAL = 0x00
        
        /// Acquisition Point.
        case ACQUISITION_POINT = 0x40
        
        /// Epoch Start.
        case EPOCH_START = 0x80
    }
}
