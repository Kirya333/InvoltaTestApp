//
//  CoreDataManager.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private var messages: [MessageDataItem] = []
    
    private var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private var getLastMaxMessageId: Int {
        let maxMessageId: Int = Int((messages.max { lhs, rhs in
            return lhs.messageId < rhs.messageId
        })?.messageId ?? 0)
        print("Generated new message id: \(maxMessageId + 1)")
        return maxMessageId + 1
    }
    
    func getMessageDataItems() -> [MessageDataItem] {
        loadDataFromMemory()
        
        for message in messages {
            print("messageId: \(message.messageId)")
        }
        
        messages.reverse()
        return messages
    }
    
    func deleteMessage(by id: Int) -> Bool {
        print("Delete message by id: \(id)")
        let context = context
        let fetchRequest: NSFetchRequest<MessageDataItem> = MessageDataItem.fetchRequest()
        
        guard let tasks = try? context.fetch(fetchRequest), let taskToDelete = tasks.first(where: { $0.messageId == id }) else {
            print("Core data manager unable get context or find task to delete")
            return false
        }
        
        context.delete(taskToDelete)
        self.messages.removeAll(where: { $0.messageId == id })
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
    
    func addMessage(message: String, author: String) -> MessageDataItem?{
        let context = context
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MessageDataItem", in: context) else { print("Error getting entity for MessageDataItem"); return nil }
        
        let messageObject = MessageDataItem(entity: entity, insertInto: context)
        messageObject.message = message
        messageObject.author = author
        messageObject.messageId = Int64(getLastMaxMessageId)
                                            
        do {
            try context.save()
            messages.append(messageObject)
            return messageObject
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func loadDataFromMemory(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<MessageDataItem> = MessageDataItem.fetchRequest()
        
        do{
            messages = try context.fetch(fetchRequest)
        }catch{
            print("!!!\(error.localizedDescription) | \(error)")
        }
    }
}
