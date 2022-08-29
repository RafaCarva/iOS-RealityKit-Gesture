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
        
        //Aqui ele faz um caast do valor para ModelEntity.
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            
            // Esse UIColor.random() vem do UIColor+Extensions.swift
            let material = SimpleMaterial(
                color: UIColor.randomColor(),
                isMetallic: true
            )
            entity.model?.materials = [material]
        }
        
    }

    
    
}
