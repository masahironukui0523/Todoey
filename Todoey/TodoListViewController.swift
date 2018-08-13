//
//  ViewController.swift
//  Todoey
//
//  Created by 抜井正寛 on 2018/08/13.
//  Copyright © 2018 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // 前から順番にセルに入る
    var itemArray = ["宿題をする", "牛乳を買う", "手紙を書く" ]

    let defaults = UserDefaults.standard
    
    // MARK - セルの数を指定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タイトルの大きさを変更
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // defaultsからデータの取り出し
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
        
    }
    
    
    
    // MARK - セルのカスタマイズ
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    
    
    // MARK - チェックマーク機能
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルに実行される処理
        
        let cell = tableView.cellForRow(at: indexPath)
        
        // チェックマーク
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        // 選択を外されたセルに実行される処理
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    // MARK - アイテム追加機能
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // プラスボタンが押された時に実行される処理
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "新しいリストを追加", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "リストに追加", style: .default) { (action) in
            // 「リストに追加」を押された時に実行される処理
            
            // 配列に追加
            self.itemArray.append(textField.text!)
            
            // defaultsにデータを保存
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // 更新
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいアイテム"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK - アイテム削除機能
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 配列から削除
        itemArray.remove(at: indexPath.row)
        // 更新
        tableView.reloadData()
        
    }
    
}



