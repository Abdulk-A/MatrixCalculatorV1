//
//  MainScreenView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/25/24.
//

import SwiftUI

struct MainScreenView2: View {
    var body: some View {
        VStack {
            Text("Matrix Operations")
                .font(.largeTitle)
                .foregroundStyle(.white)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Calculator")
            }
            .buttonStyle(ExampleButton2())
            
            Button {
                
            } label: {
                Text("Practice")
            }
            .buttonStyle(ExampleButton2())
            
            Button {
                
            } label: {
                Text("Help")
            }
            .buttonStyle(ExampleButton2())
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.765, green: 0.765, blue: 0.89))
    }
}

#Preview {
    MainScreenView2()
}

struct ExampleButton2: ButtonStyle {
    
    var fontColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .font(.title2)
            .background(Color(red: 0.408, green: 0.408, blue: 0.706).opacity(0.6))
            .foregroundStyle(fontColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding(.bottom, 8)
            
    }
}
