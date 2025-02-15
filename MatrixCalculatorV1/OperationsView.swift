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
                    
                    OperationNavView(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .add), label: "Add")
                    
                    OperationNavView(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .subtract), label: "Subtract")
                    
                    OperationNavView(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: .multiply), label: "Multiply")
                    
                    OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .transpose), label: "Transpose")
                    
                    OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .determinant), label: "Determinant")
                    
                    OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .inverse), label: "Inverse")

                    OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .rank), label: "Rank")

                    OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: .power), label: "Power")

                    
                    Button {
                        
                    } label: {
                        Text("Trace")
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
    case add  = "Add"
    case subtract = "Subtract"
    case multiply = "Multiply"
    case transpose = "Transpose"
    case determinant = "Determinant"
    case inverse = "Inverse"
    case power = "Power"
    case rank = "Rank"
    case sle = "SLE"
}

extension View {
    func myTextStyle() -> some View {
        modifier(customTextStyle())
    }
}

struct OperationNavView<Destination: View>: View {
    
    let destination: Destination
    let label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .myTextStyle()
        }
    }
}

#Preview {
    OperationsView()
}
