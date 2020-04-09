//
//  DrawSpk.swift
//  drawcircle
//
//  Created by manogna podishetty on 11/1/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
import SwiftUI
import SpriteKit
import CoreMotion
struct SceneView: UIViewRepresentable {
    let scene: SKScene
    func makeUIView(context: Context) -> SKView {

        let view = SKView(frame: .zero)
        view.preferredFramesPerSecond = 60
        view.showsFPS = true
        view.showsNodeCount = true

        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.presentScene(scene)
    }

}
class GameScene: SKScene {
    var fingerIsOnPaddle =  false
    var circledata : [CircleState] = []
    private var currentNodes = SKNode()
    private var moving:Bool = false
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    var wid : CGFloat = 100
    var heigh : CGFloat = 100
    var updateId : (CircleState) -> () = { _ in print("empty")}
    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = SKColor.systemYellow  //background color to white
        for c in circledata{
            let cir = self.makeCirlceInPosition(cstate: c)  // Call makeCircleInPostion, send touch location.
            self.addChild(cir)
        }
        self.size = CGSize(width: wid   , height: heigh)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        motionManager.startAccelerometerUpdates()
    }
    
 

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name
        {
            if name == "circle"
            {
                currentNodes = touchedNode
                moving = true
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if moving == true {
            for touch in touches{
                let loc = touch.location(in: self)
                let vector = CGVector(dx: loc.x - currentNodes.position.x, dy: loc.y - currentNodes.position.y)
                print(vector)
                currentNodes.physicsBody?.applyImpulse(vector)
                currentNodes.physicsBody?.velocity = vector
            }
        }
        currentNodes = SKNode()
        moving = false
        print(    self.children.count)
    }


    //  Where the Magic Happens!
    func makeCirlceInPosition(cstate: CircleState) -> SKShapeNode{
        var cir  = SKShapeNode(circleOfRadius: cstate.radius/2 ) // Size of Circle
        let cen = CGPoint(x: cstate.centerCord.x , y: cstate.centerCord.y * -1)
        cir.name = "circle"
        cir.physicsBody = SKPhysicsBody(circleOfRadius: cstate.radius/2)
        cir.physicsBody?.restitution = 0.5
        cir.physicsBody!.friction = 10
        cir.position = cen
        cir.physicsBody?.mass = (27/7)*(cstate.radius/2)*(cstate.radius/2)
        cir.strokeColor = getColour(scol: cstate.colour)
        cir.fillColor = getColour(scol: cstate.colour)
        return cir
    }

    func getColour(scol : Color) -> SKColor {
        var col : [Color] = [Color.green, Color.red, Color.red, Color.red]
        switch scol {
            case Color.green:
            return SKColor.systemGreen
            case Color.red:
            return SKColor.systemRed
            case Color.blue:
            return SKColor.systemBlue
            default:
            return SKColor.black
        }
    }

    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        print("hello")
        for node in self.children {
            print(node.position)
        }
    }

}


