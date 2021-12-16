//
//  EquipmentProvider.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 16.12.2021.
//

import Foundation
import CoreData

struct EquipmentData {
    static let arms = ["Glock", "Akm74", "M416", "Sg552"]
    static let head = ["Glasses", "Helmet", "Cap"]
    static let chest = ["Armor", "Jacket", "Bulletproof vest"]
    static let legs = ["Boots"]
}

class EquipmentProvider {
    func getObjectById(context: NSManagedObjectContext, completion: @escaping (Result<String, Error>) -> Void) {
        print("")
    }
    
    func prepareObject(context: NSManagedObjectContext, params: [String : String], completion: @escaping (Result<String, Error>) -> Void) {
//        var hero = Equipment(context: context)
    }
}


