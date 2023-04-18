//
//  TextHeight.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import UIKit
import Foundation

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil
        )
        
        return ceil(size.height)
    }
    
    // one line text height
    func height(font: UIFont) -> CGFloat {
        let textSize = CGSize(width: CGFloat(20), height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil
        )
        
        return ceil(size.height)
    }
}

extension UILabel {
    // one line text height
    func height() -> CGFloat {
        let textSize = CGSize(width: CGFloat(1000), height: .greatestFiniteMagnitude)
        let size = "SomeText".boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: 10, weight: .medium)],
            context: nil
        )
        
        return ceil(size.height)
    }
    
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? UIFont.systemFont(ofSize: 10)], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UITextView {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? UIFont.systemFont(ofSize: 10)], context: nil).height
        let lineHeight = font?.lineHeight ?? 1
        return Int(ceil(textHeight / lineHeight))
    }
}
