// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

import PgsHelperCommon

/// A subtitle entry in SRT format.
public class SubtitleEntry : CustomStringConvertible {
    
    /// Identifier.
    public let id: Int
    
    /// Start time.
    public let start: Date
    
    /// End time.
    public let end: Date
    
    /// Line(s) of text.
    public let texts: [String]
    
    /// Formated content.
    public var formated: String
    
    /// Initiliaze the instance.
    ///
    /// - parameters :
    ///     - id : Identifier.
    ///     - start : Start time.
    ///     - end : End time.
    ///     - texts : Line(s) of text.
    public init(id: Int, start: Date, end: Date, texts: [String]) {
        
        // Reference core members
        self.id = id
        self.start = start
        self.end = end
        self.texts = texts
        
        // Compute formated value.
        
        // Formated value
        formated = ""
        
        // Counter
        formated.append(String(id))
        formated.append("\n")
        
        // Format start time
        let startFormated = Utils.format(date: start)
        
        // Format end time
        let endFormated = Utils.format(date: end)

        // Start and end time
        formated.append(startFormated + " --> " + endFormated)
        formated.append("\n")
        
        // Subtitles
        for text: String in texts {
            formated.append(text)
            formated.append("\n")
        }
    }
    
    public var description: String {
        return "SubtitleEntry(id='\(id)', start='\(start)', end='\(end)', texts='\(texts)')"
    }
}
