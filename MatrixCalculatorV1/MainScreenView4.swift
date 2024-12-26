//
//  MainScreenView4.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/26/24.
//

import SwiftUI

struct MainScreenView4: View {
    var body: some View {
        VStack {
            Text("Menu")
                .padding()
                .foregroundStyle(Color(red: 0.631, green: 0.424, blue: 0.78))
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.918, green: 0.773, blue: 0.792))
                .font(.title)
                .bold()
                .offset(CGSize(width: 0, height: 10.0))
            VStack {
                Button {
                    
                } label: {
                    Text("Calculator")
                }
                .buttonStyle(ExampleButton5())
                
                Button {
                    
                } label: {
                    Text("Practice")
                }
                .buttonStyle(ExampleButton5())
                
                Button {
                    
                } label: {
                    Text("Feedback")
                }
                .buttonStyle(ExampleButton5())
            }
            .padding(.vertical)
            .padding(.vertical)
            .padding(.vertical)
            .background(Color(red: 0.729, green: 0.749, blue: 0.906))
            .border(Color(red: 0.918, green: 0.773, blue: 0.792), width: 4)
            
        }
        .padding()
    }
}

#Preview {
    MainScreenView4()
}



struct ExampleButton5: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color(red: 0.918, green: 0.773, blue: 0.792))
            )
            .foregroundStyle(Color(red: 0.631, green: 0.424, blue: 0.78))
            .font(.title3)
            .bold()
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.vertical, 6)
    }
}
