//
//  FeatureMenuView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 3/12/25.
//

import SwiftUI

struct FeaturesMenuView2: View {
    
    let sW: Double
    let sH: Double
    @Binding var matrix: Matrix
    
    let myOperation: MatrixOperation
    
    @Binding var numRows: Double
    @Binding var numCols: Double
    
    @State private var userDefaults = UserDefaults.standard
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {

                Button("Copy") {
                    let arr = Matrix.matrixToArray(matrix)
                    userDefaults.set(arr, forKey: "matrix")
                }
                .SomeModifer(for: 130)
                
                Button("Paste") {
                    let myArr = userDefaults.array(forKey: "matrix") as? [Double]
                    
                    if let myArr {
                        
                        let rows = myArr[myArr.count - 2]
                        let cols = myArr[myArr.count - 1]
                        
                        if (((myOperation == .determinant || myOperation == .inverse || myOperation == .power) && rows == cols) || (myOperation == .transpose || myOperation == .rank)) {
                            matrix = Matrix.arrayToMatrix(myArr)
                            numRows = Double(rows)
                            numCols = Double(cols)
                        }
                    }
                }
                .SomeModifer(for: 130)
                
                if myOperation != .transpose {
                    Button("Transpose") {
                        matrix.transpose()

                        let temp = numRows
                        numRows = numCols
                        numCols = temp
                    }
                    .SomeModifer(for: 130)
                }

                Button("Zero") {
                    Matrix.FillZeros(for: &matrix)
                }
                .SomeModifer(for: 130)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FeaturesMenuView2(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, matrix: .constant(Matrix([[0]])), myOperation: .transpose, numRows: .constant(0.0), numCols: .constant(0.0))
}
