//
//  MultipleMatrixView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/28/25.
//

import SwiftUI

struct MultipleMatrixView: View {
    
    let screenWidth: Double
    let screenHeight: Double
    
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return screenHeight / (denom * 3)
    }
    
    var topBottomSegment: Double {
        screenHeight / 6.0
    }
    
    var midSegment: Double {
        screenHeight - (topBottomSegment * 2)
    }

    @Binding var numRows: Double
    @Binding var numCols: Double
    
    @Binding var numRowsB: Double
    @Binding var numColsB: Double
    
    

    
    @State private var tempRow = 0
    @State private var tempCol = 0
    

    @State private var isKeyboardShowing: Bool = false
    
    @Binding var matrix1: [[Double]]
    @Binding var matrix2: [[Double]]
    @Binding var result: [[Double]]
    
    let isMatrixA: Bool
    
    let operationType: MatrixOperation
    let onCalculate: (inout [[Double]], inout [[Double]], inout [[Double]]) -> Void
    
    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack(spacing: 0) {
                
                Spacer()
                
                VStack {
                    VStack(spacing: 10){
                        ForEach(0..<matrix1.count, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<matrix1[row].count, id: \.self) { col in
                                    TextField("", value: $matrix1[row][col], formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: boxWidth, height: boxHeight)
                                        .foregroundStyle(.white)
                                        .background(row == tempRow && col == tempCol ? .red.opacity(0.8) : .black.opacity(0.70))
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
                .frame(width: screenWidth, height: midSegment)
                
                
                if !isKeyboardShowing {
                    VStack {
                        HStack {
                            Text("R")
                            Slider(value: $numRows, in: 1...10, step: 1)
                                .onChange(of: numRows) {
                                    
                                    addRow(for: &matrix1, rows: numRowsInt, cols: numColsInt)
                                    
                                    if operationType == .add || operationType == .subtract {
                                        
                                        numRowsB = numRows
                                        
                                        
                                        addRow(for: &matrix2, rows: numRowsInt, cols: numColsInt)
                                        addRow(for: &result, rows: numRowsInt, cols: numColsInt)
                                    }
                                    else if operationType == .multiply && isMatrixA {
                                        addRow(for: &matrix1, rows: numRowsInt, cols: numColsInt)
                                        addRow(for: &result, rows: numRowsInt, cols: numColsBInt)
                                    }
                                    else if operationType == .multiply && !isMatrixA {
                                        
                                        numColsB = numRows
                                        
                                        addRow(for: &matrix1, rows: numRowsInt, cols: numColsInt)
                                        addColumn(for: &matrix2, cols: numRowsInt, rows: numRowsBInt)
                                    }
                                }
                            Text("\(Int(numRows))")
                        }
                        HStack {
                            Text("C")
                            Slider(value: $numCols, in: 1...10, step: 1)
                                .onChange(of: numCols) {

                                    
                                    if operationType == .add || operationType == .subtract {
                                        
                                        numColsB = numCols
                                        
                                        addColumn(for: &matrix1, cols: numColsInt, rows: numRowsInt)
                                        addColumn(for: &matrix2, cols: numColsInt, rows: numRowsInt)
                                        addColumn(for: &result, cols: numColsInt, rows: numRowsInt)
                                    }
                                    else if operationType == .multiply && isMatrixA {
                                        
                                        numRowsB = numCols
                                        addColumn(for: &matrix1, cols: numColsInt, rows: numRowsInt)
                                        addRow(for: &matrix2, rows: numColsInt, cols: numColsBInt)
                                        addRow(for: &result, rows: numRowsInt, cols: numColsBInt)
                                    }
                                    else if operationType == .multiply && !isMatrixA {
                                        
                                        addColumn(for: &matrix1, cols: numColsInt, rows: numRowsInt)
                                        addColumn(for: &result, cols: numColsInt, rows: numRowsBInt)
                                    }
                                    
                                }
                            Text("\(Int(numCols))")
                        }
                    }
                    .padding()
                    .frame(width: screenWidth, height: topBottomSegment)
                } else {
                    Spacer()
                }
                
            }
            .frame(width: screenWidth, height: screenHeight)
        }
        .ignoresSafeArea()
        .gesture(TapGesture().onEnded{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        .onChange(of: matrix1) { oldVal, newVal in
            if isMatrixA {
                onCalculate(&matrix1, &matrix2, &result)
            } else {
                onCalculate(&matrix2, &matrix1, &result)
            }
        }
    }
    
    func addRow(for myMatrix: inout [[Double]], rows: Int, cols: Int) {
        
        
        if rows > myMatrix.count {
            for _ in myMatrix.count..<rows {
                myMatrix.append(Array(repeating: 0, count: cols))
            }
        } else if rows < myMatrix.count {

            myMatrix.removeLast(myMatrix.count - rows)

            
            if tempRow >= myMatrix.count {
                withAnimation {
                    tempRow = myMatrix.count - 1
                }
            }
        }
    }
    
    func addColumn(for myMatrix: inout [[Double]], cols: Int, rows: Int) {
        for i in 0..<myMatrix.count {
            if cols > myMatrix[i].count {
                myMatrix[i].append(contentsOf: Array(repeating: 0, count: cols - myMatrix[i].count))
            } else if cols < myMatrix[i].count {
                myMatrix[i].removeLast(myMatrix[i].count - cols)
                
                if tempCol >= myMatrix[0].count {
                    withAnimation {
                        tempCol = myMatrix[0].count - 1
                    }
                }
                
            }
        }
    }
    
    var numRowsInt: Int {
        return Int(numRows)
    }
    
    var numColsInt: Int {
        return Int(numCols)
    }
    
    var numRowsBInt: Int {
        return Int(numRowsB)
    }
    
    var numColsBInt: Int {
        return Int(numColsB)
    }
    
}


#Preview {
    MultipleMatrixView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, numRows: .constant(1), numCols: .constant(1), numRowsB: .constant(1), numColsB: .constant(1), matrix1: .constant([[0.0]]), matrix2: .constant([[0.0]]), result: .constant([[0.0]]), isMatrixA: true, operationType: .add, onCalculate: {_,_,_ in })
}
