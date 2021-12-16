//
//  CreateHeroPresenter.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol CreateHeroViewProtocol: AnyObject {
    func successGenerate(data: Hero, title: String, message: String)
    func receiveAlertInformation(title: String, message: String)
}

protocol CreateHeroPresenterProtocol {
    init (view: CreateHeroViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol, entityProvider: NSManagedObjectProviderProtocol)
    func generateHero()
    func createHero()
    func testCoreData()
}

class CreateHeroPresenter: CreateHeroPresenterProtocol {

    weak var view: CreateHeroViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    let dbProvider: DataBaseProviderProtocol!
    let entityProvider: NSManagedObjectProviderProtocol!
    var heroParams: [String: String] = [:]
    
    required init(view: CreateHeroViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dbProvider: DataBaseProviderProtocol, entityProvider: NSManagedObjectProviderProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dbProvider = dbProvider
        self.entityProvider = entityProvider
    }
    
    func generateHero() {
        networkService.fetchHeroData { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.view?.successGenerate(data: data!, title: "Success", message: "Hero generation was successfully finished!")
                case .failure(let error):
                    self.view?.receiveAlertInformation(title: "Failed", message: error.localizedDescription)
                }
            }
        }
    }
    
    func createHero(){
        heroParams["name"] = "CustomName"
        dbProvider.saveEntity(provider: self.entityProvider,  params: heroParams) { result in
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
