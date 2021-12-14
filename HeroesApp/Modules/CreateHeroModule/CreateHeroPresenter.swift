//
//  CreateHeroPresenter.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol CreateHeroViewProtocol: AnyObject {
    
}

protocol CreateHeroPresenterProtocol {
    init (view: CreateHeroViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol)
}

class CreateHeroPresenter: CreateHeroPresenterProtocol {

    weak var view: CreateHeroViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    let dbProvider: DataBaseProviderProtocol!
    
    required init(view: CreateHeroViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbProvider = dbProvider
    }
}
