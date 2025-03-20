//
//  FeaturesMenuView1.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 3/11/25.
//

import SwiftUI

struct FeaturesMenuView1: View {
    
    let sW: Double
    let sH: Double
    @Binding var matrix1: Matrix
    @Binding var matrix2: Matrix
    @Binding var result: Matrix
    
    
    let myOperation: MatrixOperation
    
    @Binding var numRows: Double
    @Binding var numCols: Double
    
    @Binding var numRowsB: Double
    @Binding var numColsB: Double

    let isMatrixA: Bool
    
    @State private var userDefaults = UserDefaults.standard
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {

                Button("Copy") {
                    let arr = Matrix.matrixToArray(matrix1)
                    userDefaults.set(arr, forKey: "matrix")
                }
                .SomeModifer(for: 130)
                
                Button("Paste") {
                    let myArr = userDefaults.array(forKey: "matrix") as? [Double]
                    
                    if let myArr {
                        
                        let rows = myArr[myArr.count - 2]
                        let cols = myArr[myArr.count - 1]
                        
                        if (myOperation == .add || myOperation == .subtract) {
                            matrix1 = Matrix.arrayToMatrix(myArr)
                            numRows = rows
                            numCols = cols

                            matrix2.addRow(nRows: Int(rows))
                            matrix2.addColumn(nCols: Int(cols))

                            result.addRow(nRows: Int(rows))
                            result.addColumn(nCols: Int(cols))
                        } else if myOperation == .multiply && isMatrixA {
                            matrix1 = Matrix.arrayToMatrix(myArr)
                            numRows = rows
                            numCols = cols
                            
                            numRowsB = cols
                            
                            matrix2.addRow(nRows: Int(cols))
                            result.addRow(nRows: Int(rows))
                        } else if myOperation == .multiply && !isMatrixA {
                            matrix1 = Matrix.arrayToMatrix(myArr)
                            numRows = rows
                            numCols = cols
                            
                            numColsB = rows
                            
                            matrix2.addColumn(nCols: Int(rows))
                            result.addColumn(nCols: Int(cols))
                        }
                                                
                    }
                }
                .SomeModifer(for: 130)
                
                Button("Transpose") {
                    if myOperation == .add || myOperation == .subtract {
                        matrix1.transpose()
                        matrix2.transpose()
                        result.transpose()
                        
                        let temp = numRows
                        numRows = numCols
                        numRowsB = numCols
                        numCols = temp
                        numColsB = temp
                    }
                }
                .SomeModifer(for: 130)

                Button("Zero") {
                    Matrix.FillZeros(for: &matrix1)
                }
                .SomeModifer(for: 130)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FeaturesMenuView1(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, matrix1: .constant(Matrix([[0]])), matrix2: .constant(Matrix([[0]])), result: .constant(Matrix([[0]])), myOperation: .add, numRows: .constant(0.0), numCols: .constant(0.0), numRowsB: .constant(0.0), numColsB: .constant(0.0), isMatrixA: true)
}
