//
//  DetaileedViewController.swift
//  WikiSearch
//
//  Created by todotani on 2015/12/19.
//  Copyright © 2015年 Todotani. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var wikiItem:Wiki?
    var html:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if wikiItem?.body != nil {
            html = wikiItem?.body
        } else {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            if orientation.isPortrait {
                html = "Input Search Keyword Swaiping in the Search View"
            }
        }
        webView.loadHTMLString(html!, baseURL: nil)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        webView.loadHTMLString(html!, baseURL: nil)
    }
 
}
