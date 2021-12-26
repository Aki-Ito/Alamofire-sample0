//
//  ViewController.swift
//  Alamofire-sample0
//
//  Created by 伊藤明孝 on 2021/12/27.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController {
    
    let docoder: JSONDecoder = JSONDecoder()
    var articles = [Article]()

    @IBOutlet weak var articleListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.allowsSelection = false
        getQiitaArticles()
    }
    
    private func getQiitaArticles(){
        AF.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result{
            case .success:
                do{
                    self.articles = try self.docoder.decode([Article].self, from: response.data!)
                    self.articleListTableView.reloadData()
                } catch {
                    print("decodeに失敗しました")
                }
                
            case .failure(let error):
                print("error", error)
            }
            
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleListTableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}

struct Article: Codable{
    let title: String
//    var user: User
//
//    struct User: Codable{
//        var name: String
//    }
}

