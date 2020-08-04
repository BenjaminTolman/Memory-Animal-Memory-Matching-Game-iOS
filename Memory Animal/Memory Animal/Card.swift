//
//  Card.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/10/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation
import UIKit

class Card
{
    var id: Int
    var img: UIImage
    
    var inPlay = false;
    
    init(id: Int, img: UIImage){
        self.id = id
        self.img = img
    }
}
