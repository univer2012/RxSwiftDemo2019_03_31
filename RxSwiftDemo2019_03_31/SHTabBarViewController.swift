//
//  SHTabBarViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

class SHTabBarViewController: UITabBarController {

    fileprivate var willRemoveContainer = Set<String>()
    
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
        
        //不会崩溃
        let hkSet = self.willRemoveContainer.filter {
            $0.hasSuffix("HK")
        }
        print("hkSet=\(hkSet)")
        
        
        let str = ""
        if Double(str) != 0 {
            print("str != 0") // po Double(str) = nil
        } else {
            print("str == 0")
        }
        
        self.enumBreak(with: 1, b: 1)
        self.enumBreak(with: 1, b: 2)
    }
    
    private func enumBreak(with s:Int, b: Int) {
        switch s {
        case 1:
            if b == 1 {
                print("b == 1")
                break       //不会再指向下面的`print("b != 1")`代码了
            }
            print("b != 1")
        default:
            break
        }
    }

}


