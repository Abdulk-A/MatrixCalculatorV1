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
    let operationType: MatrixOperation
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    @State private var deter: Double = 0.0 //determinant
    
    @State private var isShowPopup = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            SingleMatrixView3(sW: sW, sH: sH, matrix: $matrix, numRows: $numRows, numCols: $numCols, operationType: operationType)
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
                        Button(operationType.rawValue) {
                            if operationType == .transpose  {
                                transposeMatrix()
                            } else if operationType == .determinant {
                                withAnimation {
                                    isShowPopup.toggle()
                                }
                            }
                        }
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.65))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                }
            if isShowPopup {
                DeterminantResult(res: determinent(), showPopUp: $isShowPopup, sW: sW / 1.5, sH: sH / 3.5)
//                    .frame(width: sW / 1.1, height: sH / 2)
                    .clipShape(.rect(cornerRadius: 15))
            }
        }
    }
    
    var rows: Int {
        Int(numRows)
    }
    var cols: Int {
        Int(numCols)
    }
    
    func transposeMatrix() {
        var tempMat = Array(repeating: Array(repeating: 0.0, count: rows), count: cols)
        
        for i in 0..<rows {
            for j in 0..<cols {
                tempMat[j][i] = matrix[i][j]
            }
        }
        
        withAnimation {
            let temp = numRows
            numRows = numCols
            numCols = temp
            matrix = tempMat
        }
    }
    
    
    //reference: https://www.geeksforgeeks.org/determinant-of-a-matrix/
    func determinent() -> Double {
        
        
        var Umatrix = matrix
        
        let n = rows
        
        var num1: Double, num2: Double, det: Double = 1, total: Double = 1
        
        
        var temp = [Double](repeating: 0, count: n + 1)
        
        for i in 0..<n {
            
            var j = i
            
            while j < n && Umatrix[j][i] == 0 {
                j += 1
            }
            
            if (j == n) {
                continue
            }
            
            if (j != i) {
                
                for k in 0..<n {
                    let tempNum = Umatrix[j][k]
                    Umatrix[j][k] = Umatrix[i][k]
                    Umatrix[i][k] = tempNum
                }
                
                det *= pow(-1, Double(j) - Double(i))
            }
            
            for k in 0..<n {
                temp[k] = Umatrix[i][k]
            }
            
            for k in (i + 1)..<n {
                num1 = temp[i]
                num2 = Umatrix[k][i]
                
                for l in 0..<n {
                    
                    Umatrix[k][l] = (num1 * Umatrix[k][l]) - (num2 * temp[l])
                }
                total *= num1
            }
        }
        
        for i in 0..<n {
            det *= Umatrix[i][i]
        }
        
        return abs(det / total) < 1e-10 ? 0 : det / total
    }
}

struct DeterminantResult: View {
    
    
    let res: Double
    @Binding var showPopUp: Bool
    let sW: Double
    let sH: Double
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Determinant = ")
                    .foregroundStyle(.white)
                Text("\(res.formatted())")
                    .foregroundStyle(.red)
            }
            .font(.title2)
            Button {
                withAnimation {
                    showPopUp.toggle()
                }
            } label: {
                Text("OK")
                    .padding()
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .font(.title3)
            }
        }
        .frame(width: sW, height: sH)
        .padding()
        .background(.black)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    TransposeView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, operationType: .transpose)
}
