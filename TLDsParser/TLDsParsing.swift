//
//  TLDsParsing.swift
//  Ad Highlighter TLDs Parser
//
//  Created by Jakub Mazur on 4/20/20.
//  Copyright © 2020 Jakub Mazur. All rights reserved.
//


/*
 Thanks to this list there all Google TLDs - it's downloaded into tld.html and use this useless generated ViewController
 to printing a result and copy it into plist file.
 https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/List_of_Google_domains.html
*/


import Cocoa

class TLDsParsing: NSObject {
    static func parseTLDs() {
        let url = Bundle(for: Self.self).url(forResource: "tld", withExtension: "html")
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
    
    static func createInfoPlistEntries(from countries: [String]) {
        let entries = countries.map { "<string>*.google." + $0 + "</string>" }
        entries.forEach { print($0) }
    }
}
