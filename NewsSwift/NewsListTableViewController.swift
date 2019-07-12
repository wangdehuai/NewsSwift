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
    let DataSource = [String]()
    
    func POSTWithURLSession(_ urlString:String,parmas:[String:Any],mathFunction:@escaping (_ responObject:AnyObject)->Void){
        let session = URLSession.shared
        let str = self.parmasStringWithParmas(parmas)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = str.data(using: .utf8)
        let task = session.dataTask(with:request, completionHandler: { (data, respons, error) -> Void in
            if data != nil{
                let responsobject = try?JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                if responsobject == nil{
                    mathFunction("没有内容" as AnyObject)
                }else{
                    mathFunction(responsobject! as AnyObject)
                }
            }else{
                mathFunction("file" as AnyObject)
            }
        })
        task.resume()
    }
    
    func GETWithURLSession(_ urlString:String,parmas:[String:Any],mathFunction:@escaping (_ responObject:AnyObject)->Void){
        let session = URLSession.shared
        let str = self.parmasStringWithParmas(parmas)
        let url = URL(string: "\(urlString)?\(str)")
        let task = session.dataTask(with: url!, completionHandler: { (data, respons, eror) -> Void in
            if data != nil{
                let responsobject = try?JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if responsobject == nil{
                    mathFunction("没有内容" as AnyObject)
                }else{
                    mathFunction(responsobject! as AnyObject)
                }
            }else{
                mathFunction("file" as AnyObject)
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        POSTWithURLSession(APIURL, parmas: [:]) { (AnyObject) in
            print(AnyObject)
        }
    }
    
    func parmasStringWithParmas(_ parmas:[String:Any])->String{
        var parString = String()
        for (key, value) in parmas{
            parString.append(contentsOf: "\(key)=\(value)")
        }
        return parString
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "asdf"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        show(UIViewController(), sender: nil)
    }
    
}



