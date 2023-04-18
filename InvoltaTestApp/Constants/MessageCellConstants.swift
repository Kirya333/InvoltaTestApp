//
//  MessageCellConstants.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class MessageCellConstants {
    // MARK: Fonts
    static let messageAuthorFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let messageAuthorLimitLines: CGFloat = 2
    static let messageTextFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    // MARK: Sizes and insets
    static let cardViewOffset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    static let cardViewWidthOfScreenMult: CGFloat = 0.65
    
    static let messageAuthorIconSize = CGSize(width: 45, height: 45)
    static let messageAuthorIconInsets = UIEdgeInsets(top: 6, left: 8, bottom: 16, right: 8)
    
    static let messageAuthorInsets = UIEdgeInsets(top: 8, left: 9, bottom: 5, right: 9)
    static let messageTextInsets = UIEdgeInsets(top: 4, left: 9, bottom: 8, right: 9)
    
    // MARK: Card View animation related
    static let cellOpeningAnimationDuration: Double = 0.5
    static let cellOpeningAnimationInterval: Double = 0.03
    static let cellInitialScale = CGAffineTransform(scaleX: 0.1, y: 0.1)
    static let cellTargetScale: Double = 1.0
    static let animationOptions: UIView.AnimationOptions = .curveEaseOut
}
