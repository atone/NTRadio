//
//  AppDelegate.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/27.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var prevButton: NSButton!
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    
    let player = RadioPlayer()

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    var allStationsMenu: NSMenu?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusItem.image = #imageLiteral(resourceName: "RadioIcon")
        
        constructMenu()
        updateStatus()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func constructMenu() {
        let menu = NSMenu()
        
        let controlItem = NSMenuItem()
        var topLevelObjects: NSArray?
        if Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ControlView"), owner: self, topLevelObjects: &topLevelObjects) {
            controlItem.view = topLevelObjects!.first(where: {$0 is NSView}) as? NSView
        }
        menu.addItem(controlItem)
        
        menu.addItem(NSMenuItem.separator())
        let allStationsMenuItem = NSMenuItem(title: NSLocalizedString("all_stations", comment: ""), action: nil, keyEquivalent: "")
        let allStationsMenu = NSMenu()
        
        for station in player.stations {
            let stationMenuItem = NSMenuItem(title: station.name, action: #selector(changeStation(_:)), keyEquivalent: "")
            allStationsMenu.addItem(stationMenuItem)
        }
        
        self.allStationsMenu = allStationsMenu
        allStationsMenuItem.submenu = allStationsMenu
        menu.addItem(allStationsMenuItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: NSLocalizedString("quit", comment: ""), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func updateStatus() {
        if player.isPlaying {
            playButton.image = #imageLiteral(resourceName: "Pause")
        } else {
            playButton.image = #imageLiteral(resourceName: "Play")
        }
        statusItem.title = player.currentPlayingTitle
        if let menuItems = allStationsMenu?.items {
            for (index, menuItem) in menuItems.enumerated() {
                if index == player.currentIndex {
                    menuItem.state = .on
                } else {
                    menuItem.state = .off
                }
            }
        }
    }
    
    
    @IBAction func togglePlayPause(_ sender: Any) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        updateStatus()
    }
    
    @IBAction func previousStation(_ sender: Any) {
        player.previous()
        updateStatus()
    }
    
    @IBAction func nextStation(_ sender: Any) {
        player.next()
        updateStatus()
    }
    
    @objc func changeStation(_ sender: Any) {
        if let menuItem = sender as? NSMenuItem,
            let index = allStationsMenu?.index(of: menuItem) {
            player.changeStation(to: index)
            updateStatus()
        }
    }
}

