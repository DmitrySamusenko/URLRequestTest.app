//
//  ApiManager.swift
//  URLRequest Test app
//
//  Created by Dmitry Samusenko on 07.02.2023.
//

import UIKit

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ecd959ae40ce4fc099e08df865bb12a3"
    
    func getNews(completion: @escaping([Article]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let _: Void = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            let decoder = JSONDecoder()
            do {
                let newsData = try decoder.decode(News.self, from: data)
                    completion(newsData.articles ?? [])
            } catch {
                print("Error...")
            }
        }
            .resume()
    }
}
