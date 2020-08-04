//
//  LeaderBoardPlayer.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/27/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

class LeaderBoardPlayer: Comparable{
   
    //Conform to comparable.
    static func < (lhs: LeaderBoardPlayer, rhs: LeaderBoardPlayer) -> Bool {
        return lhs.timeRaw < rhs.timeRaw
    }

    static func == (lhs: LeaderBoardPlayer, rhs: LeaderBoardPlayer) -> Bool {
        return lhs.timeRaw == rhs.timeRaw
    }
    
    //vars.
    var time: String
    var timeRaw = 0.0
    var name: String
    var moves: Int
    var date: String
    
    //initialization.
    init(time: String, name: String, moves: Int, date: String){
        self.time = time
        self.name = name
        self.moves = moves
        self.timeRaw = Double(time) ?? 99.00
        self.date = date
    }
    
}
