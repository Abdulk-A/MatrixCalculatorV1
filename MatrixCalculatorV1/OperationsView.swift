//
//  OperationsView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/26/24.
//

import SwiftUI

struct OperationsView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            
            Image("grid2")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.2)
            
            
            ScrollView {
                VStack {
                    Text("Calculator")
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .foregroundStyle(.black.opacity(0.80))
                        .blur(radius: 8)
                        .overlay{
                            Text("Calculator")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .padding(.bottom, 20)
                    
                    Button {
                        
                    } label: {
                        Text("Add")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Subtract")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Multiply")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Transpose")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Determinant")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Inverse")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Rank")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Power")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("Trace")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("LU Decomposition")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("QR Decomposition")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    Button {
                        
                    } label: {
                        Text("SLE")
                    }
                    .buttonStyle(ExampleButton6())
                }
                .frame(maxWidth: 500)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.gray.opacity(0.5))
                        .shadow(radius: 10)
                )
                .padding()
                .padding(.top, 20)
            }
            .padding()

            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OperationsView()
}
