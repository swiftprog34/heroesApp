//
//  CreateCommandPresenter.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol CreateCommandViewProtocol: AnyObject {
    
}

protocol CreateCommandPresenterProtocol {
    init (view: CreateCommandViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol)
}

class CreateCommandPresenter: CreateCommandPresenterProtocol {

    weak var view: CreateCommandViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    let dbProvider: DataBaseProviderProtocol!
    
    required init(view: CreateCommandViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbProvider = dbProvider
    }

}
