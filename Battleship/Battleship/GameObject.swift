//
//  GameObject.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/18/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import Foundation
import SpriteKit

class GameObject: SKSpriteNode
{
    var deltaTime: TimeInterval = 00
    private var lastUpdateTime: TimeInterval?
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = 1
        
        position = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// update injecting time from the game loop
    ///
    /// - Parameter currentTime: current time from the game loops
    func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        
        // calculating delta time
        deltaTime = currentTime - lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
    
    /// A simple collision detection function that will let you check if this item colides with other game objects
    ///
    /// - Parameter items: the game objects you wish to test against
    /// - Returns: an array of game objects you collided with, could be empty if no collisions
    func collision(items:[GameObject]) -> [GameObject] {
        
        var collision: Bool
        var colliders: [GameObject] = []
        
        for item in items {
            
            if item !== self {
                collision = self.frame.intersects(item.frame)
                if collision {
                    colliders.append(item)
                }
            }
        }
        
        return colliders
    }
    
    func collision(item: GameObject ) -> Bool {
        
        var collision: Bool
        
        if item !== self {
            collision = self.frame.intersects(item.frame)
            if collision {
               return true
            }
        }
        
        return false
    }
    
    func collision(point: CGPoint) -> Bool
    {
        var collision : Bool
        
        collision = self.frame.intersects(CGRect(x: point.x, y: point.y, width: 1, height: 1))
        //collision = self.frame.intersects(point)
        if(collision)
        {
            return true
        }
        
        return false
    }
    
    func cleanUp() {
        
        removeFromParent()
    }
}
