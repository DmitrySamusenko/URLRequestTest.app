//
//  ViewController.swift
//  URLRequest Test app
//
//  Created by Dmitry Samusenko on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    var articles = [Article]()
    var articlesFromStorage = [Article]()
    var tableView: UITableView = {
        let tableView = UITableView()
        let adNib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(adNib, forCellReuseIdentifier: "NewsCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //MARK: Trying UserDefaults initiate
        
        if articles.isEmpty && articlesFromStorage.isEmpty {
            APIManager.shared.getNews { [weak self] values in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.articles = values
                    self.tableView.reloadData()
                    print("Массив объектов загружен из JSON")
                    
                    // На этом моменте у нас загружена информация из JSON и создан массив articles
                    // Сохраняем этот массив в UserDefaults ->
                    
                    do {
                        // Create JSON Encoder
                        let encoder = JSONEncoder()
                        // Encode Note
                        let data = try encoder.encode(self.articles)
                        // Write/Set Data
                        UserDefaults.standard.set(data, forKey: "articles")
                        print("Массив объектов успешно сохранен в хранилище объектов")
                        print("ArticleFromStorage isEmpty: \(self.articlesFromStorage.isEmpty)")
                    } catch {
                        print("Ошибка (\(error))")
                    }
                    
                    
                    // Теперь мы пытаемся прочитать дату из хранилища и записать ее в переменную
                    // Read/Get Data
//                    if let data = UserDefaults.standard.data(forKey: "articles") {
//                        do {
//                            // Create JSON Decoder
//                            let decoder = JSONDecoder()
//                            // Decode Note
//                            let notes = try decoder.decode([Article].self, from: data)
//                            self.articlesFromStorage = notes
//                            print("Декодинг прошел успешно, можете использовать данные из хранилища")
//                            print("ArticleFromStorage isEmpty: \(self.articlesFromStorage.isEmpty)")
//                        } catch {
//                            print("Unable to Decode Notes (\(error))")
//                        }
//                    }
                    
                }
            }
        } else {
            print("Массив объектов JSON заполнен")
        }
        
        
        
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count // Тут возможно и есть косяк
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        if let data = UserDefaults.standard.data(forKey: "articles") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                // Decode Note
                let notes = try decoder.decode([Article].self, from: data)
                cell.objectTitle.text = notes[indexPath.row].title
                self.articlesFromStorage = notes
                print("Декодинг прошел успешно, можете использовать данные из хранилища")
                print("ArticleFromStorage isEmpty: \(self.articlesFromStorage.isEmpty)")
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
//        cell.objectTitle.text = articlesFromStorage[indexPath.row].title
        return cell
    }
    
    //MARK: - Other Functions of MainViewController
    private func configureUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "UserDefaultsTest"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh))
    }
    @objc func refresh(send: UIRefreshControl) {
        print(articlesFromStorage[0].title ?? "Not found")
        //self.tableView.reloadData()
       }
}
