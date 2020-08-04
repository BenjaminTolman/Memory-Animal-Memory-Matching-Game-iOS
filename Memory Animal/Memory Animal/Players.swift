//
//  Players.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

public class Players: NSObject, NSCoding{
    
    //This is a custom class for LeaderBoard data.
    
    public var players: [Player] = []
    
    enum Key:String{
        case players = "players"
    }
    
    init(players: [Player]){
        self.players = players
    }
   
    
    public func encode(with coder: NSCoder) {
        coder.encode(players, forKey: Key.players.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mPlayers = coder.decodeObject(forKey: Key.players.rawValue) as! [Player]
        self.init(players: mPlayers)
    }
}
