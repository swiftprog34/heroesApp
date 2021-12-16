//
//  HeroesProvider.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation
import CoreData

class HeroesProvider: NSManagedObjectProviderProtocol {
    
    func getObjectById(context: NSManagedObjectContext, objectId: String, completion: @escaping (Result<NSManagedObject, Error>) -> Void) {
        do {
            let fetchRequest: NSFetchRequest<Heroes> = Heroes.fetchRequest()
            let objects = try context.fetch(fetchRequest)
            for obj in objects {
                print(obj)
            }
        } catch {
            print("failure")
        }
    }
    
    func prepareObject(context: NSManagedObjectContext, params: [String : String], completion: @escaping (Result<String, Error>) -> Void) {
        
        let hero = Heroes(context: context)
        for parameter in params {
            hero.setValue(parameter.value, forKey: parameter.key)
        }
        completion(.success("Done"))
        
    }
    
}
