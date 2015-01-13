//
//  AddItemViewController.swift
//  TestCoreData
//
//  Created by 胡伟琪 on 15/1/6.
//  Copyright (c) 2015年 胡伟琪. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var itemName: UITextField!
    
    var iName:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if sender !== self.saveButton{
            return
        }
        
        if !self.itemName.text.isEmpty {
            self.iName = self.itemName.text
        }
        
    }

}
