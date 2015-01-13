//
//  Page.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/7.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import Foundation

class Page: NSObject {
    
    var count:Int
    var offset:Int
    
    var totalCount:Int? = nil
    
    init(count:Int, offset:Int){
        self.count = count
        self.offset = offset
    }

}
