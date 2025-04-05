//
//  OperationsView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/26/24.
//

import SwiftUI

struct OperationsView: View {
    
    //values coming from another view//
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    //*******************************//
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                GridImageBackgroundView(name: "grid_background_new", sW: screenWidth, sH: screenHeight)
                
                VStack {
                    ScrollView {

                        
                        ForEach(MatrixOperation.allCases, id: \.self) { op in
                            if op == .add || op == .subtract || op == .multiply {
                                OperationNavView(destination: AddSubtractView(sW: screenWidth, sH: screenHeight, operationType: op), label: op.rawValue)
                                    .padding(.bottom, -3)
                            } else {
                                OperationNavView(destination: TransposeView(sW: screenWidth, sH: screenHeight, operationType: op), label: op.rawValue)
                                    .padding(.bottom, -3)
                            }
                        }
                        
                        
                    }
                    
                }
                .frame(maxWidth: 500, maxHeight: screenHeight * 0.55)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color("MenuBackgroundColor"))
                        .shadow(radius: 10)
                )
                .padding()
                .scrollIndicators(.hidden)
                

            }
            .ignoresSafeArea()
            
        }
    }
}

struct CustomTextStyle: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundColor)
            )
            .font(.title.bold())
            .foregroundStyle(.white.opacity(0.8))
            .padding(.bottom, 6)
            .shadow(radius: 5)
            .shadow(radius: 6)

        
    }
}

struct CustomDismissButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Back")
                .foregroundStyle(.orange)
        }
        .buttonStyle(ExampleButton6())
    }
}


enum MatrixOperation: String, CaseIterable {
    case add  = "Add"
    case subtract = "Subtract"
    case multiply = "Multiply"
    case transpose = "Transpose"
    case determinant = "Determinant"
    case inverse = "Inverse"
    case power = "Power"
    case rank = "Rank"
//    case sle = "SLE"
}

extension View {
    func myTextStyle(_ backgroundColor: Color) -> some View {
        modifier(CustomTextStyle(backgroundColor: backgroundColor))
    }
    
    func myBackgroundStyle(height: Double) -> some View {
        modifier(CustomBackgroundStyle(myHeight: height))
    }
}

struct OperationNavView<Destination: View>: View {
    
    let destination: Destination
    let label: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .myTextStyle(Color("ButtonBackgroundStyle"))
        }
    }
}

struct GridImageBackgroundView: View {
    
    let name: String
    let sW: Double
    let sH: Double
    
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: sW, height: sH)
            .ignoresSafeArea()
            .opacity(0.075)
    }
}

#Preview {
    OperationsView()
}


struct ExampleButton6: ButtonStyle {
    
    var backgroundColor = Color("ButtonBackgroundStyle")
    var fontColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding()
        
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(backgroundColor)
            )
            .font(.title.bold())
            

            .foregroundStyle(fontColor.opacity(0.8))
            .padding(.bottom, 6)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 6)
            
    }
}
