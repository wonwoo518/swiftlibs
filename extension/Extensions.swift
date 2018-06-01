//
//  Extensions.swift
//  StringWidthFT
//
//  Created by wonwoo518 on 2018. 5. 31..
//  Copyright © 2018년 wonwoo518. All rights reserved.
//

import UIKit

extension String {
    func width(font: UIFont) -> CGFloat {
        return self.size(font: font).width
    }
    
    func height(font: UIFont) -> CGFloat {
        return self.size(font: font).height
    }
    
    func size(font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedStringKey.font: font])
    }
}

extension UIButton{
    func resizeWithText(text:String?){
        let stringWidth = text?.width(font: self.titleLabel?.font ?? .systemFont(ofSize: 15.0))
        self.setTitle(text, for: .normal)
        let buttonWidth = (stringWidth ?? 0) + (self.backgroundImage(for: .normal)?.size.width ?? 0)
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: buttonWidth, height: self.frame.size.height)
    }
}
