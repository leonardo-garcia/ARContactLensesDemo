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

    /// Specify ARConfiguration

    override func loadView() {
        super.loadView()
        view = sceneView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else { fatalError("A TrueDepth camera is required") }
        /// Set sceneView delegate

        /// If needed, we can set some debugOptions

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Run session
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /// Pause session
    }
}

extension ContactLensesViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        // Note: - You must compile this project with an iPhone with TrueDepth camera as target device, otherwise it will mark that sceneView has no `device` member

        /// Validate anchor is an ARFaceAnchor instance


        /// Create node with face geometry


        /// Create eye ImageNodes


        /// Change the origin of the eye nodes


        /// Add child nodes

        return nil
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        /// Get face anchor as ARFaceAnchor


        /// Update the geometry displayed on screen to be now conformed by the anchor calculated


        /// Update node transforms


    }
}

