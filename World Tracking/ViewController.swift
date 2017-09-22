//
//  ViewController.swift
//  World Tracking
//
//  Created by Fomin Nickolai on 22.09.17.
//  Copyright © 2017 Fomin Nickolai. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    //MARK: - @IBOutets
    @IBOutlet weak var sceneView: ARSCNView!
    
    //MARK: - Properties
    let configuration = ARWorldTrackingConfiguration()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    //MARK: - Restart Session
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    //MARK: - @IBActions
    @IBAction func resetPressed(_ sender: UIButton) {
        self.restartSession()
        
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        let node = SCNNode()
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //node.geometry = SCNCone(topRadius: 0, bottomRadius: 0.1, height: 0.3)
        //node.geometry = SCNCylinder(radius: 0.2, height: 0.1)
        //node.geometry = SCNSphere(radius: 0.1)
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0))
        
        //// Color Declarations
        
        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 0.5, y: 0))
        starPath.addLine(to: CGPoint(x: 0.69, y: 0.28))
        starPath.addLine(to: CGPoint(x: 1, y: 0.38))
        starPath.addLine(to: CGPoint(x: 0.8, y: 0.66))
        starPath.addLine(to: CGPoint(x: 0.81, y: 1))
        starPath.addLine(to: CGPoint(x: 0.5, y: 0.88))
        starPath.addLine(to: CGPoint(x: 0.19, y: 1))
        starPath.addLine(to: CGPoint(x: 0.2, y: 0.66))
        starPath.addLine(to: CGPoint(x: 0, y: 0.38))
        starPath.addLine(to: CGPoint(x: 0.31, y: 0.28))
        starPath.addLine(to: CGPoint(x: 0.5, y: 0))
        starPath.close()
        
        let shape = SCNShape(path: starPath, extrusionDepth: 0.1)
        
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let x = randomNumbers(fristNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(fristNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(fristNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x, y, z)
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    //MARK: - Helpers Methods
    //Random value in Range
    func randomNumbers(fristNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(fristNum - secondNum) + min(fristNum, secondNum)
    }
}









