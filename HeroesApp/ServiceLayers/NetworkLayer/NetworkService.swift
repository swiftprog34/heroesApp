//
//  NetworkService.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchHeroData(completion: @escaping (Result<Hero?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
    func fetchHeroData(completion: @escaping (Result<Hero?, Error>) -> Void) {
        let urlString = "https://randomuser.me/api/"
        guard let url =  URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(Hero.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


