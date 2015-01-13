//
//  ItemDao.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/6.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import Foundation
import CoreData

class ItemService:NSObject{
    
    var entityName = "Item"
    
    var cdh:CoreDataHelper? = nil
    
    init(coreDataHelper:CoreDataHelper) {
        self.cdh = coreDataHelper
    }
    
    func insert(dataArray:[Item]){
        for data:Item in dataArray {
            var i:Item = cdh?.insertForEntityWithName(self.entityName) as Item
            i.name = data.name
            i.complationDate = data.complationDate
            i.complated = data.complated
            i.count = data.count
            i.creationDate = NSDate()
        }
        cdh?.saveContext()
    }
    
    func insertWithNames(names:[String]) -> [Item]{
        var items:[Item] = []
        for name in names {
            var i:Item = cdh?.insertForEntityWithName(self.entityName) as Item
            i.name = name
            i.complated = false
            i.creationDate = NSDate()
            
            items.append(i)
        }
        cdh?.saveContext()
        return items
    }
    
    func getModelInstance() -> Item{
        return cdh?.getEntityInstanceForName(self.entityName) as Item
    }
    
    func get(limit:Int, offset:Int) -> [Item]{
        return self.get(nil, limit: limit, offset: offset)
    }
    
    func get(name:String) ->  [Item]{
        return self.get(NSPredicate(format: "name=%@", argumentArray: [name]), limit: nil, offset: nil)
    }
    
    func get(isComplated:NSNumber?) -> [Item]{
        if let isCom=isComplated{
            return self.get(NSPredicate(format: "complated=%@", argumentArray: [isCom]), limit: nil, offset: nil)
        }else{
            return self.get(nil, limit: nil, offset: nil)
        }
    }
    
    func searchWithName(name:String) -> [Item]{
        return self.get(NSPredicate(format: "name contains %@", argumentArray: [name]), limit: nil, offset: nil)
    }
    
    func get(condition: NSPredicate?, limit:Int?, offset:Int?) ->  [Item]{
        var sort_1 = NSSortDescriptor(key: "creationDate", ascending: false)
        return cdh?.selectForEntityWithName(entityName, condition:condition, sorts:[sort_1], limit: limit, offset: offset) as [Item]
    }
    
    func deleteAll(){
        cdh?.deleteAllDataInEntity(self.entityName)
    }
    
    func deleteWithName(name:String){
        var items = self.get(name)
        for i in items {
            cdh?.deleteData(i as NSManagedObject)
        }
    }
    
    func deleteItem(item:Item){
        cdh?.deleteData(item as NSManagedObject)
    }
    
    func update(){
        cdh?.updateData()
    }
    
}