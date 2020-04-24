//
//  SHTabBarViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

class SHTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bookmarksNavController = UINavigationController(rootViewController: SH190617BookmarksViewController())
        bookmarksNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        bookmarksNavController.title = "Bookmarks"
        
        let contactsNavController = UINavigationController(rootViewController: SH190708ContactsViewController())
        contactsNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        contactsNavController.title = "Contacts"
        
        
        self.viewControllers = [bookmarksNavController, contactsNavController]
        self.selectedIndex = 1
        
    }

}


