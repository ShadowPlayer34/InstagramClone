//
//  Extensions.swift
//  Instagram
//
//  Created by Андрей Худик on 14.02.23.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return frame.width
    }
    
    public var height: CGFloat {
        return frame.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var rigth: CGFloat {
        return frame.origin.x + frame.width
    }
}
