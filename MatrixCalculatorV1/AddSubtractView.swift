//
//  AddView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/29/25.
//

import SwiftUI

struct AddSubtractView: View {
    
    
    
    let screenWidth: Double
    let screenHeight: Double
    let isAdd: Bool
    
    @State private var matrixA: [[Double]] = [[0]]
    @State private var matrixB: [[Double]] = [[0]]
    
    @State private var result: [[Double]] = [[0]]
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
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
                            .bold()
                        Spacer()
                        NavigationLink(destination: MultipleMatrixView(screenWidth: screenWidth, screenHeight: screenHeight, numRows: $numRows, numCols: $numCols, matrixA: $matrixA, matrixB: $matrixB, result: $result, onCalculate: isAdd ? add : subtract)) {
                            HStack {
                                Text("\(matrixA.count) X \(matrixA[0].count)")
                                Image(systemName: "square.and.pencil")
                                    .bold()
                            }
                            .foregroundStyle(.red.opacity(0.85))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Matrix B")
                            .bold()
                        Spacer()
                        
                        NavigationLink(destination: MultipleMatrixView(screenWidth: screenWidth, screenHeight: screenHeight, numRows: $numRows, numCols: $numCols, matrixA: $matrixB, matrixB: $matrixA, result: $result, onCalculate: isAdd ? add : subtract)) {
                            HStack {
                                Text("\(matrixB.count) X \(matrixB[0].count)")
                                Image(systemName: "square.and.pencil")
                                    .bold()
                            }
                            .foregroundStyle(.blue.opacity(0.85))
                        }
                        .buttonStyle(PlainButtonStyle())
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
    
    
    
    func add(matrix1: inout [[Double]], matrix2: inout [[Double]], matrix3: inout [[Double]]) {
                
        for i in 0..<matrix1.count {
            for j in 0..<matrix1[0].count {
                matrix3[i][j] = matrix1[i][j] + matrix2[i][j]
            }
        }
    }
    
    func subtract(matrix1: inout [[Double]], matrix2: inout [[Double]], matrix3: inout [[Double]]) {
                
        for i in 0..<matrix1.count {
            for j in 0..<matrix1[0].count {
                matrix3[i][j] = matrix1[i][j] - matrix2[i][j]
            }
        }
    }
}

#Preview {
    AddSubtractView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, isAdd: true)
}
