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
    var titleArticle: String!
    var titleDescrip : String!
    
    var datastring : String?
    
    let arrayy :NSMutableArray = []
    let arrayDescrip :NSMutableArray = []
    let arraySentiment : NSMutableArray = []
    
    let dateFormatter = NSDateFormatter()
    @IBOutlet var viewColor : UIView!
    @IBOutlet var viewColorBottom : UIView!
    @IBOutlet var arrowImg : UIImageView!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var compLabel : UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

       
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.delegate = self
        xmlParser = XMLParser()
        xmlParser.delegate = self
        let alertView = UIAlertController(title: "Company", message: "Choose the company you want to track", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alertView, animated: true, completion: nil)
        alertView.addAction(UIAlertAction(title: "Apple", style: UIAlertActionStyle.Default, handler: { action in
            self.viewColor.backgroundColor = UIColor(red: 72/255, green: 167/255, blue: 146/255, alpha: 1.0) /* #48a792 */
            self.viewColorBottom.backgroundColor = UIColor(red: 49/255, green: 121/255, blue: 105/255, alpha: 1.0) /* #317969 */

            self.arrowImg.image = UIImage(named: "up.png")
            self.priceLabel.text = "The price will increase"
            self.compLabel.text = "APPL"
            let stringUrl = "http://appleinsider.com/rss/news/"
            self.url = NSURL(string:stringUrl )
            self.defaults.setValue("apple", forKey: "company")
            self.defaults.synchronize()
            self.xmlParser.startParsingWithContentsOfURL(self.url!)
            
            //        var localNotification:UILocalNotification = UILocalNotification()
            //        localNotification.alertAction = "Testing notifications on iOS8"
            //        localNotification.alertBody = "Local notifications are working"
            //        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
            //        localNotification.soundName = UILocalNotificationDefaultSoundName
            //        localNotification.category = "invite"
            //        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            //Assining RSS Value to a dictionary
            let currentDictionary = self.xmlParser.arrParsedData
            
            //Goes over all the dictionaries in the array
            for var i=0; i<currentDictionary.count; i++ {
                
                
                self.arrayy.addObject(currentDictionary[i])
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
            self.tableView.reloadData()
        }))
        alertView.addAction(UIAlertAction(title: "HP", style: UIAlertActionStyle.Default, handler: { action in
            let stringUrl = "http://feeds.finance.yahoo.com/rss/2.0/headline?s=HPQ&region=US&lang=en-US"
            self.url = NSURL(string:stringUrl )
            self.defaults.setValue("hp", forKey: "company")
            self.defaults.synchronize()
            self.viewColor.backgroundColor = UIColor(red: 220/255, green: 71/255, blue: 89/255, alpha: 1.0) /* #dc4759 */
            self.viewColorBottom.backgroundColor = UIColor(red: 168/255, green: 50/255, blue: 64/255, alpha: 1.0) /* #a83240 */


            self.arrowImg.image = UIImage(named: "down.png")
            self.priceLabel.text = "The price will decrease"
            self.compLabel.text = "Hewlett-Packard"
            self.xmlParser.startParsingWithContentsOfURL(self.url!)

            //        var localNotification:UILocalNotification = UILocalNotification()
            //        localNotification.alertAction = "Testing notifications on iOS8"
            //        localNotification.alertBody = "Local notifications are working"
            //        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
            //        localNotification.soundName = UILocalNotificationDefaultSoundName
            //        localNotification.category = "invite"
            //        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            //Assining RSS Value to a dictionary
            let currentDictionary = self.xmlParser.arrParsedData
            
            //Goes over all the dictionaries in the array
            for var i=0; i<currentDictionary.count; i++ {
                
                
                self.arrayy.addObject(currentDictionary[i])
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
            self.tableView.reloadData()

        }))
        alertView.addAction(UIAlertAction(title: "Walmart", style: UIAlertActionStyle.Default, handler: { action in
            let stringUrl = "http://news.walmart.com/rss?feedName=financial"
            self.defaults.setValue("walmart", forKey: "company")
            self.defaults.synchronize()
            self.url = NSURL(string:stringUrl )
            self.viewColor.backgroundColor = UIColor(red: 72/255, green: 167/255, blue: 146/255, alpha: 1.0) /* #48a792 */
            self.viewColorBottom.backgroundColor = UIColor(red: 49/255, green: 121/255, blue: 105/255, alpha: 1.0) /* #317969 */

            self.arrowImg.image = UIImage(named: "up.png")
            self.priceLabel.text = "The price will increase"
            self.compLabel.text = "Wal-Mart"
            self.xmlParser.startParsingWithContentsOfURL(self.url!)
            
            //        var localNotification:UILocalNotification = UILocalNotification()
            //        localNotification.alertAction = "Testing notifications on iOS8"
            //        localNotification.alertBody = "Local notifications are working"
            //        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
            //        localNotification.soundName = UILocalNotificationDefaultSoundName
            //        localNotification.category = "invite"
            //        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            //Assining RSS Value to a dictionary
            let currentDictionary = self.xmlParser.arrParsedData
            
            //Goes over all the dictionaries in the array
            for var i=0; i<currentDictionary.count; i++ {
                
                
                self.arrayy.addObject(currentDictionary[i])
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
            self.tableView.reloadData()

        }))
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
        var compDefault = defaults.valueForKey("company") as! String
        if compDefault == "walmart" || compDefault == "apple" {
            cell.arrowImage.image = UIImage(named: "1442100968_ic_keyboard_arrow_up_48px.png")
        }
        else if compDefault == "hp" {
            cell.arrowImage.image = UIImage(named: "downarrow.png")
        }
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

