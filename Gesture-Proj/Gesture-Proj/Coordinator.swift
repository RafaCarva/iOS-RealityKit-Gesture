//
//  Coordinator.swift
//  Gesture-Proj
//
//  Created by Rafael Carvalho on 29/08/22.
//

import Foundation
import ARKit
import RealityKit


class Coordinator: NSObject{
    
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
            
            //AnchorEntity
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            //Objeto 3D
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.15))
            
            //Aciona o colisor para identificar as edições
            modelEntity.generateCollisionShapes(recursive: true)
            
            modelEntity.model?.materials = [SimpleMaterial(color: UIColor.randomColor(), isMetallic: true)]
            
            //Associar o ModelEntity com o AnchorEntity
            anchorEntity.addChild(modelEntity)
            
            view.scene.addAnchor(anchorEntity)
            //Aciona o uso de gestures
            view.installGestures(.all, for: modelEntity)
            
        }
  
    }

}


//ARAnchor é para ARKit Framework
//AnchorEntity é para: RealityKit Framework
