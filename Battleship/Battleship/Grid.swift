//
//  Grid.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/19/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import Foundation

protocol Grid
{
    func initialize(x: Int, y: Int, nWidth: Int, nHeight: Int, nBlockAmount: Int)
    func update(_ currentTime: TimeInterval)
}
