//
//  AddView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/28/25.
//

import SwiftUI

struct AddView: View {
    
    let screenWidth: Double
    let screenHeight: Double
    
    @State private var matrixA = Matrix([[0]])
    @State private var matrixB = Matrix([[0]])
    
    @State private var result = Matrix([[0]])
    
    var topBottomSegment: Double {
        screenHeight / 6.0
    }
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: screenWidth, sH: screenHeight)
            
            VStack {
                
                Spacer()
                
                ResultView(result: result, screenWidth: screenWidth, screenHeight: screenHeight, operationType: .add)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Matrix A")
                        Spacer()
                        Text("\(matrixA.rows) X \(matrixA.cols)")
                        Image(systemName: "square.and.pencil")
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Matrix B")
                        Spacer()
                        Text("\(matrixB.rows) X \(matrixB.cols)")
                        Image(systemName: "square.and.pencil")
                    }
                    .padding(.horizontal)
                    
                }
                .font(.title)
                .foregroundStyle(.white)
                
                .frame(width: screenWidth, height: topBottomSegment)
                .background(Color("ButtonBackgroundStyle").opacity(0.65))
                .clipShape(.rect(cornerRadius: 15))
            }
            
            

        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}
