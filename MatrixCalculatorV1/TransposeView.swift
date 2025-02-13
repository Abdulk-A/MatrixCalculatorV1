//
//  TransposeView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/8/25.
//

import Accelerate
import SwiftUI

struct TransposeView: View {
    
    
    @State private var matrix: [[Double]] = [[0]]
    let sW: Double
    let sH: Double
    let operationType: MatrixOperation
    @State private var power = 2
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    @State private var deter: Double = 0.0 //determinant
    
    @State private var isShowPopup = false
    @State private var isShowPopupInverse = false
    
    @State private var invArr: [Double]? = nil
    
    @Environment(\.dismiss) var dismiss
    
    var rows: Int {
        Int(numRows)
    }
    var cols: Int {
        Int(numCols)
    }
    
    var topButtonTitle: String {
        if operationType == .power {
            return "Power \(power)"
        }
        return operationType.rawValue
    }
    
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
                        Button(topButtonTitle) {
                            if operationType == .transpose  {
                                transposeMatrix()
                            } else if operationType == .determinant {
                                withAnimation {
                                    isShowPopup.toggle()
                                }
                            } else if operationType == .inverse {
                                Task {
                                    await invArr = invert()
                                }
                            } else if operationType == .power {
                                let originalMatrix = matrix
                                
                                withAnimation {
                                    for _ in 0..<(power-1) {
                                        multiply(matrix2: originalMatrix)
                                    }
                                }
                                
                            }
                        }
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.65))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    
                    if operationType == .power {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Stepper("", value: $power, in: 1...100)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowPopupInverse, content: {
                    
                    
                    
                    if let invArr {
                        
                        let invMat = arrToMatrix(arr: invArr)
                        
                        ResultView(result: invMat, screenWidth: sW, screenHeight: sH / 1.3, operationType: .inverse)
                    } else {
                        VStack {
                            Text("Inverse cannot be found for this matrix")
                                .padding()
                                .font(.title2)
                            Button("OK") {
                                withAnimation {
                                    isShowPopupInverse.toggle()
                                }
                            }
                            .padding()
                            .foregroundStyle(.white)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 10))
                            .font(.title3)
                        }
                    }
                })
            if isShowPopup {
                DeterminantResult(res: determinent(), showPopUp: $isShowPopup, sW: sW / 1.5, sH: sH / 3.5)
                    .clipShape(.rect(cornerRadius: 15))
            }
        }
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
    
    //placeholder inverse from chatgpt, since it takes a lot of code
    //and want to see how it will look
    //will replace with accelerator
    func inverse() -> [[Double]]? {


        var augmentedMatrix = matrix
        let identity = (0..<rows).map { i in
            (0..<rows).map { j in i == j ? 1.0 : 0.0 }
        }

        
        for i in 0..<rows {
            augmentedMatrix[i].append(contentsOf: identity[i])
        }

        for i in 0..<rows {
            
            var maxRow = i
            for j in i+1..<rows {
                if abs(augmentedMatrix[j][i]) > abs(augmentedMatrix[maxRow][i]) {
                    maxRow = j
                }
            }
            
            if i != maxRow {
                augmentedMatrix.swapAt(i, maxRow)
            }

            let pivot = augmentedMatrix[i][i]
            if abs(pivot) < 1e-10 { return nil }

            
            for j in 0..<2*rows {
                augmentedMatrix[i][j] /= pivot
            }

            
            for j in 0..<rows {
                if i != j {
                    let factor = augmentedMatrix[j][i]
                    for k in 0..<2*rows {
                        augmentedMatrix[j][k] -= factor * augmentedMatrix[i][k]
                    }
                }
            }
        }

        let inverseMatrix = (0..<rows).map { i in
            Array(augmentedMatrix[i][rows..<2*rows])
        }

        return inverseMatrix
    }
    
    func multiply(matrix2: [[Double]]) {
        
        
        var matrix3 = Array(repeating: Array(repeating: 0.0, count: cols), count: rows)
        
        for i in 0..<rows {
            for j in 0..<cols {
                matrix3[i][j] = 0
                for k in 0..<cols {
                    matrix3[i][j] += (matrix[i][k] * matrix2[k][j])
                }
            }
        }
        
        matrix = matrix3
    }

    func invert() async -> [Double]? {
        
        var flatMatrix = matrix.flatMap { $0 }
    
        
        
        var inversionSucceeded = true
        
        flatMatrix.withUnsafeMutableBufferPointer { ptr in
            var ipiv = [__CLPK_integer](repeating: 0, count: rows * rows)
            var lwork = __CLPK_integer(rows * rows)
            var work = [CDouble](repeating: 0, count: Int(lwork))
            var error: __CLPK_integer = 0
            var nc = __CLPK_integer(cols)
            var m = nc
            var n = nc
            dgetrf_(&m, &n, ptr.baseAddress, &nc, &ipiv, &error)
            dgetri_(&m, ptr.baseAddress, &nc, &ipiv, &work, &lwork, &error)
            
            if error != 0 {
                inversionSucceeded = false
            }
        }

        
        isShowPopupInverse.toggle()
        return inversionSucceeded ? flatMatrix : nil
    }
    
    //we have rows and cols already
    //from state
    func arrToMatrix(arr: [Double]) -> [[Double]] {
        var result = Array(repeating: Array(repeating: 0.0, count: cols), count: rows)
        
        for i in 0..<rows {
            for j in 0..<cols {
                result[i][j] = arr[i * cols + j]
            }
        }
        
        return result
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
                Text("Determinant =")
                Text("\(res.formatted())")
                    .bold()
            }
            .font(.title2)
            Button {
                withAnimation {
                    showPopUp.toggle()
                }
            } label: {
                Text("OK")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .font(.title3)
            }
        }
        .frame(width: sW, height: sH)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 4)
        )
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    TransposeView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, operationType: .transpose)
}
