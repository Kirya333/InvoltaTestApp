//
//  AppConstants.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class AppConstants {
    static var screenWidth: CGFloat = UIScreen.main.bounds.width
    static var screenHeight: CGFloat = UIScreen.main.bounds.height
    static var safeAreaPadding: UIEdgeInsets = UIEdgeInsets.zero
    
    static func initializePaddings(window: UIWindow){
        safeAreaPadding = window.safeAreaInsets
    }
    
    // change it to any value you consider 'right'
    static let consecutiveNetworkAttempts = 3
    
    // to see loading spinners and etc.
    static let messagesRequestArtificialDelay: Double = 0.4
    
    static let expandCustomButtonsClickArea = CGPoint(x: 10, y: 10)
    
    static let currentUserImageUrl = "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F13%2F2015%2F04%2F05%2Ffeatured.jpg"
    static let currentUserNickname = "Mr.Bob"
}

class GeneralUIConstants {
    // title view
    static let titleViewHeightAboveSafeArea: CGFloat = 30
    static var titleViewHeight: CGFloat { titleViewHeightAboveSafeArea + AppConstants.safeAreaPadding.top }
    
    // table view
    static let tableViewTopInset: CGFloat = 5
    static let tableViewBottomInset: CGFloat = 5
    static var tableViewHeight: CGFloat { AppConstants.screenHeight - titleViewHeight - keyboardParentHeight }
    static var tableViewRect: CGRect { CGRect(origin: CGPoint(x: 0, y: GeneralUIConstants.titleViewHeight), size: CGSize(width: AppConstants.screenWidth, height: GeneralUIConstants.tableViewHeight )) }
    static func calculateTableViewRectWithKeyboard(keyboardHeight: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: GeneralUIConstants.titleViewHeight), size: CGSize(width: AppConstants.screenWidth, height: GeneralUIConstants.tableViewHeight - (keyboardHeight - AppConstants.safeAreaPadding.bottom)))
    }
    
    // keyboard general insets
    static var keyboardFieldHeight: CGFloat { GeneralUIConstants.keyboardInsets.top + GeneralUIConstants.keyboardInsets.bottom + GeneralUIConstants.keyboardHeightAboveSafeArea }
    static var keyboardParentHeight: CGFloat { return AppConstants.safeAreaPadding.bottom + keyboardFieldHeight }
    
    static var keyboardFrame: CGRect { CGRect(origin: CGPoint(x: 0, y: AppConstants.screenHeight - keyboardParentHeight), size: CGSize(width: AppConstants.screenWidth, height: keyboardParentHeight)) }
    static func calculateKeyboardParentFrameWithKeyboard(keyboardHeight: CGFloat) -> CGRect {
        let rect = keyboardFrame
        return CGRect(origin: CGPoint(x: 0, y: rect.minY - keyboardHeight + AppConstants.safeAreaPadding.bottom), size: rect.size)
    }
    
    // bad connection badge
    static let badConnectionBadgeSize = CGSize(width: 40, height: 40)
    static let badConnectionBadgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let badConnectionBadgeOrigin = CGPoint(x: AppConstants.screenWidth - badConnectionBadgeSize.width - badConnectionBadgeInsets.right, y: titleViewHeight + badConnectionBadgeInsets.top )
    static let badConnectionBadgeFrame = CGRect(origin: badConnectionBadgeOrigin, size: badConnectionBadgeSize)
    
    static let keyboardInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    static let keyboardHeightAboveSafeArea: CGFloat = 34
}
