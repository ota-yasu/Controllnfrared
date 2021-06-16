//
//  Todo.swift
//  ControlInfrared
//
//  Created by 恭弘 on 2018/01/09.
//  Copyright © 2018年 恭弘. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    @objc dynamic var category = ""
    @objc dynamic var type = ""
    @objc dynamic var signal = ""
}

class Block: Object {
    @objc dynamic var position_x = ""
    @objc dynamic var position_y = ""
    @objc dynamic var size_x = ""
    @objc dynamic var size_y = ""
    @objc dynamic var type = ""
    @objc dynamic var text = ""

}
