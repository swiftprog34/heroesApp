//
//  CreateCommandPresenter.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol CreateCommandViewProtocol: AnyObject {
    func receiveAlertInformation(title: String, message: String)
}

protocol CreateCommandPresenterProtocol {
    init (view: CreateCommandViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol, entityProvider: NSManagedObjectProviderProtocol)
    func createNewHeroDidTapped()
    func createCommand()
    func testCoreData()
}

class CreateCommandPresenter: CreateCommandPresenterProtocol {

    weak var view: CreateCommandViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    let dbProvider: DataBaseProviderProtocol!
    let entityProvider: NSManagedObjectProviderProtocol!
    var commandParams: [String: String] = [:]
    
    required init(view: CreateCommandViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol, entityProvider: NSManagedObjectProviderProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbProvider = dbProvider
        self.entityProvider = entityProvider
    }

    func createNewHeroDidTapped() {
        router?.showCreateHeroModule()
    }
    
    func createCommand(){
        commandParams["name"] = "CustomName"
        dbProvider.saveEntity(provider: self.entityProvider,  params: commandParams) { result in
            switch result {
            case .success(let data):
                self.view?.receiveAlertInformation(title: "Success", message: data)
            case .failure(let error):
                self.view?.receiveAlertInformation(title: "Failed", message: error.localizedDescription)
            }
        }
    }
    
    func testCoreData(){
        do {
            let objects = try dbProvider.fetch()
            for obj in objects {
                print(obj)
            }
        } catch {
            print("failure")
        }
    }
}
