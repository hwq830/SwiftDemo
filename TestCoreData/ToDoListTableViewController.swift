//
//  ToDoListTableViewController.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/6.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import UIKit
//import CoreData

class ToDoListTableViewController: UITableViewController {
    
    var items:[Item] = []
    let itemService:ItemService? = nil
    
    var isComplation:NSNumber? = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.itemService = appDelegate.itemService
    }
    
    func writeTestData(){
        var i = itemService?.get(1,offset:0)
        if i?.count == 0 {
            NSLog("======writeTestData")
            itemService?.deleteAll()
            var names = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"]
            itemService?.insertWithNames(names)
        }
    }

    func initLoadData(){
        writeTestData()
        var its = itemService?.get(self.isComplation)
//        var its = itemService?.get(50, offset: 0)
//        var its = itemService?.get("Milk")
//        var its = itemService?.searchWithName("o")
        items = its!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLoadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TablePrototypeCell", forIndexPath: indexPath) as UITableViewCell
        
        var item = items[indexPath.row]
        let df:NSDateFormatter = NSDateFormatter()
        
        
        
        //cell.textLabel?.text = "\(item.name)|\(dateFormat(item.creationDate!))"
        var v_name:UILabel = cell.viewWithTag(1) as UILabel
        v_name.text = item.name
        if let cDate1 = item.creationDate?{
            var v_creationDate:UILabel = cell.viewWithTag(2) as UILabel
            v_creationDate.text = "创建时间:\(dateFormat(item.creationDate!))"
        }

        if let cDate2 = item.complationDate?{
            var v_complationDate:UILabel = cell.viewWithTag(3) as UILabel
            v_complationDate.text = "完成时间:\(dateFormat(cDate2))"
        }
        
        var v_img:UIImageView = cell.viewWithTag(5) as UIImageView
        //UIImage.
        v_img.image = UIImage(named: "logo-30.png")
        
        if item.complated == 1 {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        NSLog("---------\(item.name)---\(item.complated)")

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var item = items[indexPath.row]
        item.changeStatus()
        itemService?.update()
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue){
        var source: AddItemViewController = segue.sourceViewController as AddItemViewController
        if source.iName != nil {
            var n:String = source.iName!
            var its:[Item]? = itemService?.insertWithNames([n])
            if its != nil{
                var i:Item = its!.first!
                self.items.insert(i, atIndex: 0)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func edittt(){
        NSLog("{}{}{}{}{}{}{}{}{}{")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            if self.items.count >= indexPath.row {
                itemService?.deleteItem(self.items[indexPath.row])
                self.items.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    func dateFormat(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: NSGregorianCalendar)
        let dateStr = formatter.stringFromDate(date)
        return dateStr
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        NSLog("[][][][][][][][][]")
    }
    

}
