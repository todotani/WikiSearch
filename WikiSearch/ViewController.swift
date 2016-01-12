//
//  ViewController.swift
//  WikiSearch
//
//  Created by todotani on 2015/12/18.
//  Copyright © 2015年 Todotani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var WikiData:[Wiki] = [Wiki]()
    let EndPointUrl = "http://wikipedia.simpleapi.net/api?output=json&keyword="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.searchBar.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = WikiData.count
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        // textLabel may return nil when unwrap whth ?
        cell.textLabel?.text = self.WikiData[indexPath.row].title
        cell.detailTextLabel?.text = self.WikiData[indexPath.row].date
        return cell
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        
        let keyword = self.searchBar.text ?? ""     // Unwrapしてnilの時は""をセットする
        let encodedKeyword = keyword.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) ?? ""
        let query = NSURL(string: EndPointUrl + encodedKeyword)
        let request = NSURLRequest(URL: query!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if (data == nil) || (error != nil) {
                return
            }

            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [NSDictionary] {
                    self.WikiData.removeAll()
                    for dict in json {
                        let wikiItem = Wiki(wikiDictionary: dict)
                        self.WikiData.append(wikiItem)
                    }
                }
                // Send table reoload request to main thread
                dispatch_sync(dispatch_get_main_queue(), {self.tableView.reloadData()})
                } catch {
                    print(error)
                    dispatch_sync(dispatch_get_main_queue(), {self.showError("JSON Parse Error")})
                }
            })
        task.resume()
    }
    
    func showError(message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle:.Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        let wiki = self.WikiData[indexPath.row]
        var destination = segue.destinationViewController   // NavigationControllerをポイントしている
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let vc = destination as? DetailedViewController {
            vc.title = wiki.title
            vc.wikiItem = wiki
        }    
    }
}

