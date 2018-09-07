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


/*  html string을 attribute string으로 변환
 *  eg.
 *  let attributeString = NSMutableAttributedString(html: htmlString)
 *  attributeString.addAttributes([NSAttributedStringKey.font:UIFont.adjustedOcbFont(withSize: 14.0, withBaseWidth: 375.0)], range: NSMakeRange(0, attributeString.length))
 *  label.attributedText = htmlString
 */

extension NSMutableAttributedString{
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }
        
        guard let attributedString = try?  NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString: attributedString)
    }
}

extension NSLayoutConstraint {
    /**
     multiplier 변경
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(_ multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}


extension UIColor {
    public class func color(hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b, a: UInt32
        
        switch hex.count {
        case 6: // RGB
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 0xFF)
            
        case 8: // RGBA
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24)
            
        default:
            return UIColor.black
        }
        
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension CGFloat {
    func ratioAdjustedValue() -> CGFloat {
        return self.ratioAdjustedValue(375.0)
    }
    
    func ratioAdjustedValue(_ baseWidth: CGFloat) -> CGFloat {
        let deviceWidth = UIScreen.main.bounds.size.width;
        let scale = deviceWidth / baseWidth;
        return self * scale
    }
}


extension UIView {
    
    /**
     Autolayout Visual Layout으로 Constraints 추가하기 위한 Wrapper API
     
     - Parameters:
     - format: visual format. visual format내 view는 v0,v1,v2..로 지칭한다.
     - views: visual format내 v0, v1, v2, ..과 매치되는 view
     */
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /**
     여러 view를 수평으로 정렬한다.
     
     - Parameters:
     - views: 수평정렬 할 views
     - horizontalAlign: left , center align 지원
     - horizontalSpace: 수평 정렬 시 뷰간의 거리
     - verticalSpace: 수평정렬이 화면을 넘어갈 때 수직적으로 다음 뷰와의 거리
     
     */
    func centerAlignHorizontally(_ views:[UIView], horizontalSpace:CGFloat = 0.0, verticalSpace:CGFloat = 3.0, maxLine:Int = 1)->Int{
        
        guard views.count > 0 else {
            return 0
        }
        
        let originY:CGFloat = views[0].frame.origin.y
        let lineHeight:CGFloat = views[0].frame.size.height + verticalSpace
        var lines:[(pos:Int, width:CGFloat)] = []
        lines.append((pos:0, width:0))
        var lineIndex = 0
        for (i,btn) in views.enumerated() {
            
            if self.bounds.width <= (lines[lineIndex].width + btn.frame.size.width) {
                lineIndex += 1
                lines.append((pos:i,width:btn.frame.size.width + horizontalSpace))
                continue
            }
            
            lines[lineIndex].pos = i
            lines[lineIndex].width += (btn.frame.size.width + horizontalSpace)
        }
        
        var lineFirstButtonIndex = 0
        for (curLineIndex, lineInfo) in lines.enumerated(){
            
            var startX:CGFloat = (self.bounds.width - lineInfo.width)/2 + horizontalSpace/2
            for i in lineFirstButtonIndex...lineInfo.pos {
                
                views[i].frame = CGRect(x: startX, y: originY + (CGFloat(curLineIndex) * lineHeight), width: views[i].frame.size.width, height: views[i].frame.size.height)
                startX += views[i].frame.size.width + horizontalSpace
                
                if curLineIndex + 1 > maxLine{
                    views[i].isHidden = true
                }
            }
            
            lineFirstButtonIndex = lineInfo.pos + 1
        }
        
        return lines.count
    }
}
