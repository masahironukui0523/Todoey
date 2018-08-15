//
//  item.swift
//  Todoey
//
//  Created by 抜井正寛 on 2018/08/14.
//  Copyright © 2018 Masahiro Nukui. All rights reserved.
//

import Foundation

// ファイル名と同じクラス名にする
class Item: Codable {
    var title : String = ""
    var done: Bool = false
}
