//
//  Player.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

public class Player{ //TODO google sortable again.
    
    var name: String
    var time: Double //Sort by this.
    var turns: Int
    var timeDate: String
    
    //computed properties?
    
    init(name:String, time:Double, turns:Int, timeDate:String){
        self.name = "ben"
        self.time = 4.43
        self.turns = 22
        self.timeDate = "22/32/3234"
    }
}
