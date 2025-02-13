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
    
    @State private var MatrixA: [[Double]] = [[0]]
    @State private var MatrixB: [[Double]] = [[0]]
    
    @Environment(\.dismiss) var dismiss
    
    var lenFromTop: Double {
        return screenHeight / 14.0
    }
    
    var body: some View {
        ZStack {
            
            Image("grid3")
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
                        .foregroundStyle(.white)
                        .blur(radius: 8)
                        .overlay{
                            Text("Calculator")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .add)) {
                        
                        Text("Add")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .subtract)) {
                        
                        Text("Subtract")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .multiply)) {
                        
                        Text("Multiply")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .transpose)) {
                        
                        Text("Transpose")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .determinant)) {
                        
                        Text("Determinant")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .inverse)) {
                        
                        Text("Inverse")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .rank)) {
                        
                        Text("Rank")
                            .myTextStyle()
                    }
                    
                    NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .power)) {
                        
                        Text("Power")
                            .myTextStyle()
                    }
                    
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
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .foregroundStyle(.orange)
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
                .padding(.top, lenFromTop)
            }
            .padding()
            .scrollIndicators(.hidden)
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct customTextStyle: ViewModifier {
    
    var textOpacity = 0.4
    
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black.opacity(textOpacity))
            )
            .font(.title.bold())
            .foregroundStyle(.white.opacity(0.8))
            .padding(.bottom, 6)
            .shadow(radius: 5)
            .shadow(radius: 6)

        
    }
}

enum MatrixOperation: String {
    case add
    case subtract
    case multiply
    case transpose = "Transpose"
    case determinant = "Determinant"
    case inverse
    case power
    case rank
}

extension View {
    func myTextStyle() -> some View {
        modifier(customTextStyle())
    }
}

#Preview {
    OperationsView()
}
