//
//  ArrayPractice.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/26/25.
//

import SwiftUI

struct ArrayPractice: View {
    
    @State private var matrix: [[Double]] = Array(repeating: Array(repeating: 0, count: 1), count: 1)
    
    let matrixB: [[Double]] = Array(repeating: Array(repeating: 100, count: 3), count: 3)
    
    let matrix_operations = MatrixOperations()
    
    @State private var tempCol = 0
    @State private var tempRow = 0
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 10) {
                ForEach(0..<matrix.count, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<matrix[row].count, id: \.self) { col in
                            Text("\(matrix[row][col].formatted())")
                                .padding()
                                .background(row == tempRow && col == tempCol ? .red : .black)
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    withAnimation {
                                        tempRow = row
                                        tempCol = col
                                    }
                                }
                        }
                    }
                }
                
                HStack {
                    Text("Rows \(numRows.formatted())")
                    Slider(value: $numRows, in: 1...10, step: 1)
                        .onChange(of: numRows) {
                            if Int(numRows) > matrix.count {
                                matrix.append(Array(repeating: 0, count: Int(numCols)))
                            } else {
                                matrix.removeLast()
                            }
                        }
                    
                }
                .padding()
                
                HStack {
                    Text("Cols \(numCols.formatted())")
                    Slider(value: $numCols, in: 1...10, step: 1)
                        .onChange(of: numCols) {
                            
                            let rows = Int(numRows)
                            
                            if Int(numCols) > matrix[0].count {
                                for i in 0..<rows {
                                    matrix[i].append(0)
                                }
                            } else {
                                for i in 0..<rows {
                                    matrix[i].removeLast()
                                }
                            }
                        }
                }
                .padding()
            }
            
            Spacer()
            
            Button {
                do {
                    matrix = try MatrixOperations.add(A: matrix, B: matrixB)
                    
                } catch MatrixError.unequalDimensionsColumns {
                    print("make sure matrices have the same number of columns")
                } catch MatrixError.unequalDimensionsRows {
                    print("make sure matrices have the same number of rows")
                } catch {
                    print("An unexpected error occurred: \(error)")
                }
                
            } label: {
                Text("Add")
                    .padding()
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.bottom)
            }
            
        }
    }
    
    func addMatrix() {
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                matrix[i][j] += 5
            }
        }
    }
}

enum MatrixError: Error {
    case unequalDimensionsRows
    case unequalDimensionsColumns
}

class MatrixOperations {
    static func add(A: [[Double]], B: [[Double]]) throws -> [[Double]] {
        
        guard A.count == B.count else {
            throw MatrixError.unequalDimensionsRows
        }
        guard A[0].count == B[0].count else {
            throw MatrixError.unequalDimensionsColumns
        }
        
        var res = A
        
        for i in 0..<A.count {
            for j in 0..<A[0].count {
                res[i][j] += B[i][j]
            }
        }
        
        return res
    }
}



#Preview {
    ArrayPractice()
}
