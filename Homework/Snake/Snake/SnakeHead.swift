//
//  SnakeHead.swift
//  Snake
//
//  Created by Дмитрий Супрун on 3.01.22.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point:CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCatigories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCatigories.EdgeBody | CollisionCatigories.Apple | CollisionCatigories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
