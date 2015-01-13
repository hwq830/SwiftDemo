//
//  ToDoListUndoTableViewController.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/12.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import UIKit

class ToDoListUndoTableViewController: ToDoListTableViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isComplation = 0
    }

}
