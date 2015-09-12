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
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var data = NSMutableData()
    var url : NSURL!
    let stringUrl = "http://appleinsider.com/rss/news/"
    var titleArticle: String!
    var titleDescrip : String!
    
    var datastring : String?
    
    let arrayy :NSMutableArray = []
    let arrayDescrip :NSMutableArray = []
    let arraySentiment : NSMutableArray = []
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        tableView.delegate = self
        xmlParser = XMLParser()
        xmlParser.delegate = self
        url = NSURL(string:stringUrl )

        xmlParser.startParsingWithContentsOfURL(url!)

        
        
        //Assining RSS Value to a dictionary
        let currentDictionary = xmlParser.arrParsedData
        println(xmlParser.arrParsedData)
        
        //Goes over all the dictionaries in the array
        for var i=0; i<currentDictionary.count; i++ {
            
            //Checks fields of the dictionary
            for (field, value) in currentDictionary[i] {
                if (field == "title" && value.rangeOfString("Apple") != nil) {
                    
                    //Arrays for titles and descirptions get set up
                    arrayy.addObject(currentDictionary[i]["title"]!)
                    arrayDescrip.addObject(currentDictionary[i]["title"]!)
                    
                    
                    
                    
                }
            }
            
        }
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
        return arrayy.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:"cell")
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! tableViewCell

       cell.label?.text = self.arrayy[indexPath.row] as? String
        
        return cell
        
    }


}

