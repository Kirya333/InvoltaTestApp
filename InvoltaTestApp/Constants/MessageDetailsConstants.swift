//
//  MessageDetailsConstants.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//


import Foundation
import UIKit

class MessageDetailsConstants {
    
    static let messageAuthorFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let messageAuthorLimitLines: CGFloat = 2
    static let messageTextFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    static let messageDateFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    
    static let messageAuthorFontColor = UIColor.white
    static let messageDateFontColor = UIColor.white
    static let messageTextFontColor = UIColor(named: "mainTextColorSet_1")!
    
    
    static let cardViewOffset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    static let cardViewWidthOfScreenMult: CGFloat = 0.65
    
    static let messageAuthorIconSize = CGSize(width: 70, height: 70)
    static let messageAuthorIconOffsetFromCardView: CGFloat = -(messageAuthorIconSize.height / 2 + (-0.1 * messageAuthorIconSize.height))
    
    static let messageAuthorInsets = UIEdgeInsets(top: 8, left: 30, bottom: 5, right: 30)
    static let messageDateInsets = UIEdgeInsets(top: 8, left: 45, bottom: 5, right: 45)
    static let messageTextInsets = UIEdgeInsets(top: 10, left: 9, bottom: 8, right: 9)
    static let messageTextMinHeight: CGFloat = 20
    static let messageTextMaxLines: CGFloat = 8
    
    
    static let topRightCloseMessageDetailsButtonInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    static let topRightCloseMessageDetailsButtonSize = CGSize(width: 20, height: 20)
    
    
    static let buttonsStackViewInsets = UIEdgeInsets(top: 7, left: 30, bottom: 12, right: 30)
    static let buttonsStackViewHeight: CGFloat = 20
    
    
    static let closeMessageDetailsButtonSize = CGSize(width: 100, height: 30)
    static let deleteMessageDetailsButtonSize = CGSize(width: 100, height: 30)
}
