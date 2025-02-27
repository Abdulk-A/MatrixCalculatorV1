//
//  MatrixOperations.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/22/24.
//

import Accelerate
import Foundation
import SwiftUI

struct Matrix: Equatable {
    var values: [[Double]]
    
    var rows: Int { values.count }
    var cols: Int { values[0].count }

    init(_ values: [[Double]]) {
        self.values = values
    }
    
    mutating func randomValues(in range: Range<Double>) {
        for i in 0..<rows {
            for j in 0..<cols {
                values[i][j] = Double.random(in: range)
            }
        }
    }

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
    
    //    //reference: https://www.geeksforgeeks.org/determinant-of-a-matrix/
    func determinent() -> Double {


        var Umatrix = values

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
    
    func invert() async -> [Double]? {
        
        var flatMatrix = values.flatMap { $0 }
        
        
        
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
        
        
        return inversionSucceeded ? flatMatrix : nil
    }
    
    
        //rosetta code -credit
        func rowEchelonForm() -> [[Double]] {
    
            var m = values
    
            var lead = 0
            for r in 0..<rows {
                if (cols <= lead) { break }
                var i = r
                while (m[i][lead] == 0) {
                    i += 1
                    if (i == rows) {
                        i = r
                        lead += 1
                        if (cols == lead) {
                            lead -= 1
                            break
                        }
                    }
                }
                for j in 0..<cols {
                    let temp = m[r][j]
                    m[r][j] = m[i][j]
                    m[i][j] = temp
                }
                let div = m[r][lead]
                if (div != 0) {
                    for j in 0..<cols {
                        m[r][j] /= div
                    }
                }
                for j in 0..<rows {
                    if (j != r) {
                        let sub = m[j][lead]
                        for k in 0..<cols {
                            m[j][k] -= (sub * m[r][k])
                        }
                    }
                }
                lead += 1
            }
    
            return m
        }
    
    
    static func countNonZeroRows(_ rowReducedMatrix: [[Double]], nRows: Int, nCols: Int) -> Int {

        var res = 0;

        for i in 0..<nRows {
            for j in 0..<nCols {
                if rowReducedMatrix[i][j] != 0 {
                    res += 1
                    break
                }
            }
        }

        return res
    }
    
    mutating func power(n: Int) {
        
        let val2 = values

        for _ in 0..<n-1 {
            multiply(matrix2: val2)
        }
    }
    
    mutating func multiply(matrix2: [[Double]]) {


        var matrix3 = Array(repeating: Array(repeating: 0.0, count: cols), count: rows)

        for i in 0..<rows {
            for j in 0..<cols {
                matrix3[i][j] = 0
                for k in 0..<cols {
                    matrix3[i][j] += (values[i][k] * matrix2[k][j])
                }
            }
        }

        values = matrix3
    }
    
    static func add(matrix1: inout Matrix, matrix2: inout Matrix, matrix3: inout Matrix) {
                
        for i in 0..<matrix1.rows {
            for j in 0..<matrix1.cols {
                matrix3[i][j] = matrix1[i][j] + matrix2[i][j]
            }
        }
    }
    
    static func subtract(matrix1: inout Matrix, matrix2: inout Matrix, matrix3: inout Matrix) {
                
        for i in 0..<matrix1.rows {
            for j in 0..<matrix1.cols {
                matrix3[i][j] = matrix1[i][j] - matrix2[i][j]
            }
        }
    }
    
    static func multiply(matrix1: inout Matrix, matrix2: inout Matrix, matrix3: inout Matrix) {
        
        for i in 0..<matrix1.rows {
            for j in 0..<matrix2.cols {
                matrix3[i][j] = 0
                for k in 0..<matrix1.cols {
                    matrix3[i][j] += (matrix1[i][k] * matrix2[k][j])
                }
            }
        }
    }
}
