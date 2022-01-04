//
//  GameScene.swift
//  Snake
//
//  Created by Дмитрий Супрун on 30.12.21.
//

import SpriteKit
import GameplayKit

struct CollisionCatigories {
    
    static let Snake: UInt32 = 0x1 << 0 // 0001 2
    static let SnakeHead: UInt32 = 0x1 << 1 // 0010 4
    static let Apple: UInt32 = 0x1 << 2 // 0100 8
    static let EdgeBody: UInt32 = 0x1 << 3 // 1000 16
    
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.purple
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        // create left button
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 7
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        // create right button
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 75, y: view.scene!.frame.minY + 30)
        clockWiseButton.fillColor = UIColor.gray
        clockWiseButton.strokeColor = UIColor.gray
        clockWiseButton.lineWidth = 7
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        createApple()
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCatigories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCatigories.Snake | CollisionCatigories.SnakeHead
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockWiseButton" else {
                return
            }
            touchedNode.fillColor = .green
            
            if touchedNode.name == "clockWiseButton" {
                snake!.moveClockWise()

            } else if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockWise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockWiseButton" else {
                return
            }
            touchedNode.fillColor = .gray

        }
    }
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake!.move()
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX) - 20))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY) - 20))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCatigories.EdgeBody
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bodyes - CollisionCatigories.SnakeHead
        
        switch collisionObject {
            
        case CollisionCatigories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake!.addBody()
            snake?.moveSpeed += 10
            apple?.removeFromParent()
            createApple()


        case CollisionCatigories.EdgeBody:
            snake?.body.forEach { $0.removeFromParent() }
            snake?.removeFromParent()
            snake = nil
            snake = Snake(atPoint: CGPoint(x: (view?.scene!.frame.midX)!, y: (view?.scene!.frame.midY)!))
            self.addChild(snake!)
            
        default: break
        }
    }
}
