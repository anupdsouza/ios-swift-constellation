//
//  ContentView.swift
//  SwiftConstellation
//
//  Created by Anup D'Souza on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var blinking: Bool = false
    @State private var percentage: CGFloat = 0
    
    var body: some View {
        ZStack {
            // MARK: Space background
            Color.black
            
            GeometryReader { geometryProxy in
                // MARK: Nearer stars, larger & blinking
                Path { path in
                    addStars(100, in: &path, radius: 1.5, geometryProxy: geometryProxy)
                }
                .fill(Color.white)
                .opacity(blinking ? 0.8 : 0.4)
                .animation(.easeInOut(duration: 2.0).delay(2.0).repeatForever(autoreverses: true), value: blinking)
                
                // MARK: Distant stars, smaller & faded
                Path { path in
                    addStars(100, in: &path, radius: 1, geometryProxy: geometryProxy)
                }
                .fill(Color.white)
                .opacity(0.4)
                
                VStack {
                    // MARK: Constellation stars, slightly larger & colored golden
                    let size: CGFloat = 200
                    Path { path in
                        addStar(in: &path, radius: 2.5, posX: size*0.565, posY: size*0.145)
                        addStar(in: &path, radius: 2.5, posX: size*0.79, posY: size*0.62)
                        addStar(in: &path, radius: 2.5, posX: size*0.845, posY: size*0.825)
                        addStar(in: &path, radius: 2.5, posX: size*0.67, posY: size*0.775)
                        addStar(in: &path, radius: 2.5, posX: size*0.5, posY: size*0.82)
                        addStar(in: &path, radius: 2.5, posX: size*0.1, posY: size*0.58)
                        addStar(in: &path, radius: 2.5, posX: size*0.525, posY: size*0.63)
                        addStar(in: &path, radius: 2.5, posX: size*0.175, posY: size*0.25)
                        addStar(in: &path, radius: 2.5, posX: size*0.475, posY: size*0.475)
                        addStar(in: &path, radius: 2.5, posX: size*0.26, posY: size*0.205)
                        addStar(in: &path, radius: 2.5, posX: size*0.63, posY: size*0.505)
                    }
                    .fill(Color(uiColor: UIColor(red: 223/255.0, green: 224/255.0, blue: 161/255.0, alpha: 1.0)))
                    .opacity(blinking ? 1.0 : 0.6)
                    .animation(.easeInOut(duration: 1.0).delay(2.0).repeatForever(autoreverses: true), value: blinking)
                }
                .frame(width: 200, height: 200)
                .position(x: geometryProxy.frame(in: .local).midX, y: geometryProxy.frame(in: .local).midY)
                .overlay {
                    SwiftBird()
                        .trim(from: 0, to: percentage)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round, dash: [3.0]))
                        .frame(width: 200, height: 200)
                        .animation(.easeInOut(duration: 5.0), value: percentage)
                        .onAppear {
                            self.percentage = 1.0
                        }
                }
            }
        }
        .onAppear {
            withAnimation {
                blinking.toggle()
            }
        }
        .ignoresSafeArea()
    }
    
    private func addStars(_ count: Int, in path: inout Path, radius: CGFloat, geometryProxy: GeometryProxy) {
        for _ in 0..<count {
            let x = CGFloat(Int.random(in: 0..<Int(geometryProxy.size.width)))
            let y = CGFloat(Int.random(in: 0..<Int(geometryProxy.size.height)))
            addStar(in: &path, radius: radius, posX: x, posY: y)
        }
    }
    
    private func addStar(in path: inout Path, radius: CGFloat, posX: CGFloat, posY: CGFloat) {
        path.move(to: CGPoint(x: posX + radius, y: posY))
        path.addArc(center: CGPoint(x: posX, y: posY), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
