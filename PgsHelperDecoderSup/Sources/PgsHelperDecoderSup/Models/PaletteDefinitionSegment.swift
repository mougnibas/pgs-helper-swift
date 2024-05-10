// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

/// A Palette Definition Segment (PDS).
public struct PaletteDefinitionSegment: Segment {
    
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
    
    /// ID of the palette.
    public let paletteId: Int
    
    /// Version of this palette within the Epoch.
    public let paletteVersionNumber: Int
    
    /// Entry number of the palette.
    public let paletteEntryId: Int
    
    /// Luminance (Y value)
    public let luminance: Int
    
    /// Color Difference Red (Cr value).
    public let colorDifferenceRed: Int
    
    /// Color Difference Blue (Cb value)
    public let colorDifferenceBlue: Int
    
    /// Transparency (Alpha value)
    public let transparency: Int
    
    /// Initiliaze the Window Definition Segment (WDS).
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    ///     - paletteId : ID of the palette.
    ///     - paletteVersionNumber : Version of this palette within the Epoch.
    ///     - paletteEntryId : Entry number of the palette.
    ///     - luminance : Luminance (Y value)
    ///     - colorDifferenceRed : Color Difference Red (Cr value).
    ///     - colorDifferenceBlue : Color Difference Blue (Cb value)
    ///     - transparency : Transparency (Alpha value)
    ///
    public init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int,
                paletteId: Int, paletteVersionNumber: Int, paletteEntryId: Int, luminance: Int, colorDifferenceRed: Int, colorDifferenceBlue: Int, transparency: Int) {
        
        // Assign common local members
        self.magicNumber = magicNumber
        self.pts  = Float(pts) / 90.0
        self.dts  = Float(dts) / 90.0
        self.type = type
        self.size = Int(size)
        
        // Assign local members
        self.paletteId = paletteId
        self.paletteVersionNumber = paletteVersionNumber
        self.paletteEntryId = paletteEntryId
        self.luminance = luminance
        self.colorDifferenceRed = colorDifferenceRed
        self.colorDifferenceBlue = colorDifferenceBlue
        self.transparency = transparency
    }
    
    public var description: String {
        return "PaletteDefinitionSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)', paletteId='\(paletteId)', paletteVersionNumber='\(paletteVersionNumber)', paletteEntryId='\(paletteEntryId)', luminance='\(luminance)', colorDifferenceRed='\(colorDifferenceRed)', colorDifferenceBlue='\(colorDifferenceBlue)', transparency='\(transparency)')"
    }
}
