//
//  ShowCommandsPresenter.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol ShowCommandsViewProtocol: AnyObject {
    
}

protocol ShowCommandsPresenterProtocol {
    init (view: ShowCommandsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol)
    func goToCreateNewCommand()
}

class ShowCommandsPresenter: ShowCommandsPresenterProtocol {
    weak var view: ShowCommandsViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    let dbProvider: DataBaseProviderProtocol!
    
    required init(view: ShowCommandsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbProvider = dbProvider
    }
    
    func goToCreateNewCommand() {
        router?.showCreateCommandModule()
    }
}
