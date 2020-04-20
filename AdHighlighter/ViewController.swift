//
//  ViewController.swift
//  Ad Highlighter
//
//  Created by Jakub Mazur on 3/28/20.
//  Copyright © 2020 Jakub Mazur. All rights reserved.
//

import Cocoa
import SafariServices

class ViewController: NSViewController {
    let extensionId: String = "pl.jkmazur.adHighlighter.safari"

    @IBOutlet weak var buttonView: NSView!
    @IBOutlet weak var actionButton: NSButton!
    @IBOutlet weak var statusButton: NSButton!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var jkmazurButton: NSButton!
    @IBOutlet weak var karoButton: NSButton!
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.attributedStringValue = self.createTitle()
        self.checkIfInstalled()
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { (_) in
            self.checkIfInstalled()
        }
        self.timer?.fire()
    }
    
    @IBAction func footerButtonClicked(_ sender: NSButton) {
        let url: String
        if sender === jkmazurButton {
            url = "https://twitter.com/jkmazur"
        } else if sender === karoButton {
            url = "https://karokaro.myportfolio.com"
        } else {
            url = ""
        }
        if let valid = URL(string: url) {
            NSWorkspace.shared.open(valid)
        }
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.view.layer?.backgroundColor = NSColor(hue:0.58, saturation:0.91, brightness:0.09, alpha:1.00).cgColor
//        self.buttonView.layer?.backgroundColor = NSColor(hue:0.60, saturation:0.76, brightness:0.33, alpha:1.00).cgColor
    }
    
    private func createTitle() -> NSAttributedString {
        let nameValue = NSAttributedString(string: "Ad Highlighter", attributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 18)])
        let subtitle = NSAttributedString(string: "\n\nSafari extension that helps you distinguish what is an ad & what is search result", attributes: [NSAttributedString.Key.foregroundColor: NSColor.white, NSAttributedString.Key.font: NSFont.systemFont(ofSize: 12)])
        let joined = NSMutableAttributedString(attributedString: nameValue)
        joined.append(subtitle)
        return joined
    }
    
    @IBAction func actionButtonClicked(_ sender: NSButton) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: self.extensionId) { (error) in
            NSLog("Error \(String(describing: error))")
        }
    }
    
    private func checkIfInstalled() {
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: self.extensionId) { (state, error) in
            DispatchQueue.main.async {
                if state?.isEnabled == true {
                    self.statusButton.image = NSImage(named: "NSStatusAvailable")
                    self.statusButton.title = "Safari Extension is active 🎉"
                    self.actionButton.title = "Disable?"
                } else {
                    self.statusButton.image = NSImage(named: "NSStatusUnavailable")
                    self.statusButton.title = "Safari Extension is currently inactive"
                    self.actionButton.title = "Activate NOW in Safari"
                }
            }
        }
    }
}

