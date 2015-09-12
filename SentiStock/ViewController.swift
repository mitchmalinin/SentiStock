//
//  ViewController.swift
//  SentiStock
//
//  Created by Mitchell Malinin on 9/12/15.
//  Copyright (c) 2015 Mitchell Malinin. All rights reserved.
//

import UIKit

class tableViewCell : UITableViewCell, UITableViewDelegate {
    
    @IBOutlet var label : UILabel!
    
    // initialize the date formatter only once, using a static computed property
    
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    @IBOutlet var tableView : UITableView!
    var xmlParser : XMLParser!
    let arrayy :NSMutableArray = []
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        tableView.delegate = self
        xmlParser = XMLParser()
        xmlParser.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parsingWasFinished() {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"cell")
        
//        cell.textLabel?.text = self.arrayy[indexPath.row] as? String
        
        return cell
        
    }


}

