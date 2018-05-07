//
//  ViewController.swift
//  Architects Game
//
//  Created by Martin Saporiti on 05/05/2018.
//  Copyright © 2018 Martin Saporiti. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration();

    let architects_images = ["anselmo", "lautaro", "manuel", "tomas", "andres", "pablete"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                       ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
       // self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration);
        

        weak var timer: Timer?
        timer?.invalidate()   
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.addNode()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func add(_ sender: Any) {
        self.addNode()
    }
    
    
    func addNode(){
        let node = SCNNode(geometry: SCNBox(width: 0.08, height: 0.08, length: 0.08, chamferRadius: 0.0))
        
        //        let node = SCNNode(geometry: SCNSphere(radius: 0.1))
        
        // Obtengo un nombre de imagen aleatorio
        let randomIndex = Int(arc4random_uniform(UInt32(self.architects_images.count)))
        let image = UIImage(named: architects_images[randomIndex])
        
        
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = image
        node.geometry?.materials = [imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial, imageMaterial]
        //        node.geometry?.materials = [imageMaterial]
        
        
        let x = randomNumbers(firstNum: -0.5, secondNum: 0.5)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.2, secondNum: -0.8)
        
        
        node.position = SCNVector3(x, y, z)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        
        self.sceneView.scene.rootNode.addChildNode(node);
        
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options:
            [.resetTracking, .removeExistingAnchors])
    }
    
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
}

