//
//  WikiPediaViewModel.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 04/05/23.
//

import Foundation

protocol WikipediaDataProtocol{
    func sendResultData(_ data: ResultModel)
}

class WikipediaViewModel{
    var delegate: WikipediaDataProtocol?
    
    
    func getSearchResult(_ searchText: String){
        let url = Constant.getUrl(searchText)
        URLSession.shared.request(url: url, expecting: ResultModel.self) { [self] result in
            switch result {
            case .success(let data):
                self.delegate?.sendResultData(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
