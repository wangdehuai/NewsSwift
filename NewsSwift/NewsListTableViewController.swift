//
//  NewsListTableViewController.swift
//  NewsSwift
//
//  Created by wangdehuai on 14/12/21.
//  Copyright (c) 2014年 wangdehuai. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Label: UILabel!
    let APIURL = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo-1&pagePer=10&list.htm"
    let DataSource = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataSource(){
        let url = NSURL(string: APIURL)
        let request = NSURLRequest(URL: url!)
        let LoadQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: LoadQueue) { (response, data, error) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let NewsDataSource = json["item"] as NSArray
            var CurrentNewsData = NSMutableArray()
            for currentnews in NewsDataSource{
                let newsitem = NewsItem()
                newsitem.NewsTitle = currentnews["title"] as NSString
                newsitem.NewsID = currentnews["id"] as NSString
                newsitem.NewsThumb = currentnews["thumb"] as NSString
                
                CurrentNewsData.addObject(newsitem)
            }
//            self.DataSource = CurrentNewsData
            self.tableView.reloadData()
        }

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
        return DataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reusingCell")
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = DataSource[indexPath.row].NewsTitle
        cell.detailTextLabel?.text = DataSource[indexPath.row].NewsID
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cellSegue", sender: self)
    }
    
}
