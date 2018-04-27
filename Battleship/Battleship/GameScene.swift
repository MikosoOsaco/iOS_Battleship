//
//  GameScene.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/11/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Values {
    
    //Screen values
    static let screenSize = UIScreen.main.bounds
    
    //Background
    static let bgZPOS : CGFloat = -1
    static let bgScale : CGFloat = 5
    static let bgName : String = "sea_bg"
    
    //Grid
    static let gridPos : CGPoint = CGPoint(x: 200, y: 350)
    static let gridWidth : Int = 300
    static let gridHeight : Int = 300
    static let gridBlocks : Int = 5
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private let background = SKSpriteNode(imageNamed: Values.bgName)
    
    private var hitMarkers: [MissileMarker] = []
    private var missMarkers: [MissileMarker] = []
    
    private let ship1 = BattleShip(type: ShipType.twoSq)
    private let ship2 = BattleShip(type: ShipType.threeSq)
    private let ship3 = BattleShip(type: ShipType.fourSq)
    private var ships: [BattleShip] = []
    
    private let battleGrid = BattleGrid.init()
    
    private var attackPhase: Bool = false
    
        
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.text = "BattleShip"
            label.fontColor = UIColor.black
            label.position = CGPoint(x: 0, y: 500)
            label.run(SKAction.fadeIn(withDuration: 3.0), withKey: "labelFadeIn")
        }
        
        backgroundColor = SKColor.black
        background.zPosition = Values.bgZPOS
        background.position = CGPoint(x: 0, y: 0)
        background.setScale(Values.bgScale)
        addChild(background)
        
        //init grid
        battleGrid.initialize(x: Int(Values.gridPos.x), y: Int(Values.gridPos.y), nWidth: Values.gridWidth, nHeight: Values.gridHeight, nBlockAmount: Values.gridBlocks)
        
        //print grid on screen
        for image in battleGrid.drawGrid()
        {
            self.view?.addSubview(image)
        }
        
        addChild(ship1)
        //ship1.position = CGPoint(x: 0, y: 0)
        ship1.position = convertPoint(fromView: battleGrid.gridBlocks[Int(arc4random_uniform(UInt32(battleGrid.gridBlocks.count)))])
        
        ship1.setScale(ShipSpriteValues.ship1Scale)
        ship1.zRotation = ShipSpriteValues.ship1Rot
        
        addChild(ship2)
        var tempPos = CGPoint()
        
        tempPos = convertPoint(fromView: battleGrid.gridBlocks[Int(arc4random_uniform(UInt32(battleGrid.gridBlocks.count)))])
        while (tempPos == ship1.position)
        {
            tempPos = convertPoint(fromView: battleGrid.gridBlocks[Int(arc4random_uniform(UInt32(battleGrid.gridBlocks.count)))])
        }
        ship2.zRotation = ShipSpriteValues.ship2Rot
        ship2.position = tempPos
        ship2.setScale(ShipSpriteValues.ship2Scale)
        
        addChild(ship3)
        while ((tempPos == ship1.position) || (tempPos == ship2.position))
        {
            tempPos = convertPoint(fromView: battleGrid.gridBlocks[Int(arc4random_uniform(UInt32(battleGrid.gridBlocks.count)))])
        }
        //ship3.position = CGPoint(x: 0, y: -200)
        ship3.position = tempPos
        ship3.setScale(ShipSpriteValues.ship3Scale)
        
        ships = [ship1, ship2, ship3]
    }
    
    func activateAttack()
    {
        attackPhase = true
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        if(attackPhase)
        {
            
        }
        else
        {
            //loop through ships on grid
            for ship in ships
            {
                //set it so you can pick them up when you click down
                ship.canInteractWith = true
                ship.isPicked = false
                
                //if the position of the click collides with ship frame, set the ship to picked
                if ship.collision(point: pos)
                {
                    ship.getPicked()
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        if attackPhase
        {
            
        }
        else
        {
            //loop through ships on grid
            for ship in ships
            {
                //if ship is picked, make it so the ship tracks the mouse position
                if ship.isPicked
                {
                    ship.position = pos
                }
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        if attackPhase
        {
            var goodMarker: Bool = true
            var tmpMarker : MissileMarker?
            
            for marker in hitMarkers
            {
                if(marker.collision(point: pos))
                {
                    goodMarker = false
                }
            }
            
            for marker in missMarkers
            {
                if(marker.collision(point: pos))
                {
                    goodMarker = false
                }
            }
            
            // let tmpMarker = MissileMarker(type: MarkerType.empty)
            if goodMarker
            {
                var tmpX: CGFloat = 0
                var tmpY: CGFloat = 0
                
                // make the tmp position = first block center point for now
                tmpX = battleGrid.gridBlocks[0].x
                tmpY = battleGrid.gridBlocks[0].y
                
                //loop through points on grid
                for p in battleGrid.gridBlocks
                {
                    //if the distance to new point is shorter than distance to last point (tmp)
                    if(abs(convertPoint(toView: pos).x - p.x) <= abs(convertPoint(toView: pos).x - tmpX))
                    {
                        if(abs(convertPoint(toView: pos).y - p.y) <= abs(convertPoint(toView: pos).y - tmpY))
                        {
                            //make tmp = new point
                            tmpX = p.x
                            tmpY = p.y
                        }
                    }
                }
                
                for ship in ships
                {
                    if(ship.collision(point: convertPoint(fromView: CGPoint(x: tmpX, y: tmpY))))
                    {
                        tmpMarker = MissileMarker(type: MarkerType.hit)
                    }
                }
                
                if(tmpMarker == nil)
                {
                    tmpMarker = MissileMarker(type: MarkerType.miss)
                }
                
                addChild(tmpMarker!)
                tmpMarker?.position = convertPoint(fromView: CGPoint(x: tmpX, y: tmpY))
                tmpMarker?.setScale(0.2)
            }
        }
        else
        {
            var tmpX: CGFloat = 0
            var tmpY: CGFloat = 0
            
            //loop through ships on grid
            for ship in ships
            {
                //if the ship is picked
                if ship.isPicked
                {
                    // make the tmp position = first block center point for now
                    tmpX = battleGrid.gridBlocks[0].x
                    tmpY = battleGrid.gridBlocks[0].y
                    
                    //loop through points on grid
                    for p in battleGrid.gridBlocks
                    {
                        //if the distance to new point is shorter than distance to last point (tmp)
                        if(abs(convertPoint(toView: ship.position).x - p.x) <= abs(convertPoint(toView: ship.position).x - tmpX))
                        {
                            if(abs(convertPoint(toView: ship.position).y - p.y) <= abs(convertPoint(toView: ship.position).y - tmpY))
                            {
                                //make tmp = new point
                                tmpX = p.x
                                tmpY = p.y
                            }
                        }
                    }
                    
                    //set ship position to be tmp (closest point found)
                    ship.position = convertPoint(fromView: CGPoint(x: tmpX, y: tmpY))
                    
                    //loop through ships on grid
                    for tmpShip in ships
                    {
                        //dont check for the same ship thats picked
                        if(tmpShip !== ship)
                        {
                            //if picked ship is colliding with another ship on the grid
                            if(ship.collision(item: tmpShip))
                            {
                                //set ship position = to original position where it was picked from
                                //keep ships from overlapping
                                ship.position = ship.originalPos
                            }
                        }
                    }
                }
                //set it so you can pick up the ship again
                ship.canInteractWith = true
                ship.isPicked = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //call every ships update
        for ship in ships
        {
            ship.update(currentTime)
        }
        
        if(self.label?.hasActions() == false)
        {
            self.label?.removeFromParent()
        }
    }
}
