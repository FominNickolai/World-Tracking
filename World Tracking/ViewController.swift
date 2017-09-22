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
        
        let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.15))
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        cylinder.position = SCNVector3(0, 0, -0.3)
        cylinder.eulerAngles = SCNVector3(0, 0, 90.degreesToRadians)
        
        self.sceneView.scene.rootNode.addChildNode(cylinder)
        
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        pyramid.position = SCNVector3(0, 0, -0.5)
        
        cylinder.addChildNode(pyramid)
    }
    
    //MARK: - Helpers Methods
    //Random value in Range
    func randomNumbers(fristNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(fristNum - secondNum) + min(fristNum, secondNum)
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
}








