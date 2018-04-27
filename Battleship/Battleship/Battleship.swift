//
//  Battleship.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/18/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import Foundation
import SpriteKit

//Battleship enum used for sprite names

//2 square long
//3 square long
//4 square long
enum ShipType: UInt32{
    case twoSq = 0
    case threeSq
    case fourSq
    
    var spriteName: String{
        switch self{
        case .twoSq:
            return "battleship3"
        case .threeSq:
            return "battleship2"
        case .fourSq:
            return "battleship4"
        }
    }
}

struct ShipSpriteValues
{
    static let ship1Scale : CGFloat = 0.5
    static let ship1Rot : CGFloat = CGFloat((90 * Double.pi) / 180)
    
    static let ship2Scale : CGFloat = 0.35
    static let ship2Rot : CGFloat = CGFloat((90 * Double.pi) / 180)
    
    static let ship3Scale : CGFloat = 0.5
}


class BattleShip : GameObject
{
    let type: ShipType
    
    var canInteractWith: Bool = false
    var isPicked: Bool = false
    var originalPos: CGPoint = CGPoint(x: 0, y: 0)
    
    init(type: ShipType)
    {
        self.type = type
        
        if(type == ShipType.twoSq)
        {
            super.init(imageName: "battleship3")
        }
        else if (type == ShipType.threeSq)
        {
            super.init(imageName: "battleship2")
        }
        else if (type == ShipType.fourSq)
        {
            super.init(imageName: "battleship1")
        }
        else
        {
            super.init(imageName: "battleship1")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPicked()
    {
        originalPos = position
        canInteractWith = false
        isPicked = true
    }
    
    //update loop
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
        
    }
}
