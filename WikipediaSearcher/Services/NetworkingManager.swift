//
//  APIClient.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 04/05/23.
//

import Foundation


class NetworkingManager{
    static var shared = NetworkingManager()
    
    static func fetchData<T: Codable>(_ url: URL?,expecting: T.Type,completion: @escaping(Result<T,Error>) -> Void){
        URLSession.shared.request(url: url, expecting: expecting, completion: completion)
    }
}
