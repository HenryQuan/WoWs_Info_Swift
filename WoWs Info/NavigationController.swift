//
//  NavigationController.swift
//  WoWs Info
//
//  Created by Henry Quan on 4/2/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UserDefaults.standard.color(forKey: DataManagement.DataName.theme)
        appearance.tintColor = UIColor.white
        appearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}
