//
//  MessageDetailsLayoutCalculator.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit



class MessageDetailsLayoutCalculator {
    
    // MARK: Card view base calculations
    private static let aspectRatio = AppConstants.screenWidth / AppConstants.screenHeight
    private static let spaceToOccupy = CGSize(width: max(aspectRatio * 1.3, 0.7), height: aspectRatio)
    static var totalSpaceToOccupy: CGSize { CGSize(width: AppConstants.screenWidth * spaceToOccupy.width, height: AppConstants.screenHeight * spaceToOccupy.height) }
    static var insents: CGPoint { CGPoint(x: (AppConstants.screenWidth - totalSpaceToOccupy.width) / 2, y: (AppConstants.screenHeight - totalSpaceToOccupy.height) / 2) }
    
    // MARK: Calculating card view and inner frames
    static func calculateDetailsViewSizes(message: String) -> MessageDetailsViewModel.Sizes {
        
        let cardViewWidth = totalSpaceToOccupy.width
        
        let authorImageWidth = MessageDetailsConstants.messageAuthorIconSize.width
        
        // MARK: AuthorImageFrame
        let authorImageFrame = CGRect(origin: CGPoint(x: cardViewWidth / 2 - (authorImageWidth / 2), y: MessageDetailsConstants.messageAuthorIconOffsetFromCardView), size: MessageDetailsConstants.messageAuthorIconSize)
        
        // MARK: AuthorNameFrame
        let authorNameWidth = cardViewWidth - MessageDetailsConstants.messageAuthorInsets.left - MessageDetailsConstants.messageAuthorInsets.right
        let authorNameFrame = CGRect(origin: CGPoint(x: MessageDetailsConstants.messageAuthorInsets.left, y: authorImageFrame.maxY + MessageDetailsConstants.messageAuthorInsets.top), size: CGSize(width: authorNameWidth, height: "P".height(font: MessageDetailsConstants.messageAuthorFont)))
        
        // MARK: DateFrame
        let dateWidth = cardViewWidth - MessageDetailsConstants.messageDateInsets.left - MessageDetailsConstants.messageDateInsets.right
        let dateFrame = CGRect(origin: CGPoint(x: MessageDetailsConstants.messageDateInsets.left, y: authorNameFrame.maxY + MessageDetailsConstants.messageDateInsets.top), size: CGSize(width: dateWidth, height: "P".height(font: MessageDetailsConstants.messageDateFont)))
        
        // MARK: Message Frame
        var messageFame = CGRect(origin: CGPoint(x: MessageDetailsConstants.messageTextInsets.left , y: dateFrame.maxY + MessageDetailsConstants.messageTextInsets.top), size: .zero)
        
        let messageFameWidth: CGFloat = cardViewWidth - MessageDetailsConstants.messageTextInsets.left - MessageDetailsConstants.messageTextInsets.right
        
        if !message.isEmpty {
            var height = message.height(width: messageFameWidth, font: MessageDetailsConstants.messageTextFont)
            
            let limitHeight: CGFloat = MessageDetailsConstants.messageTextFont.lineHeight * MessageDetailsConstants.messageTextMaxLines
            if height > limitHeight {
                height = MessageDetailsConstants.messageTextFont.lineHeight * MessageDetailsConstants.messageTextMaxLines
            } else if height < MessageDetailsConstants.messageTextMinHeight {
                height = MessageDetailsConstants.messageTextMinHeight
            }
            
            messageFame.size = CGSize(width: messageFameWidth, height: height)
        }
        
        // MARK: Bottom buttons stack view
        let bottomButtonsStackViewWidth = cardViewWidth - MessageDetailsConstants.buttonsStackViewInsets.left - MessageDetailsConstants.buttonsStackViewInsets.right
        let bottomButtonsStackViewFrame = CGRect(origin: CGPoint(x: MessageDetailsConstants.buttonsStackViewInsets.left, y: messageFame.maxY + MessageDetailsConstants.buttonsStackViewInsets.top), size: CGSize(width: bottomButtonsStackViewWidth, height: MessageDetailsConstants.buttonsStackViewHeight))
        
        // MARK: Calculate card view frame
        let cardViewHeight: CGFloat = bottomButtonsStackViewFrame.maxY + MessageDetailsConstants.buttonsStackViewInsets.bottom
        let cardViewYPoint: CGFloat = AppConstants.screenHeight / 2 - cardViewHeight / 2
        let cardViewFrame = CGRect(origin: CGPoint(x: insents.x, y: cardViewYPoint), size: CGSize(width: cardViewWidth, height: cardViewHeight))
        
        
        return MessageDetailsViewModel.Sizes(authorImageFrame: authorImageFrame,
                                             authorNameFame: authorNameFrame,
                                             messageDateFrame: dateFrame,
                                             messageFrame: messageFame,
                                             bottomButtonsStackViewFrame: bottomButtonsStackViewFrame,
                                             cardViewFrame: cardViewFrame)
    }
}
