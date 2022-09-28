//
//  Extensions.swift
//  UIFontIcons
//
//  Created by Brian Strobach on 12/10/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if !os(macOS)
import UIKit
import CoreGraphics

internal extension CGRect{
    
    var maxSideLength: CGFloat{
        return max(width, height)
    }
    
    var minSideLength: CGFloat{
        return min(width, height)
    }
    
}

internal extension NSMutableAttributedString{
    
    @discardableResult
    func addAttributes(_ attrs: [NSAttributedString.Key : AnyObject]) -> NSMutableAttributedString{
        addAttributes(attrs, range: fullRange)
        return self
    }
    
    @discardableResult
    func appendString(_ string: String) -> NSMutableAttributedString{
        self.append(NSAttributedString(string: string))
        return self
    }
}

internal extension NSAttributedString{
    var fullRange: NSRange{
        return NSRange(location: 0, length: self.length)
    }
}

#endif
