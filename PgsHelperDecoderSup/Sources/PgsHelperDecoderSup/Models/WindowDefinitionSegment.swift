// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

/// A Window Definition Segment (WDS).
public struct WindowDefinitionSegment: Segment {
    
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
    
    /// Number of windows defined in this segment.
    public let numberOfWindows: Int
    
    /// ID of this window.
    public let windowsId: Int
    
    /// X offset from the top left pixel of the window in the screen.
    public let windowsHorizontalPosition: Int
    
    /// Y offset from the top left pixel of the window in the screen.
    public let windowsVerticalPosition: Int
    
    /// Width of the window.
    public let windowWidth: Int
    
    /// Height of the window.
    public let windowHeight: Int
    
    /// Initiliaze the Window Definition Segment (WDS).
    ///
    /// - Parameters:
    ///     - magicNumber: Magic numer (should be "PG").
    ///     - pts: Presentation Timestamp.
    ///     - dts: Decoding Timestamp (should be 0).
    ///     - type: Segment type (PDS, ODS, PCS, WDS or END).
    ///     - size: Segment size.
    ///     - numberOfWindows : Number of windows defined in this segment.
    ///     - windowsId : ID of this window
    ///     - windowsHorizontalPosition : X offset from the top left pixel of the window in the screen.
    ///     - windowsVerticalPosition : Y offset from the top left pixel of the window in the screen.
    ///     - windowWidth : Width of the window.
    ///     - windowHeight : Height of the window.
    ///
    public init(magicNumber: String, pts: Int, dts: Int, type: SegmentType, size: Int,
                numberOfWindows: Int, windowsId: Int, windowsHorizontalPosition: Int, windowsVerticalPosition: Int, windowWidth: Int, windowHeight: Int) {
        
        // Assign common local members
        self.magicNumber = magicNumber
        self.pts  = Float(pts) / 90.0
        self.dts  = Float(dts) / 90.0
        self.type = type
        self.size = Int(size)
        
        // Assign local members
        self.numberOfWindows = numberOfWindows
        self.windowsId = windowsId
        self.windowsHorizontalPosition = windowsHorizontalPosition
        self.windowsVerticalPosition = windowsVerticalPosition
        self.windowWidth = windowWidth
        self.windowHeight = windowHeight
    }
    
    public var description: String {
        return "WindowDefinitionSegment(magicNumber='\(magicNumber)', pts='\(pts)', dts='\(dts)', type='\(type)', size='\(size)', numberOfWindows='\(numberOfWindows)', windowsId='\(windowsId)', windowsHorizontalPosition='\(windowsHorizontalPosition)', windowsVerticalPosition='\(windowsVerticalPosition)', windowWidth='\(windowWidth)', windowHeight='\(windowHeight)')"
    }
}
