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
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0.2, 0.3, -0.2)
        
        
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        let minBox = boxNode.boundingBox.min
        let maxBox = boxNode.boundingBox.max
        let h = CGFloat(maxBox.y - minBox.y)
        let w = CGFloat(maxBox.x - minBox.x)
        boxNode.position = SCNVector3(0, -h / 2, 0)
        
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        let minDoor = doorNode.boundingBox.min
        let maxDoor = doorNode.boundingBox.max
        let doorH = CGFloat(maxDoor.y - minDoor.y)
        let doorW = CGFloat(maxDoor.x - minDoor.x)
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.position = SCNVector3(-((w / 2) - (doorW / 2)), -((h / 2) - (doorH / 2)), w / 2 + 0.0005)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        
        
    }
    
    //MARK: - Helpers Methods
    //Random value in Range
    func randomNumbers(fristNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(fristNum - secondNum) + min(fristNum, secondNum)
    }
}









