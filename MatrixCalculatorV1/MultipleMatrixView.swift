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
    


//    @State private var numRows: Double = 1
//    @State private var numCols: Double = 1
//    
    @Binding var numRows: Double
    @Binding var numCols: Double
    
    @State private var tempRow = 0
    @State private var tempCol = 0
    

    @State private var isKeyboardShowing: Bool = false
    
    @Binding var matrixA: [[Double]]
    @Binding var matrixB: [[Double]]
    @Binding var result: [[Double]]
    
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
                        ForEach(0..<matrixA.count, id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<matrixA[row].count, id: \.self) { col in
                                    TextField("", value: $matrixA[row][col], formatter: NumberFormatter())
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
                    .toolbar {
                        if isKeyboardShowing {
                            ToolbarItem(placement: .keyboard) {
                                HStack(spacing: 8) {
                                    HStack(spacing: 0) {
                                        Text("Row \(tempRow)")
                                        Stepper("", value: $tempRow, in: 1...10)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Text("Col \(tempCol)")
                                        Stepper("", value: $tempCol, in: 1...10)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .frame(width: screenWidth, height: midSegment)
                
                
                if !isKeyboardShowing {
                    VStack {
                        HStack {
                            Text("R")
                            Slider(value: $numRows, in: 1...10, step: 1)
                                .onChange(of: numRows) {
                                    
                                    let rows = Int(numRows)
                                    let columns = Int(numCols)
                                    
                                    addRow(for: &matrixA, rows: rows, cols: columns)
                                    addRow(for: &matrixB, rows: rows, cols: columns)
                                    addRow(for: &result, rows: rows, cols: columns)
                                    
                                }
                            Text("\(Int(numRows))")
                        }
                        HStack {
                            Text("C")
                            Slider(value: $numCols, in: 1...10, step: 1)
                                .onChange(of: numCols) {
                                    
                                    let rows = Int(numRows)
                                    let columns = Int(numCols)
                                    
                                    addColumn(for: &matrixA, cols: columns, rows: rows)
                                    addColumn(for: &matrixB, cols: columns, rows: rows)
                                    addColumn(for: &result, cols: columns, rows: rows)
                                    
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
        .onChange(of: matrixA) { oldVal, newVal in
            onCalculate(&matrixA, &matrixB, &result)
        }
    }
    
    func addRow(for myMatrix: inout [[Double]], rows: Int, cols: Int) {
        
        
        if rows > myMatrix.count {
            for _ in myMatrix.count..<rows {
                myMatrix.append(Array(repeating: 0, count: cols))
            }
        } else if rows < myMatrix.count {

            myMatrix.removeLast(myMatrix.count - rows)

            
            if tempRow >= rows {
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
                
                if tempCol >= cols {
                    withAnimation {
                        tempCol = myMatrix[0].count - 1
                    }
                }
                
            }
        }
    }
    
}

#Preview {
    MultipleMatrixView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, numRows: .constant(1), numCols: .constant(1), matrixA: .constant([[0]]), matrixB: .constant([[0]]), result: .constant([[0]]), onCalculate: {_,_,_ in })
}
