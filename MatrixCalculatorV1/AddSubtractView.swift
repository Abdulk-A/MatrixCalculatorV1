//
//  AddView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/29/25.
//

import SwiftUI

struct AddSubtractView: View {
    
    
    
    let sW: Double
    let sH: Double
    let operationType: MatrixOperation
    
    
    @State private var matrixA: [[Double]] = [[0]]
    @State private var matrixB: [[Double]] = [[0]]
    
    @State private var result: [[Double]] = [[0]]
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
    @State private var numRowsB: Double = 1
    @State private var numColsB: Double = 1
    
    
    
    
    var topBottomSegment: Double {
        sH / 6.0
    }
    
    var operationFunction: ((inout [[Double]], inout [[Double]], inout [[Double]]) -> Void) {
        switch operationType {
        case .add:
            return add
        case .subtract:
            return subtract
        default:
            return multiply
        }
    }

    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: sW, height: sH)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack {
                
                Spacer()
                
                ResultView(result: $result, screenWidth: sW, screenHeight: sH)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Matrix A")
                            .bold()
                        Spacer()
                        

                        
                        NavigationLink(destination: MultipleMatrixView(screenWidth: sW, screenHeight: sH, numRows: $numRows, numCols: $numCols, numRowsB: $numRowsB, numColsB: $numColsB, matrix1: $matrixA, matrix2: $matrixB, result: $result, isMatrixA: true, tempColor: .red.opacity(0.8), operationType: operationType, onCalculate: operationFunction)){
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
                        
                        NavigationLink(destination: MultipleMatrixView(screenWidth: sW, screenHeight: sH, numRows: $numRowsB, numCols: $numColsB, numRowsB: $numRows, numColsB: $numCols, matrix1: $matrixB, matrix2: $matrixA, result: $result, isMatrixA: false, tempColor: .blue.opacity(0.85), operationType: operationType, onCalculate: operationFunction)) {
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
                
                .frame(width: sW, height: topBottomSegment)
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
    
    func multiply(matrix1: inout [[Double]], matrix2: inout [[Double]], matrix3: inout [[Double]]) {
        
        for i in 0..<matrix1.count {
            for j in 0..<matrix2[0].count {
                matrix3[i][j] = 0
                for k in 0..<matrix1[0].count {
                    matrix3[i][j] += (matrix1[i][k] * matrix2[k][j])
                }
            }
        }
    }
    

}

#Preview {
    AddSubtractView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, operationType: .add)
}
