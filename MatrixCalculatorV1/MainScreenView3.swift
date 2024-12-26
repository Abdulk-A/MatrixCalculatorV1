//
//  MainScreenView3.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/25/24.
//

import SwiftUI

struct MainScreenView3: View {
    var body: some View {
        VStack {
            Text("Menu")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.bottom, 8)
                .overlay(BottomBorder().stroke(Color.red.opacity(0.75), lineWidth: 3))
            

            VStack {
                Button {
                    
                } label: {
                    Text("Calculator")
                }
                .buttonStyle(ExampleButton3())
                
                Button {
                    
                } label: {
                    Text("Practice")
                }
                .buttonStyle(ExampleButton3())
                
                
                Button {
                    
                } label: {
                    Text("Feedback")
                }
                .buttonStyle(ExampleButton3())
            }
            .padding(.top)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.orange.opacity(0.8))
        )
        .padding()
    }
}

#Preview {
    MainScreenView3()
}


struct ExampleButton3: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title2)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.red.opacity(0.75))
                    .shadow(radius: 3)
            )
            .padding(.vertical, 8)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
}


struct BottomBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}
