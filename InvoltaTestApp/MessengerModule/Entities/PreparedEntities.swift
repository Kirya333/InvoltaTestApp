//
//  PreparedEntities.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

struct MessageItemViewModel {
    var authorRandomName: String
    var authorRandomImageUrl: String
    var message: String
    var belongsToCurrentUser: Bool
    var messageId: Int
    var sizes: Sizes
    var animationData = AnimationSupportingData()
    
    struct AnimationSupportingData {
        var needToAnimate: Bool = true
        var delayBeforeAnimation: Double = 0
        var animationTime: Double = MessageCellConstants.cellOpeningAnimationDuration
        var cardViewInitialScale: CGAffineTransform = MessageCellConstants.cellInitialScale
        var animationOptions: UIView.AnimationOptions =  MessageCellConstants.animationOptions
    }
    
    struct Sizes {
        var cardViewInitialPoint: CGPoint
        var cardViewFrame: CGRect
        var authorImageFrame: CGRect
        var authorNameFame: CGRect
        var messageTextFrame: CGRect
        var cellHeight: CGFloat
    }
}

struct MessageDetailsViewModel {
    var authorName: String
    var authorRandomImageUrl: String
    var message: String
    var belongsToCurrentUser: Bool
    var messageId: Int
    var sizes: Sizes
    var image: Data?
    
    struct Sizes {
        var authorImageFrame: CGRect
        var authorNameFame: CGRect
        var messageDateFrame: CGRect
        var messageFrame: CGRect
        var bottomButtonsStackViewFrame: CGRect
        var cardViewFrame: CGRect
    }
}
