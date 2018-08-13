//
//  ViewController.swift
//  Todoey
//
//  Created by 抜井正寛 on 2018/08/13.
//  Copyright © 2018 Masahiro Nukui. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggs", "Destory Demogorgon" ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ①セルの数を決める
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // ②どんなセルにするのかを決める
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // selectされたセルに適用する処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        // deselectedされたセルに適応する処理
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



