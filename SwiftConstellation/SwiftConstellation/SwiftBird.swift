//
//  SwiftBird.swift
//  SwiftLogoDrawing
//
//  Created by Anup D'Souza on 27/09/23.
//

import SwiftUI

struct SwiftBird: Shape {
    func path(in rect: CGRect) -> Path {
        let size = min(rect.width, rect.height)
        var path = Path()
        
        path.move(to: CGPoint(x: 0.565, y: 0.145))
        for (ptX, ptY, controlPtX, controlPtY): (CGFloat, CGFloat, CGFloat, CGFloat) in [
            (0.79, 0.62, 0.85, 0.34),       // path A -> B
            (0.845, 0.825, 0.88, 0.75),     // path B -> C
            (0.67, 0.775, 0.78, 0.715),     // path C -> D
            (0.5, 0.82, 0.6, 0.82),         // path D -> E
            (0.1, 0.58, 0.25, 0.8),         // path E -> F
            (0.525, 0.63, 0.325, 0.735),    // path F -> G
            (0.175, 0.25, 0.305, 0.445),    // path G -> H
            (0.475, 0.475, 0.36, 0.405),    // path H -> I
            (0.26, 0.205, 0.4, 0.405),      // path I -> J
            (0.63, 0.505, 0.465, 0.405),    // path J -> K
            (0.565, 0.145, 0.7, 0.355),     // path K -> A
        ] {
            path.addQuadCurve(
                to: CGPoint(x: ptX, y: ptY),
                control: CGPoint(x: controlPtX, y: controlPtY)
            )
        }
        
        path.closeSubpath()
        path = path.applying(.init(scaleX: size, y: size))
        return path
    }
}
