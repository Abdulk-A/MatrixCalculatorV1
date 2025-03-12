//
//  AddView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/29/25.
//

import SwiftUI

struct AddSubtractView: View {
    
    //values coming from another view//
    
    let sW: Double
    let sH: Double
    let operationType: MatrixOperation
    
    //*******************************//
    
    @State private var matrixA = Matrix([[0]])
    @State private var matrixB = Matrix([[0]])
    
    @State private var result = Matrix([[0]])
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
    @State private var numRowsB: Double = 1
    @State private var numColsB: Double = 1
    
    @Environment(\.dismiss) var dismiss
    @State private var showList = false
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack {
                
                Spacer()
                    .frame(height: showList ? sH / 6 : sH / 10)
                
                if !showList {
                    ResultView(result: result, screenWidth: sW, screenHeight: sH, operationType: operationType)
                } else {
                    ListResultView(matrix: matrixA, sH: sH)
                    Spacer()
                }
                
                
                VStack {                    
                    HStack {
                        Text("Matrix A")
                            .bold()
                        Spacer()
 
                        NavigationLink(destination: MultipleMatrixView(screenWidth: sW, screenHeight: sH, numRows: $numRows, numCols: $numCols, numRowsB: $numRowsB, numColsB: $numColsB, matrix1: $matrixA, matrix2: $matrixB, result: $result, isMatrixA: true, tempColor: .red.opacity(0.8), operationType: operationType, onCalculate: operationFunction)){
                            HStack {
                                Text("\(matrixA.rows) X \(matrixA.cols)")
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
                                Text("\(matrixB.rows) X \(matrixB.cols)")
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
                .background(Color("ButtonBackgroundStyle").opacity(0.65))
                .clipShape(.rect(cornerRadius: 15))
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                        Text("Menu")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(showList ? "Matrix" : "List") {
                    withAnimation {
                        showList.toggle()
                    }
                }
                .frame(width: 75)
                .padding([.trailing, .vertical], 8)
                .background(Color("ButtonBackgroundStyle"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
            }

        }
    }
    
    var topBottomSegment: Double {
        sH / 6.0
    }
    
    var operationFunction: ((inout Matrix, inout Matrix, inout Matrix) -> Void) {
        switch operationType {
        case .add:
            return Matrix.add
        case .subtract:
            return Matrix.subtract
        default:
            return Matrix.multiply
        }
    }
    
}

#Preview {
    AddSubtractView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, operationType: .add)
}
