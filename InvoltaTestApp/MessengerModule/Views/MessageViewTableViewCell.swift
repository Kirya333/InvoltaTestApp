//
//  MessageViewTableViewCell.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

class MessageViewTableViewCell: UITableViewCell {
    static let reuseId = "MessageViewTableViewCell"
    
    weak var presenter: MessengerViewToPresenterProtocol?
    private var messageId: Int!
    private var belongsToCurentUser: Bool!
    
    private lazy var slidingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.02747169717, green: 0.03649111719, blue: 0.06909978957, alpha: 1)
        view.layer.cornerRadius = 17
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 17
        view.backgroundColor = UIColor(named: "messageBubble")
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
        imageView.layer.cornerRadius = MessageCellConstants.messageAuthorIconSize.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var messageAuthorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = MessageCellConstants.messageAuthorFont
        label.textColor = UIColor(named: "mainTextColorSet_1")
        return label
    }()
    
    private lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = MessageCellConstants.messageTextFont
        label.textColor = UIColor(named: "mainTextColorSet_1")
        return label
    }()
    
    private lazy var tapView: TapView = {
        let view = TapView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        layer.removeAllAnimations() // ?
        messageAuthorIconImage.set(imageURL: nil)
    }
    
    private func setUpConstraints(){
        // MARK: sliding view and cardView
        addSubview(slidingView)
        slidingView.addSubview(cardView)
        
        cardView.addSubview(shadowView)
        shadowView.fillSuperview()
        
        contentView.addSubview(tapView)
        
        // MARK: subviews of card view
        cardView.addSubview(messageAuthorIconImage)
        cardView.addSubview(messageAuthorLabel)
        cardView.addSubview(messageTextLabel)
    }
    
    func setUp(presenter: MessengerViewToPresenterProtocol, viewModel: MessageItemViewModel){
        self.presenter = presenter
        self.messageId = viewModel.messageId
        self.belongsToCurentUser = viewModel.belongsToCurrentUser
        
        messageAuthorIconImage.frame = viewModel.sizes.authorImageFrame
        messageAuthorIconImage.set(imageURL: viewModel.authorRandomImageUrl)
        
        messageAuthorLabel.frame = viewModel.sizes.authorNameFame
        messageTextLabel.frame = viewModel.sizes.messageTextFrame
        
        messageAuthorLabel.text = viewModel.authorRandomName
        messageTextLabel.text = viewModel.message
        
        // MARK: Execute message appear animation
        if(!viewModel.animationData.needToAnimate){
            slidingView.frame = bounds
            cardView.frame = viewModel.sizes.cardViewFrame
            cardView.transform = .identity
        }else{
            slidingView.frame.size = frame.size
            slidingView.frame.origin.x = !viewModel.belongsToCurrentUser ? -slidingView.frame.size.width : slidingView.frame.size.width
            cardView.frame = viewModel.sizes.cardViewFrame
            cardView.transform = viewModel.animationData.cardViewInitialScale
            
            UIView.animate(withDuration: viewModel.animationData.animationTime, delay: viewModel.animationData.delayBeforeAnimation, options: viewModel.animationData.animationOptions ) { [weak self] in
                self?.slidingView.frame.origin.x = self?.bounds.minX ?? 0
                self?.cardView.transform = .identity
            }
        }
        
        tapView.frame = viewModel.sizes.cardViewFrame
        tapView.setOnClickAction(onClick: messageClicked)
    }
    
    private func messageClicked(){
        presenter?.requestedToOpenMessageDetails(messageId: messageId)
    }
}
