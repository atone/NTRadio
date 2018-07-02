//
//  AppDelegate.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/27.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Cocoa
import MediaPlayer

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var prevButton: NSButton!
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    
    var allStationsWindowController: StationsWindowController?
    
    let player = RadioPlayer()

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    var allStationsMenu: NSMenu?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let storyboard = NSStoryboard(name: NSStoryboard.Name("AllStations"), bundle: nil)
        allStationsWindowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("StationsWindowController")) as? StationsWindowController
        
        statusItem.image = #imageLiteral(resourceName: "RadioIcon")
        
        constructMenu()
        updateMenuStatus()
        
        if #available(OSX 10.12.2, *) {
            registerRemoteCommandCenter()
            updateNowPlaying()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func constructMenu() {
        let menu = NSMenu()
        
        let controlItem = NSMenuItem()
        var topLevelObjects: NSArray?
        if Bundle.main.loadNibNamed(NSNib.Name("ControlView"), owner: self, topLevelObjects: &topLevelObjects) {
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
        
        let editStationsMenuItem = NSMenuItem(title: "Edit Stations...", action: #selector(editStations(_:)), keyEquivalent: "")
        menu.addItem(editStationsMenuItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: NSLocalizedString("quit", comment: ""), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func updateMenuStatus() {
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
    
    @available(OSX 10.12.2, *)
    func registerRemoteCommandCenter() {
        let center = MPRemoteCommandCenter.shared()
        center.pauseCommand.addTarget { [unowned self] (event)  in
            self.player.pause()
            self.updateMenuStatus()
            self.updateNowPlaying()
            return MPRemoteCommandHandlerStatus.success
        }
        center.playCommand.addTarget { [unowned self] (event) in
            self.player.play()
            self.updateMenuStatus()
            self.updateNowPlaying()
            return MPRemoteCommandHandlerStatus.success
        }
        
        center.togglePlayPauseCommand.addTarget { [unowned self] (event) in
            self.togglePlayPause(self)
            return MPRemoteCommandHandlerStatus.success
        }
        center.nextTrackCommand.addTarget { [unowned self] (event) in
            self.nextStation(self)
            return MPRemoteCommandHandlerStatus.success
        }
        center.previousTrackCommand.addTarget { [unowned self] (event) in
            self.previousStation(self)
            return MPRemoteCommandHandlerStatus.success
        }
    }
    
    @available(OSX 10.12.2, *)
    func updateNowPlaying() {
        let infoCenter = MPNowPlayingInfoCenter.default()
        var playingInfo: [String: Any] = [:]
        playingInfo[MPMediaItemPropertyTitle] = player.currentPlayingTitle
        playingInfo[MPNowPlayingInfoPropertyMediaType] = NSNumber(value: MPNowPlayingInfoMediaType.audio.rawValue)
        playingInfo[MPNowPlayingInfoPropertyIsLiveStream] = NSNumber(value: true)
        infoCenter.nowPlayingInfo = playingInfo
        infoCenter.playbackState = player.isPlaying ? MPNowPlayingPlaybackState.playing : MPNowPlayingPlaybackState.paused
    }
    
    
    @IBAction func togglePlayPause(_ sender: Any) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        updateMenuStatus()
        if #available(OSX 10.12.2, *) {
            updateNowPlaying()
        }
    }
    
    @IBAction func previousStation(_ sender: Any) {
        player.previous()
        updateMenuStatus()
        if #available(OSX 10.12.2, *) {
            updateNowPlaying()
        }
    }
    
    @IBAction func nextStation(_ sender: Any) {
        player.next()
        updateMenuStatus()
        if #available(OSX 10.12.2, *) {
            updateNowPlaying()
        }
    }
    
    @objc func changeStation(_ sender: Any) {
        if let menuItem = sender as? NSMenuItem,
            let index = allStationsMenu?.index(of: menuItem) {
            player.changeStation(to: index)
            updateMenuStatus()
            if #available(OSX 10.12.2, *) {
                updateNowPlaying()
            }
        }
    }
    
    @objc func editStations(_ sender: Any) {
        allStationsWindowController?.showWindow(sender)
    }
}

