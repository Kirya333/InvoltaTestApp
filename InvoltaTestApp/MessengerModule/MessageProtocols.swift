//
//  MessageProtocols.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import UIKit

protocol MessengerViewToPresenterProtocol: AnyObject {
    var view: MessengerPresenterToViewProtocol? { get set }
    var interactor: MessengerPresenterToInteractorProtocol? { get set }
    var router: MessengerPresenterToRouterProtocol? { get set }
    
    func viewDidLoad()
    func getMessages()
    func userSentMessage(message: String)
    func requestedToDeleteMessage(messageid: Int, belongsToCurrentUser: Bool)
    func requestedToOpenMessageDetails(messageId: Int)
}

protocol MessengerViewToPresenterTableViewProtocol: AnyObject {
    func canScrollProgrammatically() -> Bool
    func lastRowIndex() -> Int
    func numberOfRowsInSection() -> Int
    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    func tableViewCellHeight(at indexPath: IndexPath) -> CGFloat
    func scrollViewDidScroll(scrollView: UIScrollView)
}

typealias MessengerPresenterProtocols = MessengerViewToPresenterProtocol & MessengerViewToPresenterTableViewProtocol

protocol MessengerPresenterToViewProtocol: AnyObject {
    var presenter: MessengerPresenterProtocols? { get set }
    
    func onFetchMessagesStarted(isInitialLoad: Bool)
    func onFetchMessagesCompleted(addedAnyNewMessages: Bool)
    func onFetchMessagesFail(error: Error, ranOutOfAttempts: Bool)
    func onLocalMessageSent()
    func updateMessagesTable()
    func openMessageDetails(messageDetails: MessageDetailsViewModel)
}

protocol MessengerPresenterToInteractorProtocol: AnyObject {
    var presenter: MessengerInteractorToPresenterProtocol? { get set }
    
    func loadMessages(messageOffset: Int)
    func loadLocalMessages()
    func saveLocalMessage(messageEntity: CoreDataMessageEntityToSave)
    func deleteLocalMessage(messageId: Int)
}

protocol MessengerInteractorToPresenterProtocol: AnyObject {
    func receivedMessages(messagesData: MessagesWrapped)
    func onMessagesLoadingFailed(error: Error, ranOutOfAttempts: Bool)
    func receivedLocalMessages(localMessages: [MessageDataItem])
    func localMessageSaved(localMessage: MessageDataItem)
    func deletedLocalMessage(messageId: Int, success: Bool)
}

typealias EntryPoint = MessengerPresenterToViewProtocol & UIViewController

protocol MessengerPresenterToRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    
    static func start() -> MessengerPresenterToRouterProtocol
}
