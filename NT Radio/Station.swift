//
//  Station.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/27.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Foundation

struct Station {
    let name: String
    let url: URL
    
    static let all: [Station]  = [
        Station(name: "中国之声", url: URL(string: "http://ngcdn001.cnr.cn/live/zgzs/index.m3u8")!),
        Station(name: "经济之声", url: URL(string: "http://ngcdn002.cnr.cn/live/jjzs/index.m3u8")!),
        Station(name: "音乐之声", url: URL(string: "http://ngcdn003.cnr.cn/live/yyzs/index.m3u8")!),
        Station(name: "经典音乐广播", url: URL(string: "http://ngcdn004.cnr.cn/live/dszs/index.m3u8")!),
        Station(name: "中华之声", url: URL(string: "http://ngcdn005.cnr.cn/live/zhzs/index.m3u8")!),
        Station(name: "神州之声", url: URL(string: "http://ngcdn006.cnr.cn/live/szzs/index.m3u8")!),
        Station(name: "华夏之声", url: URL(string: "http://ngcdn007.cnr.cn/live/hxzs/index.m3u8")!),
        Station(name: "香港之声", url: URL(string: "http://ngcdn008.cnr.cn/live/xgzs/index.m3u8")!),
        Station(name: "民族之声", url: URL(string: "http://ngcdn009.cnr.cn/live/mzzs/index.m3u8")!),
        Station(name: "文艺之声", url: URL(string: "http://ngcdn010.cnr.cn/live/wyzs/index.m3u8")!),
        Station(name: "老年之声", url: URL(string: "http://ngcdn011.cnr.cn/live/lnzs/index.m3u8")!),
        Station(name: "藏语广播", url: URL(string: "http://ngcdn012.cnr.cn/live/zygb/index.m3u8")!),
        Station(name: "维语广播", url: URL(string: "http://ngcdn013.cnr.cn/live/wygb/index.m3u8")!),
        Station(name: "娱乐广播", url: URL(string: "http://ngcdn014.cnr.cn/live/ylgb/index.m3u8")!),
        Station(name: "中国交通广播", url: URL(string: "http://ngcdn016.cnr.cn/live/gsgljtgb/index.m3u8")!),
        Station(name: "中国乡村之声", url: URL(string: "http://ngcdn017.cnr.cn/live/xczs/index.m3u8")!),
        Station(name: "哈语广播", url: URL(string: "http://ngcdn025.cnr.cn/live/hygb/index.m3u8")!),
        Station(name: "相声小品频道", url: URL(string: "http://ngcdn023.cnr.cn/live/xsxp/index.m3u8")!),
        Station(name: "古典音乐频道", url: URL(string: "http://ngcdn022.cnr.cn/live/gdyy/index.m3u8")!),
        Station(name: "长篇联播频道", url: URL(string: "http://ngcdn024.cnr.cn/live/cplb/index.m3u8")!),
        Station(name: "中国民乐频道", url: URL(string: "http://ngcdn021.cnr.cn/live/zgmy/index.m3u8")!),
        Station(name: "环球资讯", url: URL(string: "http://sk.cri.cn/905.m3u8")!),
        Station(name: "Easy FM", url: URL(string: "http://sk.cri.cn/915.m3u8")!),
        Station(name: "Hit FM", url: URL(string: "http://sk.cri.cn/887.m3u8")!),
        Station(name: "Piano Solo Live", url: URL(string: "http://pianosolo.streamguys.net/live")!),
        Station(name: "WTWW Transmitter 1", url: URL(string: "http://64.235.54.14:8015/")!),
        Station(name: "WTWW Transmitter 2", url: URL(string: "http://64.235.54.14:8020/")!),
        Station(name: "WTWW Transmitter 3", url: URL(string: "http://64.235.54.14:8026/")!)
    ]
}

extension Station: CustomStringConvertible {
    var description: String {
        return name
    }
}

extension Station: Equatable {
    static func ==(lhs: Station, rhs: Station) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
