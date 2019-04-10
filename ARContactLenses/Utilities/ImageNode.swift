//
//  ImageNode.swift
//  ARContactLenses
//
//  Created by Leonardo Garcia  on 4/9/19.
//

import SceneKit

final class ImageNode: SCNNode {
    init(width: CGFloat,
         height: CGFloat,
         image: UIImage) {

        super.init()
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = image
        plane.firstMaterial?.isDoubleSided = true
        geometry = plane
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
