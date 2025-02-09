//
//  TransposeView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/8/25.
//

import SwiftUI

struct TransposeView: View {
    
    
    @State private var matrix: [[Double]] = [[0]]
    let sW: Double
    let sH: Double
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SingleMatrixView3(sW: sW, sH: sH, matrix: $matrix, numRows: $numRows, numCols: $numCols)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button("Transpose") {
                        transposeMatrix()
                    }
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.65))
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
    }
    
    func transposeMatrix() {
        let rows = Int(numRows)
        let cols = Int(numCols)
        
        
        var tempMat = Array(repeating: Array(repeating: 0.0, count: rows), count: cols)
        
        for i in 0..<rows {
            for j in 0..<cols {
                tempMat[j][i] = matrix[i][j]
            }
        }
        
        withAnimation {
            var temp = numRows
            numRows = numCols
            numCols = temp
            matrix = tempMat
        }
    }
}

#Preview {
    TransposeView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height)
}
