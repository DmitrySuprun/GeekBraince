//
//  Apple.swift
//  Snake
//
//  Created by Дмитрий Супрун on 3.01.22.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .red
        strokeColor = .orange
        lineWidth = 2
        
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCatigories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
