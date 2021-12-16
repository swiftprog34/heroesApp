//
//  CommandsProvider.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation
import CoreData

class CommandsProvider: NSManagedObjectProviderProtocol {
    
    func getObjectById(context: NSManagedObjectContext, objectId: String, completion: @escaping (Result<NSManagedObject, Error>) -> Void) {
        do {
            let fetchRequest: NSFetchRequest<Commands> = Commands.fetchRequest()
            let objects = try context.fetch(fetchRequest)
            for obj in objects {
                print(obj)
            }
        } catch {
            print("failure")
        }
    }
    
    func prepareObject(context: NSManagedObjectContext, params: [String : String], completion: @escaping (Result<String, Error>) -> Void) {
        
        let command = Commands(context: context)
        for parameter in params {
            command.setValue(parameter.value, forKey: parameter.key)
        }
        completion(.success("Done"))
        
    }
}
