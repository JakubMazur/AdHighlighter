//
//  SafariExtensionViewController.swift
//  Ad Highlighter Safari Extension
//
//  Created by Jakub Mazur on 3/28/20.
//  Copyright © 2020 Jakub Mazur. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
