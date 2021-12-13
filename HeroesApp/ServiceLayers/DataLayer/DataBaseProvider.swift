//
//  DataBaseProvider.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation
import CoreData

protocol DataBaseProviderProtocol {
    func saveContext()
    func deleteContext(_ object: NSManagedObject)
}

class DataBaseProvider: DataBaseProviderProtocol {
    static let shared: DataBaseProvider = {
        let instance = DataBaseProvider()
        return instance
    }()
    var context: NSManagedObjectContext?
    
    private init(){
        let container = NSPersistentContainer(name: "HeroesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.context = container.viewContext
    }
    
    func saveContext () {
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
    
    func deleteContext (_ object: NSManagedObject) {
        if let context = self.context {
            do {
                try context.delete(object)
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
