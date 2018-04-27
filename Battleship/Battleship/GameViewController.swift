//
//  GameViewController.swift
//  Battleship
//
//  Created by Favero Miguel Fernando on 4/11/18.
//  Copyright © 2018 Favero Miguel Fernando. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var menuButton : UIButton = UIButton(type: .custom)
    var attackButton: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.setTitle("Play", for: .normal)
        attackButton.setTitle("Attack Begin", for: .normal)
        
        menuButton.addTarget(self, action: #selector(StartGame), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(menuButton)
        menuButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        menuButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        menuButton.backgroundColor = .red
        
//        attackButton.addTarget(self, action: #selector(StartAttack), for: .touchUpInside)
//        attackButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(attackButton)
//
//        attackButton.backgroundColor = .blue
//        attackButton.isHidden = true
        
    }

    @objc func StartAttack()
    {
        if let view = self.view as! SKView?
        {
            if let scene = SKScene(fileNamed: "GameScene")
            {
//                scene.
            }
        }
    }
    
    @objc func StartGame()
    {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            menuButton.isHidden = true
            attackButton.isHidden = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
