//
//  Assembler.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit

protocol AssemblerProtocol {
    func makeMainModule(router: RouterProtocol) -> UIViewController
    func makeCreateCommandModule(router: RouterProtocol) -> UIViewController
    func makeCreateHeroModule(router: RouterProtocol) -> UIViewController
}

class Assembler: AssemblerProtocol {
    func makeMainModule(router: RouterProtocol) -> UIViewController {
        let dbProvider = DataBaseProvider.shared
        let view = ShowCommandsViewController()
        let networkService = NetworkService()
        let presenter = ShowCommandsPresenter(view: view, networkService: networkService, router: router, dbProvider: dbProvider)
        view.presenter = presenter
        return view
    }
    
    func makeCreateCommandModule(router: RouterProtocol) -> UIViewController {
        let dbProvider = DataBaseProvider.shared
        let view = CreateCommandViewController()
        let networkService = NetworkService()
        let presenter = CreateCommandPresenter(view: view, networkService: networkService, router: router, dbProvider: dbProvider)
        view.presenter = presenter
        return view
    }
    
    func makeCreateHeroModule(router: RouterProtocol) -> UIViewController {
        let dbProvider = DataBaseProvider.shared
        let view = CreateHeroTableViewController()
        let networkService = NetworkService()
        let presenter = CreateHeroPresenter(view: view, networkService: networkService, router: router, dbProvider: dbProvider)
        view.presenter = presenter
        return view
    }
}
