//
//  LeaderBoards+CoreDataProperties.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//
//

import Foundation
import CoreData


extension LeaderBoards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeaderBoards> {
        return NSFetchRequest<LeaderBoards>(entityName: "LeaderBoards")
    }

    @NSManaged public var players: Players?

}
