//
//  ViewController.swift
//  Todoey
//
//  Created by 抜井正寛 on 2018/08/13.
//  Copyright © 2018 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // NaviBarのタイトルを大きく表示させる
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let newItem = Item()
        newItem.title = "宿題をする"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "牛乳を買う"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "手紙を書く"
        itemArray.append(newItem3)
        
        
        
        // defaultsからデータの取り出し
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    
    
    // MARK - TableViewデータソースメソッド
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // セルの数を指定
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // チェックマーク
        // Ternary operator
        // value = 条件 ? tureの場合の処理 : falseの場合の処理
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
        
    }
    
    
    
    
    // MARK - チェックマーク機能
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルに実行される処理
        
        let cell = tableView.cellForRow(at: indexPath)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // マジカルメソッド！！　TableViewデータソースメソッドを呼び出しセルにチェックマークを反映
        tableView.reloadData()
        
        // セルを選択した時の背景の変化を遅くする
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    // MARK - 新規アイテム追加機能
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // プラスボタンが押された時に実行される処理
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "新しいアイテムを追加", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "リストに追加", style: .default) { (action) in
            // 「リストに追加」を押された時に実行される処理
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // アイテム追加処理
            self.itemArray.append(newItem)
            
            // defaultsにデータを保存
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいアイテム"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK - スワイプでのアイテム削除機能
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // アイテム削除処理
        itemArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }

    
}



