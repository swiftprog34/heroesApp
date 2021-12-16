//
//  DataBaseProvider.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation
import CoreData

protocol DataBaseProviderProtocol {
    func saveContext() throws
//    func deleteContext(_ object: NSManagedObject) throws
    
    func saveEntity(provider: NSManagedObjectProviderProtocol, params: [String: String], completion: @escaping (Result<String, Error>) -> Void)
    func deleteEntity(provider: NSManagedObjectProviderProtocol, objId: String, completion: @escaping (Result<String, Error>) -> Void)
    
    func fetch() throws -> Array<Commands>
}

protocol NSManagedObjectProviderProtocol {
    func prepareObject(context: NSManagedObjectContext, params: [String:String], completion: @escaping (Result<String, Error>) -> Void)
    func getObjectById(context: NSManagedObjectContext, objectId: String, completion: @escaping (Result<NSManagedObject, Error>) -> Void)
}

class DataBaseProvider: DataBaseProviderProtocol {
    
    static let shared: DataBaseProvider = {
        let instance = DataBaseProvider()
        return instance
    }()
    
    var context: NSManagedObjectContext!
    
    private init(){
        let container = NSPersistentContainer(name: "HeroesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.context = container.viewContext
    }
    
    func saveContext () throws {
        if let context = self.context {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
//    func deleteContext (_ object: NSManagedObject) throws {
//        if let context = self.context {
//            do {
//                try context.delete(object)
//                try context.save()
//            } catch {
//                context.rollback()
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

    func saveEntity(provider: NSManagedObjectProviderProtocol, params: [String: String], completion: @escaping (Result<String, Error>) -> Void) {
        provider.prepareObject(context: self.context, params: params) { result in
            switch result {
            case .success(_):
                do {
                    try self.saveContext()
                } catch {
                    completion(.failure(error))
                }
                completion(.success("Succefully saved"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteEntity(provider: NSManagedObjectProviderProtocol, objId: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.getObjectById(context: self.context, objectId: objId) { result in
            switch result {
            case .success(let obj):
                do {
                    self.context.delete(obj)
                    try self.saveContext()
                } catch {
                    completion(.failure(error))
                }
                completion(.success("Succefully deleted"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetch() throws -> Array<Commands> {
        let fetchRequest: NSFetchRequest<Commands> = Commands.fetchRequest()
        let objects = try context.fetch(fetchRequest)
        return objects
    }

}
