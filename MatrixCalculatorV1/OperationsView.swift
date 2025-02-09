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
//                        Text("Calculator")
//                            .frame(maxWidth: .infinity)
//                            .font(.largeTitle)
//                            .foregroundStyle(.black.opacity(0.80))
//                            .blur(radius: 8)
//                            .overlay{
//                                Text("Calculator")
//                                    .font(.largeTitle)
//                                    .foregroundStyle(.white)
//                                    .bold()
//                            }
//                            .padding(.bottom, 20)
                        
                        
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
                        
                        NavigationLink(destination: TransposeView(sW: screenWidth, sH: screenHeight)) {
                            
                            Text("Transpose")
                                .myTextStyle()
                        }
                        
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
                    .padding(.top, lenFromTop * 1.5)
                }
                .padding()
                .scrollIndicators(.hidden)
                
            }
            .navigationTitle("Calculator")
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Calculator")
                        .font(.largeTitle)
                        .foregroundStyle(.black.opacity(0.6))
                        .shadow(radius: 5)
                }
            }
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

extension View {
    func myTextStyle() -> some View {
        modifier(customTextStyle())
    }
}

#Preview {
    OperationsView()
}
