//
//  ViewController.swift
//  MarkerBundle
//
//  Created by Jakub Mazur on 3/28/20.
//  Copyright © 2020 Jakub Mazur. All rights reserved.
//

//https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/List_of_Google_domains.html

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "tld", withExtension: "html")
        let content = try! Data(contentsOf: url!)
        let parsed = String(data: content, encoding: .utf8)!
        let lines = parsed.components(separatedBy: "\n")
        var tlds: [String] = []
        for item in lines {
            if item.contains("url"), item.contains("external") {
                let countryDomain = item.split(separator: "\"")
                let prefix: String = "http://google."
                if let fullDomain = countryDomain.filter({ $0.contains(prefix) }).first {
                    let tld = String(fullDomain).replacingOccurrences(of: prefix, with: "")
                    tlds.append(tld)
                }
            }
        }
        self.createInfoPlistEntries(from: tlds)
    }
    
    func createInfoPlistEntries(from countries: [String]) {
        let entries = countries.map { "<string>*.google." + $0 + "</string>" }
        entries.forEach { print($0) }
    }

}

