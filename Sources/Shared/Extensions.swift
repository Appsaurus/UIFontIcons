//
//  Extensions.swift
//  UIFontIcons
//
//  Created by Brian Strobach on 12/10/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

import UIKit
import CoreGraphics

internal extension CGRect{
    
    internal var maxSideLength: CGFloat{
        return max(width, height)
    }
    
    internal var minSideLength: CGFloat{
        return min(width, height)
    }
    
}

internal extension NSMutableAttributedString{
    
    @discardableResult
    internal func addAttributes(_ attrs: [NSAttributedString.Key : AnyObject]) -> NSMutableAttributedString{
        addAttributes(attrs, range: fullRange)
        return self
    }
    
    @discardableResult
    internal func appendString(_ string: String) -> NSMutableAttributedString{
        self.append(NSAttributedString(string: string))
        return self
    }
}

internal extension NSAttributedString{
    internal  var fullRange: NSRange{
        return NSRange(location: 0, length: self.length)
    }
}
