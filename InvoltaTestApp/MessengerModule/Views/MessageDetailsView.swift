//
//  MessageDetailsView.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class MessageDetailsView: UIView {
    
    weak var presenter: MessengerViewToPresenterProtocol?
    private var viewModel: MessageDetailsViewModel!
    
    // MARK: ColorSettings
    private let backgroundFadeColor = UIColor(named: "backgroundFade")!
    private let initialFade = 0.0
    private let targetFade = 0.7
    
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "messageBubble")
        view.layer.cornerRadius = 15
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 2, height: 1)
        view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var messageAuthorIconImage: WebImageView = {
        let imageView = WebImageView()
        imageView.checkForAbsoluteUrl = false
        imageView.useShortUrlForCaching = true
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.layer.cornerRadius = (MessageDetailsConstants.messageAuthorIconSize.width / 2)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var messageAuthorLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = MessageDetailsConstants.messageAuthorFont
        label.textColor = MessageDetailsConstants.messageAuthorFontColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.backgroundColor = UIColor(named: "messageTextBackground_1")
        
        return label
    }()
    
    private lazy var messageDateLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = MessageDetailsConstants.messageDateFont
        label.textColor = MessageDetailsConstants.messageDateFontColor
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.backgroundColor = UIColor(named: "messageTextBackground_1")
        return label
    }()
    
    private lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = MessageDetailsConstants.messageTextFont
        label.textColor = MessageDetailsConstants.messageTextFontColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageTextView: UITextView = {
        let label = UITextView()
        label.font = MessageDetailsConstants.messageTextFont
        label.textColor = MessageDetailsConstants.messageTextFontColor
        label.isEditable = false
        label.isSelectable = false
        label.layer.cornerRadius = 8
        label.backgroundColor = UIColor(named: "mainColorSet_2")
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var bottomButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var topRightcloseMessageDetailsButton: ExpandedButton = {
        var button = ExpandedButton()
        button.clickIncreasedArea = AppConstants.expandCustomButtonsClickArea
        button.translatesAutoresizingMaskIntoConstraints = false
        var buttonImage = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.imageView?.tintColor = UIColor(named: "mainTextColorSet_1")
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var closeMessageDetailsButton: UIButton = {
        var button = UIButton()
        button.setTitle("Back", for: .normal)
        let buttonTextColor = #colorLiteral(red: 0, green: 0.3110570908, blue: 1, alpha: 1)
        button.setTitleColor(buttonTextColor, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var deleteMessageDetailsButton: UIButton = {
        var button = UIButton()
        button.setTitle("Delete", for: .normal)
        let buttonTextColor = #colorLiteral(red: 0.995796144, green: 0.01920183934, blue: 0.02101877145, alpha: 1)
        button.setTitleColor(buttonTextColor, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    func setUp(viewModel: MessageDetailsViewModel) {
        self.viewModel = viewModel
        self.frame = CGRect(origin: .zero, size: CGSize(width: AppConstants.screenWidth, height: AppConstants.screenHeight))
        backgroundColor = backgroundFadeColor.withAlphaComponent(initialFade)
        
        setInnerUI(viewModel: viewModel)
        
        // Animate opening
        UIView.animate(withDuration: 1) { [weak self, backgroundFadeColor, targetFade] in
            self?.backgroundColor = backgroundFadeColor.withAlphaComponent(targetFade)
            self?.cardView.alpha = 1
        }
    }
    
    private func setInnerUI(viewModel: MessageDetailsViewModel) {
        // MARK: Base card view
        addSubview(cardView)
        
        cardView.alpha = 0
        cardView.frame = viewModel.sizes.cardViewFrame
        
        cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:))))
        
        cardViewInitialPos = cardView.frame.origin.x
        self.lastIterationFrame = cardView.frame
        
        // MARK: Close Message Details Top-right button
        cardView.addSubview(topRightcloseMessageDetailsButton)
        topRightcloseMessageDetailsButton.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: MessageDetailsConstants.topRightCloseMessageDetailsButtonInsets, size: MessageDetailsConstants.topRightCloseMessageDetailsButtonSize)
        

        // MARK: Other views setting by frame
        cardView.addSubview(messageAuthorIconImage)
        messageAuthorIconImage.frame = viewModel.sizes.authorImageFrame
        messageAuthorIconImage.set(imageURL: viewModel.authorRandomImageUrl)
        
        cardView.addSubview(messageAuthorLabel)
        messageAuthorLabel.frame = viewModel.sizes.authorNameFame
        messageAuthorLabel.text = viewModel.authorName
        messageAuthorLabel.frame.size = CGSize(width: messageAuthorLabel.intrinsicContentSize.width, height: viewModel.sizes.authorNameFame.height)
        messageAuthorLabel.frame.origin = CGPoint(x: cardView.frame.width / 2 - messageAuthorLabel.frame.size.width / 2, y: messageAuthorLabel.frame.origin.y)
        messageAuthorLabel.layer.cornerRadius = viewModel.sizes.authorNameFame.height / 2
        
        cardView.addSubview(messageDateLabel)
        messageDateLabel.frame = viewModel.sizes.messageDateFrame
        messageDateLabel.text = "Sept 16, 15:37"
        messageDateLabel.frame.size = CGSize(width: messageDateLabel.intrinsicContentSize.width, height: viewModel.sizes.messageDateFrame.height)
        messageDateLabel.frame.origin = CGPoint(x: cardView.frame.width / 2 - messageDateLabel.frame.size.width / 2, y: messageDateLabel.frame.origin.y)
        messageDateLabel.layer.cornerRadius = viewModel.sizes.messageDateFrame.height / 2
        
        cardView.addSubview(bottomButtonsStackView)
        bottomButtonsStackView.frame = viewModel.sizes.bottomButtonsStackViewFrame
        bottomButtonsStackView.addArrangedSubview(deleteMessageDetailsButton)
        bottomButtonsStackView.addArrangedSubview(closeMessageDetailsButton)
        
        cardView.addSubview(messageTextLabel)
        messageTextLabel.frame = viewModel.sizes.messageFrame
        messageTextLabel.text = viewModel.message
        let messageTextExceedsMaxLines = CGFloat(messageTextLabel.maxNumberOfLines) > MessageDetailsConstants.messageTextMaxLines
        if messageTextExceedsMaxLines {
            messageTextLabel.removeFromSuperview()
            cardView.addSubview(messageTextView)
            messageTextView.frame = viewModel.sizes.messageFrame
            messageTextView.text = viewModel.message
        }
        
        // MARK: Assign button actions
        topRightcloseMessageDetailsButton.addTarget(self, action: #selector(closeButtonPessed), for: .touchUpInside)
        closeMessageDetailsButton.addTarget(self, action: #selector(closeButtonPessed), for: .touchUpInside)
        deleteMessageDetailsButton.addTarget(self, action: #selector(deleteButtonPessed), for: .touchUpInside)
    }
    
    // MARK: Button actions
    @objc private func closeButtonPessed() {
        executeClosingAnimation()
    }
    
    @objc private func deleteButtonPessed() {
        presenter?.requestedToDeleteMessage(messageid: viewModel.messageId, belongsToCurrentUser: viewModel.belongsToCurrentUser)
        executeClosingAnimation()
    }
    
    
    // MARK: Panning related
    private var cardViewInitialPos: CGFloat!
    private var lastIterationFrame: CGRect!
    private let percentThresholdToClose = 0.2
    
    @objc private func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: cardView)
        let horizontalMovement = translation.x / cardView.bounds.width
        let rightwardsMovement = fmaxf(Float(horizontalMovement), 0.0)
        let progress = CGFloat(fminf(rightwardsMovement, 1.0))

        
        let newXPos = max(cardViewInitialPos, translation.x + lastIterationFrame.origin.x)
        
        if panGesture.state == .changed {
            self.backgroundColor = backgroundFadeColor.withAlphaComponent((1 - progress) * targetFade)
            cardView.frame.origin = CGPoint(
                x: newXPos,
                y: cardView.frame.origin.y
            )
        } else if panGesture.state == .ended {
            self.lastIterationFrame = cardView.frame
            if(progress > percentThresholdToClose){
                executeClosingAnimation()
            }else{
                executeCancelAnimation()
            }
        }
    }
    
    private func executeClosingAnimation(){
        UIView.animate(withDuration: 0.5) { [weak self, backgroundFadeColor] in
            self?.cardView.frame.origin.x = AppConstants.screenWidth
            self?.backgroundColor = backgroundFadeColor.withAlphaComponent(0)
        } completion: { [weak self] isCompleted in
            self?.removeFromSuperview()
        }
    }
    
    private func executeCancelAnimation(){
        UIView.animate(withDuration: 0.5) { [weak self, cardViewInitialPos, backgroundFadeColor, targetFade] in
            self?.cardView.frame.origin.x = cardViewInitialPos ?? 0
            self?.backgroundColor = backgroundFadeColor.withAlphaComponent(targetFade)
        } completion: { [weak self] isCompleted in
            self?.lastIterationFrame = self?.cardView.frame
        }
    }
}
