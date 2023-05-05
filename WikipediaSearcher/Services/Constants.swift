//
//  Constants.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 04/05/23.
//

import Foundation

struct Constant{
    static let BASE_URL = "https://en.wikipedia.org/w/api.php"
    static let FIRST_URL_COMPONENT = "?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch="
    static let SECOND_URL_COMPONENT = "&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"

    static func getUrl(_ search:String) -> URL? {
        
        if search == "" {
            return nil
        }
        guard let searchEncoded = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        
        guard let secondUrlEncoded = SECOND_URL_COMPONENT.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        
        let resultString = URL(string:BASE_URL+FIRST_URL_COMPONENT+searchEncoded+secondUrlEncoded)!
        return resultString
    }
}

