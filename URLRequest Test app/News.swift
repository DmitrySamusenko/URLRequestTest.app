//
//  News.swift
//  URLRequest Test app
//
//  Created by Dmitry Samusenko on 07.02.2023.
//

import Foundation

// MARK: - News
struct News: Codable {
    var status: String = ""
    var totalResults: Int = 0
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    //My new counter
    var countTest: Int?
    var source: Source?
}

// MARK: - Source
struct Source: Codable {
    let name: String?
}
