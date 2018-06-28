//
//  RadioPlayer.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/27.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Foundation
import AVFoundation

class RadioPlayer {
    
    let stations = Station.all
    
    var currentPlayingTitle: String {
        return _station.name
    }
    
    var currentIndex: Int {
        return _setting.currentIndex
    }
    
    var isPlaying: Bool {
        return _setting.isPlaying
    }
    
    private let _player: AVPlayer = AVPlayer(playerItem: nil)
    private var _station: Station
    private let _setting = AppSetting.shared
    
    init() {
        _station = stations[_setting.currentIndex]
        if _setting.isPlaying {
            _player.replaceCurrentItem(with: AVPlayerItem(url: _station.url))
            _player.play()
        }
    }
    
    func play() {
        if !_setting.isPlaying {
            _setting.isPlaying = true
            _player.replaceCurrentItem(with: AVPlayerItem(url: _station.url))
            _player.play()
        }
    }
    
    func pause() {
        if _setting.isPlaying {
            _setting.isPlaying = false
            _player.pause()
            _player.replaceCurrentItem(with: nil)
        }
    }
    
    func previous() {
        _setting.currentIndex = (_setting.currentIndex - 1 + stations.count) % stations.count
        changeStation(to: stations[_setting.currentIndex])
    }
    
    func next() {
        _setting.currentIndex = (_setting.currentIndex + 1) % stations.count
        changeStation(to: stations[_setting.currentIndex])
    }
    
    func changeStation(to index: Int) {
        guard index >= 0 && index < stations.count else { return }
        if _setting.currentIndex != index {
            _setting.currentIndex = index
            changeStation(to: stations[index])
        }
    }
    
    private func changeStation(to station: Station) {
        if station != _station {
            _station = station
            if _setting.isPlaying {
                _player.replaceCurrentItem(with: AVPlayerItem(url: _station.url))
                _player.play()
            }
        }
    }
}
