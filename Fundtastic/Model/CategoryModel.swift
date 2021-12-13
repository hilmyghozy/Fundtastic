//
//  CategoryModel.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import Foundation

struct apiResponse<T: Codable>: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [T]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
}

struct CategoryModel: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source,
             author,
             title,
             description,
             url,
             urlToImage,
             publishedAt,
             content
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
