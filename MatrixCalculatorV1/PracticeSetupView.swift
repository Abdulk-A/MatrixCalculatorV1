//
//  PracticeSetupView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/19/25.
//

import SwiftUI

struct PracticeSetupView: View {
    
    let screenWidth: Double
    let screenHeight: Double
    
    @State private var operationsPicked: [MatrixOperations] = []
    
    @State private var isOperationsSelected = false
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: screenWidth, sH: screenHeight)
            
            VStack {
                Text("Practice")
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .blur(radius: 8)
                    .overlay{
                        Text("Practice")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .bold()
                    }
                VStack {
                    
                    
                    
                    Button {
                        isOperationsSelected.toggle()
                    } label: {
                        Text("Operations")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    if isOperationsSelected {
                        VStack {
                            
                        }
                    }
                    
                    
                    Button {
                        
                    } label: {
                        Text("Timer")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    

                    Button {
                        
                    } label: {
                        Text("Continue")
                    }
//                    .buttonStyle(ExampleButton6(fontColor: .blue))
//                    .buttonStyle(ExampleButton6(buttonOpacity: 0.5, fontColor: .blue))
                    .buttonStyle(ExampleButton6(buttonOpacity: 0.8, backgroundColor: .blue, fontColor: .white))

                }
                .padding()
            }
            .frame(maxWidth: 500)
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color("MenuBackgroundColor"))
                    .shadow(radius: 10)
            )
            .padding()
            
                
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PracticeSetupView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}
