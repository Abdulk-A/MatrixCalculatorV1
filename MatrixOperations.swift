//
//  MatrixOperations.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/22/24.
//

import Foundation
import SwiftUI
//
//struct Matrix {
//
//    var numRow: Int
//    var numCol: Int
//    
//    var matrix: [[Double]]
//    
//    init(row: Int, col: Int) {
//        self.numRow = row
//        self.numCol = col
//        
//        self.matrix = Array(repeating: Array(repeating: 0, count: col), count: row)
//    }
//    
//    init(row: Int) {
//        self.numRow = row
//        self.numCol = row
//        
//        self.matrix = Array(repeating: Array(repeating: 0, count: row), count: row)
//    }
//    
//    init(myMatrix: [[Double]]) {
//        self.matrix = myMatrix
//        self.numRow = myMatrix.count
//        self.numCol = myMatrix[0].count
//    }
//}
//
//
//extension Matrix {
//    subscript(row: Int, col: Int) -> Double {
//        get {
//            precondition(row < numRow && col < numCol, "row or column not within dimensions")
//            return matrix[row][col]
//        }
//        set(newValue) {
//            precondition(row < numRow && col < numCol, "row or column not within dimensions")
//            matrix[row][col] = newValue
//        }
//    }
//    
//    func binding(row: Int, col: Int, value: Binding<Matrix>) -> Binding<Double> {
//        Binding<Double>(
//            get: {
//                value.wrappedValue[row, col]
//            },
//            set: { newValue in
//                var updatedMatrix = value.wrappedValue
//                updatedMatrix[row, col] = newValue
//                value.wrappedValue = updatedMatrix
//            }
//        )
//    }
//    
//    subscript(row: Int) -> [Double] {
//        get {
//            precondition(row < numRow, "row not within dimensions")
//            return matrix[row]
//        }
//        set(newValue) {
//            precondition(row < numRow , "row not within dimensions")
//            matrix[row] = newValue
//        }
//    }
//}
//
//extension Matrix {
//    static func +(A: Matrix, B: Matrix) -> Matrix {
//        precondition(A.numRow == B.numRow && A.numCol == B.numCol, "Dimensions of matrices are not the same!")
//        
//        var result = Matrix(row: A.numRow, col: B.numCol)
//        
//        for i in 0..<A.numRow {
//            for j in 0..<A.numCol {
//                result[i, j] = A[i, j] + B[i,j]
//            }
//        }
//        
//        return result
//    }
//    
//    static func -(A: Matrix, B: Matrix) -> Matrix {
//        precondition(A.numRow == B.numRow && A.numCol == B.numCol, "Dimensions of matrices are not the same!")
//        
//        var result = Matrix(row: A.numRow, col: B.numCol)
//        
//        for i in 0..<A.numRow {
//            for j in 0..<A.numCol {
//                result[i, j] = A[i, j] - B[i,j]
//            }
//        }
//        
//        return result
//    }
//    
//    static func *(A: Matrix, B: Matrix) -> Matrix {
//        precondition(A.numCol == B.numRow, "The column length of matrix A is not equal to the row length of matrix B!")
//        
//        var result = Matrix(row: A.numRow, col: B.numCol)
//        
//        for i in 0..<A.numRow {
//            for j in 0..<B.numCol {
//                for k in 0..<A.numCol {
//                    result[i, j] += (A[i, k] * B[k, j])
//                }
//            }
//        }
//        
//        return result
//    }
//    
//    static func +=(lhs: inout Matrix, rhs: Matrix) {
//        lhs = lhs + rhs
//    }
//    
//    static func -=(lhs: inout Matrix, rhs: Matrix) {
//        lhs = lhs - rhs
//    }
//    
//    static func *=(lhs: inout Matrix, rhs: Matrix) {
//        lhs = lhs * rhs
//    }
//}
//
//extension Matrix {
//    func transpose() -> Matrix {
//        
//        var result = Matrix(row: self.numCol, col: self.numRow)
//        
//        for i in 0..<self.numRow {
//            for j in 0..<self.numCol {
//                result[i,j] = self[j,i]
//            }
//        }
//        
//        return result
//    }
//    
//    func matrixHasZero() -> Bool {
//        
//        for i in 0..<numRow {
//            for j in 0..<numCol {
//                if self[i,j] == 0 {
//                    return true
//                }
//            }
//        }
//        
//        return false
//    }
//    
//    static func matrix_pow(A: Matrix, pow: Int) -> Matrix {
//        
//        precondition(A.numRow == A.numCol,"number of rows and and columns must be equal to each other")
//        
//        //more conditions
//        //in general, we want to use this for powers equal to or greater than 2
//        
//        var result = A
//        
//        for _ in 1..<pow {
//            result *= A
//        }
//        
//        return result
//    }
//    
//    //reference: https://cp-algorithms.com/linear_algebra/rank-matrix.html
//    func rank() -> Int {
//        let EPS: Double = 1e-9
//        let rows = self.numRow, cols = self.numCol
//        
//        var result: Int = 0
//        
//        var markedRows = [Bool](repeating: false, count: rows)
//        var temp = self
//        
//        for i in 0..<cols {
//            var j = 0
//            while j < rows {
//                
//                if !markedRows[j] && abs(temp[j,i]) > EPS {
//                    break
//                }
//                j += 1
//            }
//            
//            if j != rows {
//                result += 1
//                markedRows[j] = true
//                
//                for k in i + 1..<cols {
//                    temp[j,k] /= temp[j,i]
//                }
//                
//                for k in 0..<rows {
//                    if k != j && abs(temp[k,i]) > EPS {
//                        for l in i+1..<cols {
//                            temp[k,l] -= temp[j,l] * temp[k,i]
//                        }
//                    }
//                }
//            }
//        }
//        
//        
//        return result
//    }
//
//    
//    //reference: https://www.geeksforgeeks.org/determinant-of-a-matrix/
//    func determinent() -> Double {
//        
//        
//        var U_matrix = self
//        
//        let n = self.numRow
//        
//        var num1: Double, num2: Double, det: Double = 1, total: Double = 1
//        
//        
//        var temp = [Double](repeating: 0, count: n + 1)
//        
//        for i in 0..<n {
//            
//            var j = i
//            
//            while j < n && U_matrix[j, i] == 0 {
//                j += 1
//            }
//            
//            if (j == n) {
//                continue
//            }
//            
//            if (j != i) {
//                
//                for k in 0..<n {
//                    let temp_num = U_matrix[j,k]
//                    U_matrix[j,k] = U_matrix[i,k]
//                    U_matrix[i,k] = temp_num
//                }
//                
//                det *= pow(-1, Double(j) - Double(i))
//            }
//            
//            for k in 0..<n {
//                temp[k] = U_matrix[i,k]
//            }
//            
//            for k in (i + 1)..<n {
//                num1 = temp[i]
//                num2 = U_matrix[k,i]
//                
//                for l in 0..<n {
//                    
//                    U_matrix[k,l] = (num1 * U_matrix[k,l]) - (num2 * temp[l])
//                }
//                total *= num1
//            }
//        }
//        
//        for i in 0..<n {
//            det *= U_matrix[i,i]
//        }
//        
//        return det / total
//    }
//    
//    static func cofactor(_ matrix: Matrix, _ cofactors: inout Matrix,_ ri: Int,_ cj: Int,_ n: Int) {
//        
//        var i: Int = 0, j: Int = 0
//        
//        for k in 0..<n {
//            for l in 0..<n {
//                if k != ri && l != cj {
//                    cofactors[i,j] = matrix[k,l]
//                    j += 1
//                    if j == n - 1 {
//                        j = 0
//                        i += 1
//                    }
//                }
//            }
//        }
//    }
//    
//    static func determinent(_ matrix: Matrix,_ n: Int) -> Double {
//        
//        if n == 1 {
//            return matrix[0,0]
//        }
//        
//        var det: Double = 0, sign: Int = 1
//        var cofactors = Matrix(row: matrix.numRow)
//        
//        
//        for i in 0..<n {
//            cofactor(matrix, &cofactors, 0, i, n)
//            det += Double(sign) * matrix[0,i] * determinent(cofactors, n - 1)
//            sign = -sign
//        }
//        
//        
//        return det
//    }
//
//    static func adjoint(_ A: Matrix, _ B: inout Matrix,_ n: Int) {
//        
//        let n = A.numRow
//        if n == 1 {
//            B[0,0] = 1
//            return
//        }
//        
//        var cofactor_matrix = Matrix(row: n)
//        var sign: Double = 1
//        
//        
//        for i in 0..<n {
//            for j in 0..<n {
//                cofactor(A, &cofactor_matrix, i, j, n)
//                sign = (i + j) % 2 == 0 ? 1 : -1
//                B[j,i] = sign * determinent(cofactor_matrix, n - 1)
//            }
//        }
//        
//    }
//
//    static func inverse(_ matrix: Matrix) -> Matrix? {
//        
//        let n = matrix.numRow
//        let det = determinent(matrix, n)
//        
//        if det == 0 {
//            return nil
//        }
//        
//        var adjoint_matrix = Matrix(row: n)
//        var inv = Matrix(row: n)
//        
//        adjoint(matrix, &adjoint_matrix, n)
//        
//        for i in 0..<n {
//            for j in 0..<n {
//                inv[i,j] = adjoint_matrix[i,j] / det
//            }
//        }
//        
//        return inv
//    }
//}

