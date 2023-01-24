//
//  ViewController.swift
//  URLRequest Test app
//
//  Created by Dmitry Samusenko on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    }
    private func makeRequest() {
        let url = URL(string: "https://v2.jokeapi.dev/joke/Any")
        //let url = URL(string: "https://api.ipify.org?format=json")
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, resume, error in
            if let data = data, let joke = try? JSONDecoder().decode(Joke.self, from: data) {
                print(joke.flags?.political)
            }
            //print(String(decoding: data!, as: UTF8.self))
        }
        task.resume()
        print("ccc")
    }
}
