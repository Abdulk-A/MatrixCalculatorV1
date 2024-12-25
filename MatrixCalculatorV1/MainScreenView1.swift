//
//  MainScreenView1.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/24/24.
//

import SwiftUI

struct MainScreenView1: View {
    var body: some View {
        
        VStack {
            Text("Matrix Operations")
                .font(.largeTitle)

            ScrollView {
                VStack {
                    Button {
                        
                    } label: {
                        Text("Add")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Subtract")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Multiply")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Transpose")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Determinant")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Rank")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Inverse")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Power")
                    }
                    .buttonStyle(ExampleButton1())
                    
                    Button {
                        
                    } label: {
                        Text("Feedback")
                    }
                    .foregroundStyle(.blue)
                    .buttonStyle(ExampleButton1(fontColor: .black))
                    
                }
                .padding()
            }
        }

    }
}

#Preview {
    MainScreenView1()
}

struct ExampleButton1: ButtonStyle {
    
    var fontColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .font(.title2)
            .background(.red.opacity(0.6))
            .foregroundStyle(fontColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding(.bottom, 8)
            
    }
}
