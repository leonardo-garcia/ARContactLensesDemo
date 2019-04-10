//
//  ViewController.swift
//  ARContactLenses
//
//  Created by Leonardo Garcia  on 4/8/19.
//

import UIKit
import ARKit

final class ContactLensesViewController: UIViewController {

    /// Set renderer
    private let sceneView = ARSCNView(frame: .zero)

    /// Declare eye nodes
    private var leftEyeNode: ImageNode?
    private var rightEyeNode: ImageNode?

    /// Specify ARConfiguration
    private let faceTrackingConfiguration = ARFaceTrackingConfiguration()

    override func loadView() {
        view = sceneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else { fatalError("A TrueDepth camera is required") }
        /// Set sceneView delegate
        sceneView.delegate = self

        /// If needed, we can set some debugOptions
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Run session
        sceneView.session.run(faceTrackingConfiguration)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /// Pause session
        sceneView.session.pause()
    }
}


extension ContactLensesViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        // Note: - You must compile this project with an iPhone with TrueDepth camera as target device, otherwise it will mark that sceneView has no `device` member

        /// Validate anchor is an ARFaceAnchor instance
        guard anchor is ARFaceAnchor,
            let device = sceneView.device else { return nil }

        /// Create node with face geometry
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)

        node.geometry?.firstMaterial?.colorBufferWriteMask = []

        /// Create eye ImageNodes
        rightEyeNode = ImageNode(width: 0.015, height: 0.015, image: #imageLiteral(resourceName: "bicolor_iris"))
        leftEyeNode = ImageNode(width: 0.015, height: 0.015, image: #imageLiteral(resourceName: "bicolor_iris"))

        /// Change the origin of the eye nodes
        rightEyeNode?.pivot = SCNMatrix4MakeTranslation(0, 0, -0.01)
        leftEyeNode?.pivot = SCNMatrix4MakeTranslation(0, 0, -0.01)

        /// Add child nodes
        rightEyeNode.flatMap { node.addChildNode($0) }
        leftEyeNode.flatMap { node.addChildNode($0) }

        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        /// Get face anchor as ARFaceAnchor
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }

        /// Update the geometry displayed on screen to be now conformed by the anchor calculated
        faceGeometry.update(from: faceAnchor.geometry)

        /// Update node transforms
        leftEyeNode?.simdTransform = faceAnchor.leftEyeTransform
        rightEyeNode?.simdTransform = faceAnchor.rightEyeTransform
    }
}
