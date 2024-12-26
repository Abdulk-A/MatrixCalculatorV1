//
//  PlaygroundView1.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/25/24.
//

import SwiftUI

struct PlaygroundView1: View {
    var body: some View {
        VStack {
            VStack {
                Text("Menu")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.red.opacity(0.75))
                            .shadow(radius: 5)
                    )
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .offset(CGSize(width: 0, height: -20.0))
                    .shadow(radius: 5)
                    
                VStack {
                    Button {
                        
                    } label: {
                        Text("Calculator")
                    }
                    .buttonStyle(ExampleButton4())
                    
                    Button {
                        
                    } label: {
                        Text("Practice")
                    }
                    .buttonStyle(ExampleButton4())
                    
                    Button {
                        
                    } label: {
                        Text("Feedback")
                    }
                    .buttonStyle(ExampleButton4())
                }
                .padding()
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
            }
            .padding(.top)
            .background(.gray.opacity(0.5))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.red.opacity(0.75), lineWidth: 3)
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PlaygroundView1()
}

struct ExampleButton4: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding()
        
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.red.opacity(0.75))
            )
            .font(.title)
            .foregroundStyle(.white)
            .padding(.bottom, 6)
            .shadow(radius: 5)
    }
}
