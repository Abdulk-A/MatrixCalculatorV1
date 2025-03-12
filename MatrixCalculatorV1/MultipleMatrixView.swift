//
//  MultipleMatrixView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/28/25.
//

import SwiftUI

struct MultipleMatrixView: View {
    
    //values coming from another view//
    
    let screenWidth: Double
    let screenHeight: Double

    @Binding var numRows: Double
    @Binding var numCols: Double
    
    @Binding var numRowsB: Double
    @Binding var numColsB: Double
    
    @Binding var matrix1: Matrix
    @Binding var matrix2: Matrix
    @Binding var result: Matrix
    
    let isMatrixA: Bool
    let tempColor: Color
    
    let operationType: MatrixOperation
    let onCalculate: (inout Matrix, inout Matrix, inout Matrix) -> Void
    
    @State private var showPrincipleButton = true
    
    //*******************************//
    
    
    @State private var tempRow = 0
    @State private var tempCol = 0
    @State private var isKeyboardShowing: Bool = false
    
    @State private var isListForm = false
    
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: screenWidth, sH: screenHeight)
            
            VStack(spacing: 0) {
                
                Spacer()
                
                if !isListForm {
                    MatrixEditView(matrix: $matrix1, isKeyboardShowing: $isKeyboardShowing, tempCol: $tempCol, tempRow: $tempRow, boxColor: tempColor, numCols: numCols, numRows: numRows, sW: screenWidth, sH: screenHeight, showPrincipleButton: $showPrincipleButton)
                } else {
                    ListEditView(matrix: $matrix1, tempCol: $tempCol, tempRow: $tempRow, sH: screenHeight, boxColor: tempColor, isKeyboardShowing: $isKeyboardShowing, showPrincipleButton: $showPrincipleButton)
                }
                
                if !isKeyboardShowing {
                    VStack {
                        HStack {
                            Text("R")
                            Slider(value: $numRows, in: 1...10, step: 1)
                                .onChange(of: numRows) {

                                    matrix1.addRow(nRows: numRowsInt)
                                    
                                    if operationType == .add || operationType == .subtract {
                                        numRowsB = numRows
                                        matrix2.addRow(nRows: numRowsInt)
                                        result.addRow(nRows: numRowsInt)
                                    }
                                    else if operationType == .multiply && isMatrixA {
                                        result.addRow(nRows: numRowsInt)
                                    }
                                    else if operationType == .multiply && !isMatrixA {
                                        numColsB = numRows
                                        matrix2.addColumn(nCols: numRowsInt)
                                    }
                                }
                            Text("\(Int(numRows))")
                        }
                        HStack {
                            Text("C")
                            Slider(value: $numCols, in: 1...10, step: 1)
                                .onChange(of: numCols) {

                                    matrix1.addColumn(nCols: numColsInt)
                                    
                                    if operationType == .add || operationType == .subtract {
                                        numColsB = numCols
                                        matrix2.addColumn(nCols: numColsInt)
                                        result.addColumn(nCols: numColsInt)
                                    }
                                    else if operationType == .multiply && isMatrixA {
                                        numRowsB = numCols
                                        matrix2.addRow(nRows: numColsInt)
                                    }
                                    else if operationType == .multiply && !isMatrixA {
                                        result.addColumn(nCols: numColsInt)
                                    }
                                    
                                }
                            Text("\(Int(numCols))")
                        }
                        

                        if !isListForm {
                            FeaturesMenuView1(sW: .infinity, sH: screenHeight, matrix1: $matrix1, matrix2: $matrix2, result: $result, myOperation: operationType, numRows: $numRows, numCols: $numCols, numRowsB: $numRowsB, numColsB: $numColsB)
                                .padding(.bottom, screenHeight / 12)
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isListForm ? "Matrix" : "List") {
                    withAnimation {
                        isListForm.toggle()
                    }
                }
                .frame(width: 75)
                .padding([.trailing, .vertical], 8)
                .background(Color("ButtonBackgroundStyle"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
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
    
    var topBottomSegment: Double {
        screenHeight / 6.0
    }
}


#Preview {
    MultipleMatrixView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, numRows: .constant(1), numCols: .constant(1), numRowsB: .constant(1), numColsB: .constant(1), matrix1: .constant(Matrix([[0]])), matrix2: .constant(Matrix([[0]])), result: .constant(Matrix([[0]])), isMatrixA: true, tempColor: .red, operationType: .add, onCalculate: {_,_,_ in})
}
