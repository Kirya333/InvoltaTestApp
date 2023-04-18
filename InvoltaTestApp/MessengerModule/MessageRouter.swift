//
//  MessageRouter.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation

class MessengerRouter: MessengerPresenterToRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> MessengerPresenterToRouterProtocol {
        // create instances
        let presenter = MessengerPresenter()
        let interactor = MessengerInteractor()
        let router = MessengerRouter()
        
        // create UI instances
        let viewController = MessengerViewController()
        
        // assign appropriate values
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        viewController.presenter = presenter
        
        router.entry = viewController
        return router
    }
}
