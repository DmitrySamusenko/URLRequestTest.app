//
//  Joke.swift
//  URLRequest Test app
//
//  Created by Dmitry Samusenko on 24.01.2023.
//  let welcome = try? JSONDecoder().decode(Joke.self, from: jsonData)


import Foundation

// MARK: - Welcome
struct Joke: Codable {
    let error: Bool?
    let category, type, joke, setup: String?
    let flags: Flags?
    let id: Int?
    let safe: Bool?
    let lang: String?
}

// MARK: - Flags
struct Flags: Codable {
    let nsfw, religious, political, racist: Bool?
    let sexist, explicit: Bool?
}
