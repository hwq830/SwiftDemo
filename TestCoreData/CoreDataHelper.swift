//
//  CoreDataManager.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/6.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper: NSObject {
    
    init(storeName:String) {
        super.init()
        self.storeName = storeName
    }
    
    var storeName:String? = nil
    
    func saveContext () {
        var error: NSError? = nil
        if self.context.hasChanges && !self.context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }else{
            NSLog("saveContext : Successed")
        }
    }
    
    var context: NSManagedObjectContext {
        if _managedObjectContext == nil {
            let coordinator = self.coordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil
    
//    lazy var context: NSManagedObjectContext? = {
//        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
//        let coordinator = self.coordinator
//        if coordinator == nil {
//            return nil
//        }
//        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = coordinator
//        return managedObjectContext
//    }()
    
//    lazy var backgroundContext: NSManagedObjectContext? = {
//        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
//        let coordinator = self.coordinator
//        if coordinator == nil {
//            return nil
//        }
//        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = coordinator
//        return managedObjectContext
//    }()

    lazy var objectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource(self.storeName!, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var coordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.objectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.storeName).sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.me.TestCoreData" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    /*
     * 返回一个用于写入的Model实例
     */
    func insertForEntityWithName(entityName:String) -> AnyObject{
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context)
    }
    
    /*
     * 通过entityName获取实例对象
     */
    func getEntityInstanceForName(entityName:String) -> NSManagedObject{
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: self.context)
        return NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.context)
    }
    
    /*
     * 查询对象列表
     */
    func selectForEntityWithName(entityName:String, condition: NSPredicate?, sorts: [NSSortDescriptor]?, limit:Int?, offset:Int?) -> [AnyObject] {
                        
        var request : NSFetchRequest = NSFetchRequest(entityName: entityName)
        if let l = limit? {
            request.fetchLimit = l
        }
        if let o = offset? {
            request.fetchOffset = o
        }
        request.predicate = condition
        request.sortDescriptors = sorts
        
        var error:NSError? = nil
        var items:[Item] = context.executeFetchRequest(request, error: &error) as [Item]
        for i:Item in items {
            NSLog(i.toString())
            //NSLog("creationDate : \(i.creationDate)")
        }
        return items

    }
    
    /*
     * 删除entity中的所有记录
     */
    func deleteAllDataInEntity(entityName:String) {
        var error:NSError? = nil
        var fReq:NSFetchRequest = NSFetchRequest(entityName: entityName)
        var result = self.context.executeFetchRequest(fReq, error: &error)
        println(result?.count)
        for resultItem in result! {
            self.context.deleteObject(resultItem as NSManagedObject)
        }
        self.saveContext()
    }
    
    /*
     * 删除指定对象
     */
    func deleteData(obj:NSManagedObject){
        var error:NSError? = nil
        self.context.deleteObject(obj)
        self.saveContext()
    }
    
    func updateData(){
        self.saveContext()
    }

    
}
