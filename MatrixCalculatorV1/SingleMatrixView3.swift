//
//  SingleMatrixView3.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/13/25.
//

import SwiftUI

struct SingleMatrixView3: View {
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return sW / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return sH / (denom * 3)
    }
    
    let sW: Double
    let sH: Double
    
    var topBottomSegment: Double {
        sH / 6.0
    }
    
    var midSegment: Double {
        sH - (topBottomSegment * 2)
    }
    
    @State private var tempRow = 0
    @State private var tempCol = 0
    

    @State private var isKeyboardShowing: Bool = false
    
    
    @State private var num = 0
    
    
    
    @Binding var matrix: [[Double]]
    @Binding var numRows: Double
    @Binding var numCols: Double
    
    let operationType: MatrixOperation
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack(spacing: 0) {
                
                Spacer()
                      
                VStack {

                    
                    VStack(spacing: 10){
                        ForEach(0..<matrix.count, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<matrix[row].count, id: \.self) { col in
                                    
                                    TextField("", value: $matrix[row][col], formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: boxWidth, height: boxHeight)
                                        .foregroundStyle(.white)
                                        .background(row == tempRow && col == tempCol ? .red.opacity(0.8) : Color("ButtonBackgroundStyle").opacity(0.70))
                                        .clipShape(.rect(cornerRadius: 5))
                                        .onTapGesture {
                                            withAnimation {
                                                tempRow = row
                                                tempCol = col
                                            }
                                        }
                                }
                                
                            }
                            
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                        withAnimation {
                            isKeyboardShowing = true
                        }
                    })
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                        withAnimation {
                            isKeyboardShowing = false
                        }
                    })
                }
                .frame(width: sW, height: midSegment)
                
                
                if !isKeyboardShowing {
                    VStack {
                        HStack {
                            Text("R")
                            Slider(value: $numRows, in: 1...10, step: 1)
                                .onChange(of: numRows) {
                                    resizeMatrix()
                                }
                            Text("\(Int(numRows))")
                        }
                        HStack {
                            Text("C")
                            Slider(value: $numCols, in: 1...10, step: 1)
                                .onChange(of: numCols) {
                                    resizeMatrix()
                                }
                            Text("\(Int(numCols))")
                        }
                    }
                    .padding()
                    .frame(width: sW, height: topBottomSegment)
                } else {
                    Spacer()
                }
                
            }
            .frame(width: sW, height: sH)
            
        }
        .ignoresSafeArea()
        .gesture(TapGesture().onEnded{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
    
    var rows: Int {
        Int(numRows)
    }
    
    var cols: Int {
        Int(numCols)
    }
    
    func resizeMatrix() {
        if operationType == .transpose || operationType == .rank {
            addRow()
            addColumn()
        } else if operationType == .determinant || operationType == .inverse || operationType == .power {
            numCols = numRows
            addRow()
            addColumn()
        }
    }
    
    func addRow() {
        if rows > matrix.count {
            for _ in matrix.count..<rows {
                matrix.append(Array(repeating: 0, count: cols))
            }
        } else if rows < matrix.count {

            matrix.removeLast(matrix.count - rows)

            
            if tempRow >= matrix.count {
                withAnimation {
                    tempRow = matrix.count - 1
                }
            }
        }
    }
    
    func addColumn() {
        for i in 0..<matrix.count {
            if cols > matrix[i].count {
                matrix[i].append(contentsOf: Array(repeating: 0, count: cols - matrix[i].count))
            } else if cols < matrix[i].count {
                matrix[i].removeLast(matrix[i].count - cols)
                
                if tempCol >= matrix[0].count {
                    withAnimation {
                        tempCol = matrix[0].count - 1
                    }
                }
                
            }
        }
    }
}

#Preview {
    SingleMatrixView3(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, matrix: .constant([[0.0]]), numRows: .constant(1), numCols: .constant(1), operationType: .transpose)
}
