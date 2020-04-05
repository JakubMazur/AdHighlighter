//
//  ViewController.swift
//  MarkerBundle
//
//  Created by Jakub Mazur on 3/28/20.
//  Copyright © 2020 Jakub Mazur. All rights reserved.
//

import Cocoa
import SafariServices

class ViewController: NSViewController {
    
    let extensionId: String = "pl.jkmazur.MarkerBundle.Highlighter"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: self.extensionId) { (state, error) in
            DispatchQueue.main.async {
                if state?.isEnabled == true {
                    print("enabled")
                } else {
                    print("not enabled")
                }
                print(state)
                print(error)
            }
        }
    }
}

