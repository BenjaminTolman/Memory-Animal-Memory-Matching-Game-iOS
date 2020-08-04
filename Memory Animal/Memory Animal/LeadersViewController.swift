//
//  LeadersViewController.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit

class LeadersViewController: UIViewController {
    
    var leaders = [LeaderBoardPlayer]()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Set up view.
        textView.text = nil
        
        textView.text += "LeaderBoard \n\n"
        
        leaders.sort()
        
        //Put leaderboard together.
        for l in leaders{
            
            textView.text += "\n \(l.name)\n Time: \(l.time.description) \n Moves: \(l.moves.description) \n \(l.date) \n\n"
            
        }
    }
}
