//
//  KanjiWritingView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/30/24.
//

import SwiftUI

struct KanjiWritingView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        ZStack {
            VStack {
                Path { path in
                    
                    if let firstPoint = manager.points.first {
                        path.move(to: CGPoint(x: Double(firstPoint.x), y: Double(firstPoint.y)))
                        manager.points.dropFirst().forEach {
                            path.addLine(to: CGPoint(x: Double($0.x), y: Double($0.y)))
                        }
                    }
                    
                    manager.strokes.forEach { stroke in
                        if let firstPoint = stroke.points.first {
                            path.move(to: CGPoint(x: Double(firstPoint.x), y: Double(firstPoint.y)))
                            stroke.points.dropFirst().forEach {
                                path.addLine(to: CGPoint(x: Double($0.x), y: Double($0.y)))
                            }
                        }
                    }
                    
                    
                }
                .stroke(Color(red: 0.851, green: 0.851, blue: 0.851), lineWidth: 5)
                Text(manager.answer)
            }
        }
        .contentShape(Rectangle())
        .frame(width: 350, height: 350)
        .gesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in
                    manager.addPoint(value.location)
                }
                .onEnded { value in
                    manager.addPoint(value.location)
                    manager.finishStroke()
                }
        )
    }
}


#Preview {
    KanjiWritingView()
        .environmentObject(Manager())
}
