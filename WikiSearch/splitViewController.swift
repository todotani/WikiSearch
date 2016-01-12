//
//  splitViewController.swift
//  WikiSearch
//
//  Created by todotani on 2015/12/27.
//  Copyright © 2015年 Todotani. All rights reserved.
//

import UIKit

class splitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //splitViewController?.preferredDisplayMode  = UISplitViewControllerDisplayMode.AllVisible
        self.delegate = self
    }
    
    // iPhoneではmaster viewを最初に表示する
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true
    }

}
