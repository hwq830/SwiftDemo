//
//  Item.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/6.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)class Item: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var complated: NSNumber
    @NSManaged var count: NSNumber?
    @NSManaged var creationDate: NSDate?
    @NSManaged var complationDate: NSDate?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func changeStatus(){
        if self.complated == 1 {
            self.complated = 0
        }else{
            self.complated = 1
        }
        setComplationDate()
    }
    
    func setComplationDate(){
        if self.complated == 1 {
            self.complationDate = NSDate()
        } else {
            self.complationDate = nil
        }
    }
    
    func toString() -> String{
        return "Item info :: name:\(self.name) | creationDate:\(self.creationDate) | complated:\(self.complated) | complationDate:\(self.complationDate)"
    }


}
