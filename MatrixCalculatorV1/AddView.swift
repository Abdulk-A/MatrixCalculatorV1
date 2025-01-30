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
    
    @State private var matrixA: [[Double]] = [[0]]
    @State private var matrixB: [[Double]] = [[0]]
    
    @State private var result: [[Double]] = [[0]]
    
    var topBottomSegment: Double {
        screenHeight / 6.0
    }
    
    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack {
                
                Spacer()
                
                ResultView(result: $result, screenWidth: screenWidth, screenHeight: screenHeight)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Matrix A")
                        Spacer()
                        Text("\(matrixA.count) X \(matrixA[0].count)")
                        Image(systemName: "square.and.pencil")
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Matrix B")
                        Spacer()
                        Text("\(matrixB.count) X \(matrixB[0].count)")
                        Image(systemName: "square.and.pencil")
                    }
                    .padding(.horizontal)
                    
                }
                .font(.title)
                .foregroundStyle(.white)
                
                .frame(width: screenWidth, height: topBottomSegment)
                .background(.black.opacity(0.65))
                .clipShape(.rect(cornerRadius: 15))
            }
            
            

        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}