struct Matrix {
    var values: [[Double]]
    
    var rows: Int { values.count }
    var cols: Int { values[0].count }

    init(_ values: [[Double]]) {
        self.values = values
    }

//    mutating func transpose() {
//        
//        
//        values = (0..<cols).map { col in
//            (0..<rows).map { row in values[row][col] }
//        }
//    }
    
        mutating func transpose() {
            var tempMat = Array(repeating: Array(repeating: 0.0, count: rows), count: cols)
    
            for i in 0..<rows {
                for j in 0..<cols {
                    tempMat[j][i] = values[i][j]
                }
            }

            values = tempMat
        }
    
    subscript(row: Int, col: Int) -> Double {
        get {
            precondition(row < rows && col < cols, "row or column not within dimensions")
            return values[row][col]
        }
        set(newValue) {
            precondition(row < rows && col < cols, "row or column not within dimensions")
            values[row][col] = newValue
        }
    }
    
    subscript(row: Int) -> [Double] {
        get {
            precondition(row < rows, "row not within dimensions")
            return values[row]
        }
        set(newValue) {
            precondition(row < rows , "row not within dimensions")
            values[row] = newValue
        }
    }
    
    mutating func addRow(nRows: Int) {
        if nRows > values.count {
            for _ in values.count..<nRows {
                values.append(Array(repeating: 0, count: values[0].count))
            }
        } else if nRows < values.count {
            values.removeLast(values.count - nRows)
        }
    }

    mutating func addColumn(nCols: Int) {
        for i in 0..<values.count {
            if nCols > values[i].count {
                values[i].append(contentsOf: Array(repeating: 0, count: nCols - values[i].count))
            } else if nCols < values[i].count {
                values[i].removeLast(values[i].count - nCols)
            }
        }
    }
}

//    func addColumn() {
//        for i in 0..<matrix.count {
//            if cols > matrix[i].count {
//                matrix[i].append(contentsOf: Array(repeating: 0, count: cols - matrix[i].count))
//            } else if cols < matrix[i].count {
//                matrix[i].removeLast(matrix[i].count - cols)
//
//                if tempCol >= matrix[0].count {
//                    withAnimation {
//                        tempCol = matrix[0].count - 1
//                    }
//                }
//
//            }
//        }
//    }
