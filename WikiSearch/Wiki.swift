//
//  Wiki.swift
//  WikiSearch
//
//  Created by todotani on 2015/12/19.
//  Copyright © 2015年 Todotani. All rights reserved.
//

import UIKit

class Wiki {   // SwiftのClassはNSObjectを継承する必要はない
    var title:String = ""
    var url:String = ""
    var body:String = ""
    var date:String = ""
    
    init(wikiDictionary:NSDictionary) {
        if let titleValue = wikiDictionary["title"] {
            if let title = titleValue as? String {
                self.title = title
            }
        }
        
        if let urlValue = wikiDictionary["url"] {
            if let url = urlValue as? String {
                self.url = url
            }
        }
        
        if let bodyValue = wikiDictionary["body"] {
            if let body = bodyValue as? String {
                self.body = body
            }
        }
        
        if let dateValue = wikiDictionary["datetime"] {
            if let date = dateValue as? String {
                self.date = date.substringToIndex(date.startIndex.advancedBy(10))
            }
        }
    }
    
}
