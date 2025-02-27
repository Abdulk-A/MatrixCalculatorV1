//
//  SingleMatrixView3.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/13/25.
//

import SwiftUI

struct SingleMatrixView: View {
    
    //values coming from another view//
    
    @Binding var matrix: Matrix
    @Binding var numCols: Double
    @Binding var numRows: Double
    
    let operationType: MatrixOperation
    let sH: Double
    let sW: Double
    
    //*******************************//
    
    @State private var isKeyboardShowing: Bool = false
    @State private var tempCol = 0
    @State private var tempRow = 0
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack(spacing: 0) {
                
                Spacer()
                
                MatrixEditView(matrix: $matrix, isKeyboardShowing: $isKeyboardShowing, tempCol: $tempCol, tempRow: $tempRow, boxColor: .red.opacity(0.8), numCols: numCols, numRows: numRows, sW: sW, sH: sH)
                      

                if !isKeyboardShowing {
                    VStack {
                        HStack {
                            Text("R")
                            Slider(value: $numRows, in: 1...10, step: 1)
                                .onChange(of: numRows) {
                                    checkOp()
                                    matrix.addRow(nRows: rows)
                                    checkTemp()
                                }
                            Text("\(Int(numRows))")
                        }
                        HStack {
                            Text("C")
                            Slider(value: $numCols, in: 1...10, step: 1)
                                .onChange(of: numCols) {
                                    checkOp()
                                    matrix.addColumn(nCols: cols)
                                    checkTemp()
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
    
    var topBottomSegment: Double {
        sH / 6.0
    }
    
    func checkTemp() {
        
        if tempRow >= matrix.rows {
            tempRow = matrix.rows - 1
        }
        if tempCol >= matrix.cols {
            tempCol = matrix.cols - 1
        }
    }
    
    func checkOp() {
        if operationType == .determinant || operationType == .inverse || operationType == .power {
            numCols = numRows
        }
    }
    

}

struct MatrixEditView: View {
    
    //values coming from another view//
    
    @Binding var matrix: Matrix
    @Binding var isKeyboardShowing: Bool
    @Binding var tempCol: Int
    @Binding var tempRow: Int
    
    let boxColor: Color
    let numCols: Double
    let numRows: Double
    
    let sW: Double
    let sH: Double
    
    //*******************************//
        
    var body: some View {
        VStack {
            VStack(spacing: 10){
                ForEach(0..<matrix.rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<matrix.cols, id: \.self) { col in
                            
                            TextField("", value: $matrix.values[row][col], formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: boxWidth, height: boxHeight)
                                .foregroundStyle(.white)
                                .background(row == tempRow && col == tempCol ? boxColor : Color("ButtonBackgroundStyle").opacity(0.70))
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
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return sH / (denom * 3)
    }
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return sW / (denom * 1.6)
    }
        
    var midSegment: Double {
        sH - (topBottomSegment * 2)
    }
    
    var topBottomSegment: Double {
        sH / 6.0
    }
}

#Preview {
    SingleMatrixView(matrix: .constant(Matrix([[0.0]])), numCols: .constant(1), numRows: .constant(1), operationType: .transpose, sH: UIScreen.main.bounds.height, sW: UIScreen.main.bounds.width)
}
