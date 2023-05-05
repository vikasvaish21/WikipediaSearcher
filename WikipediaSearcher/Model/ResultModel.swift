//
//  ResultModel.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 04/05/23.
//

import Foundation

struct ResultModel: Codable {
    let batchcomplete: String?
    let resultContinue: Continue?
    let query: Query?
    let limits: Limits?
    
    enum CodingKeys: String, CodingKey {
        case batchcomplete
        case resultContinue = "continue"
        case query, limits
    }
}

// MARK: - Limits
struct Limits: Codable {
    let pageimages, extracts: Int?
}

// MARK: - Query
struct Query: Codable {
    let pages: [String: Page]?
}

// MARK: - Page
struct Page: Codable {
    let pageid, ns: Int?
    let title: String?
    let index: Int?
    let thumbnail: Thumbnail?
    let pageimage: String?
    let extract: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String?
    let width, height: Int?
}

// MARK: - Continue
struct Continue: Codable {
    let gsroffset: Int?
    let continueContinue: String?
    
    enum CodingKeys: String, CodingKey {
        case gsroffset
        case continueContinue = "continue"
    }
}
