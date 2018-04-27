//
//  BattleGrid.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/24/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import Foundation
import SpriteKit

class BattleGrid : Grid
{    
    var gridCenter : CGPoint = CGPoint(x : 0, y : 0)
    var width : Int = 0
    var height : Int = 0
    var blockAmount : Int = 0
    
    var columnSize : Int = 0
    var rowSize : Int = 0
    
    var gridBlocks : [CGPoint] = []
    
    func initialize(x: Int, y: Int, nWidth: Int, nHeight: Int, nBlockAmount: Int)
    {
        width = nWidth
        height = nHeight
        blockAmount = nBlockAmount
        
        gridCenter = CGPoint(x: x, y: y)
        
        columnSize = nWidth / nBlockAmount
        rowSize = nHeight / nBlockAmount
        
        for i in 1...nBlockAmount
        {
            for j in 1...nBlockAmount
            {
                let blockPosx = (x - (width/2) + ((columnSize * i) - (columnSize / 2)))
                let blockPosy = (y - (height/2) + ((rowSize * j) - (rowSize / 2)))
                
                var point : CGPoint = CGPoint()
                point.x = CGFloat(blockPosx)
                point.y = CGFloat(blockPosy)
                
                gridBlocks.append(point)
            }
        }
    }
    
    func update(_ currentTime: TimeInterval)
    {
        
    }
    
    func drawGrid() -> [UIImageView]
    {        
        var images: [UIImageView] = []
        
        var rect = CGRect()
        var image = UIImageView()
        
        rect.origin = CGPoint(x: (gridCenter.x - CGFloat(width / 2)), y: (gridCenter.y - CGFloat(height / 2)))
        rect.size = CGSize(width: width, height: 1)
        
        image = UIImageView(frame: rect)
        image.backgroundColor = UIColor.black
        images.append(image)
        
        
       // var image2 = UIImageView()
        rect.origin = CGPoint(x: (gridCenter.x - CGFloat(width / 2)), y: (gridCenter.y - CGFloat(height / 2)))
        rect.size = CGSize(width: 1, height: height)
        
        image = UIImageView(frame: rect)
        image.backgroundColor = UIColor.black
        images.append(image)
        
        
        //var image3 = UIImageView()
        rect.origin = CGPoint(x: (gridCenter.x + CGFloat(width / 2)), y: (gridCenter.y + CGFloat(height / 2)))
        rect.size = CGSize(width: 1, height: -height)
        
        image = UIImageView(frame: rect)
        image.backgroundColor = UIColor.black
        images.append(image)
        
        
        //var image4 = UIImageView()
        rect.origin = CGPoint(x: (gridCenter.x + CGFloat(width / 2)), y: (gridCenter.y + CGFloat(height / 2)))
        rect.size = CGSize(width: -width, height: 1)
        
        image = UIImageView(frame: rect)
        image.backgroundColor = UIColor.black
        images.append(image)
        
        for j in 1...(blockAmount - 1)
        {
            //var image = UIImageView()
            rect.origin = CGPoint(x: CGFloat((gridBlocks[(j * blockAmount) - 1].x) + CGFloat(columnSize / 2)) , y: (gridCenter.y - CGFloat(height / 2)))
            rect.size = CGSize(width: 1, height: height)
            
            image = UIImageView(frame: rect)
            image.backgroundColor = UIColor.black
            images.append(image)
        }
        
        for j in 1...(blockAmount - 1)
        {
            //var image = UIImageView()
            rect.origin = CGPoint(x: (gridCenter.x - CGFloat(width / 2)), y: CGFloat((gridBlocks[(j - 1)].y) + CGFloat(rowSize / 2)))
            rect.size = CGSize(width: width, height: 1)
            
            image = UIImageView(frame: rect)
            image.backgroundColor = UIColor.black
            images.append(image)
        }
        
        return images
    }
}
