//
//  ViewController.swift
//  SentiStock
//
//  Created by Mitchell Malinin on 9/12/15.
//  Copyright (c) 2015 Mitchell Malinin. All rights reserved.
//

import UIKit

extension NSDate {
    convenience init?(jsonDate: String) {
        let prefix = "/Date("
        let suffix = ")/"
        let scanner = NSScanner(string: jsonDate)
        
        // Check prefix:
        if scanner.scanString(prefix, intoString: nil) {
            
            // Read milliseconds part:
            var milliseconds : Int64 = 0
            if scanner.scanLongLong(&milliseconds) {
                // Milliseconds to seconds:
                var timeStamp = NSTimeInterval(milliseconds)/1000.0
                
                // Read optional timezone part:
                var timeZoneOffset : Int = 0
                if scanner.scanInteger(&timeZoneOffset) {
                    let hours = timeZoneOffset / 100
                    let minutes = timeZoneOffset % 100
                    // Adjust timestamp according to timezone:
                    timeStamp += NSTimeInterval(3600 * hours + 60 * minutes)
                }
                
                // Check suffix:
                if scanner.scanString(suffix, intoString: nil) {
                    // Success! Create NSDate and return.
                    self.init(timeIntervalSince1970: timeStamp)
                    return
                }
            }
        }
        
        // Wrong format, return nil. (The compiler requires us to
        // do an initialization first.)
        self.init(timeIntervalSince1970: 0)
        return nil
    }
}

class tableViewCell : UITableViewCell, UITableViewDelegate {
    
    @IBOutlet var label : UILabel!
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var arrowImage : UIImageView!
    
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
    
    let dateFormatter = NSDateFormatter()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        xmlParser = XMLParser()
        xmlParser.delegate = self
        url = NSURL(string:stringUrl )
        
        xmlParser.startParsingWithContentsOfURL(url!)
        
//        var localNotification:UILocalNotification = UILocalNotification()
//        localNotification.alertAction = "Testing notifications on iOS8"
//        localNotification.alertBody = "Local notifications are working"
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
//        localNotification.soundName = UILocalNotificationDefaultSoundName
//        localNotification.category = "invite"
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        //Assining RSS Value to a dictionary
        let currentDictionary = xmlParser.arrParsedData
        
        //Goes over all the dictionaries in the array
        for var i=0; i<currentDictionary.count; i++ {
            
            
            arrayy.addObject(currentDictionary[i])
            //            var titlee = currentDictionary[i]["title"]
            //            var urlString = "http://sentiment.vivekn.com/api/" + titlee! + "/"
            //            var url: NSURL = NSURL(string: urlString)!
            //            var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
            //            var bodyData = "data=something"
            //            request.HTTPMethod = "POST"
            //            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            //            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            //                {
            //                    (response, data, error) in
            //                    println(response)
            //
            //            }
            
        }
        
        
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
        
        let rssFeedItem: AnyObject = self.arrayy[indexPath.row]
        dateFormatter.dateFormat = "hh:mm"
        //let rssFeedDateGetter = rssFeedItem.valueForKey("pubDate") as! String
        //let rssFeedDateConverted = NSDate(jsonDate: rssFeedDateGetter)
        //let rssFeedDateString = dateFormatter.stringFromDate(rssFeedDateConverted!)
        let rssFeedTitle = rssFeedItem.valueForKey("title") as! String
        cell.label.text = rssFeedTitle
        //cell.timeLabel.text = rssFeedDateString
        return cell
        
    }
    
    
}

