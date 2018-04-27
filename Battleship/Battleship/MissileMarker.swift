//
//  MissileMarker.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/18/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import Foundation
import SpriteKit

//marker enum used for sprite names
enum MarkerType: UInt32{
    case miss = 0
    case hit
    case empty
    
    var spriteName: String{
        switch self{
        case .miss:
            return "marker1"
        case .hit:
            return "marker2"
        case .empty:
            return "marker3"
        }
    }
}


class MissileMarker : GameObject
{
    let type: MarkerType
    
    
    var canInteractWith: Bool = false
    
    
    init(type: MarkerType)
    {
        self.type = type
        
        if(type == MarkerType.miss)
        {
            super.init(imageName: "MissMarker")
        }
        else if (type == MarkerType.hit)
        {
            super.init(imageName: "HitMarker")
        }
        else if (type == MarkerType.empty)
        {
            super.init(imageName: type.spriteName)
        }
        else
        {
            super.init(imageName: "marker3")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //update loop
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
    }
}
