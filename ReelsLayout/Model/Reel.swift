//
//  Reel.swift
//  ReelsLayout
//
//  Created by darktech4 on 30/11/2023.
//

import Foundation

struct Reel: Identifiable{
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLike: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "Reel 1", authorName: "Jack"),
    .init(videoID: "Reel 2", authorName: "Adam"),
    .init(videoID: "Reel 3", authorName: "Jame"),
    .init(videoID: "Reel 4", authorName: "Alyssa"),
    .init(videoID: "Reel 5", authorName: "Join"),
]
