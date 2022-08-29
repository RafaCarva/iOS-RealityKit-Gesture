//
//  Coordinator.swift
//  Gesture-Proj
//
//  Created by Rafael Carvalho on 29/08/22.
//

import Foundation
import ARKit
import RealityKit


class Coordinator: NSObject, ARSessionDelegate{
    
    // Essa ARView foi populada com a ARview de "ContentView.swift"
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        print("--> O objeto 3D foi tocado.")
        
        guard let view = self.view else { return }
        
        // Quando dá o tap, pega a location
        let tapLocation = recognizer.location(in: view)
        
        // O raycast é como um "raio" que sai da tela do celular.
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        // Se results tiver detectado algum plano:
        if let result = results.first {
            //Anchor
            let anchor = ARAnchor(name: "Plane Anchor", transform: result.worldTransform)
            view.session.add(anchor: anchor)
            
            //Objeto 3D
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.15))
            modelEntity.model?.materials = [SimpleMaterial(color: UIColor.randomColor(), isMetallic: true)]
            
            //Anchor Entity
            //Aqui você linka o "Anchor" no "Anchor Entity", e depois o "modelEntity" no "AnchorEntity".
            let anchorEntity = AnchorEntity(anchor: anchor)
            anchorEntity.addChild(modelEntity)
            
            //Por fim, vc add seu "anchorEntity"(que já possúi um nó com o objeto 3D) na cena.
            view.scene.addAnchor(anchorEntity)
            
        }
  
    }

}
