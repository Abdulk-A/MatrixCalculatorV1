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
    
    @Binding var showPrincipleButton: Bool
    
    //*******************************//
    
    @State private var isKeyboardShowing: Bool = false
    @State private var tempCol = 0
    @State private var tempRow = 0
    
    @State private var isListForm = false
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack(spacing: 0) {
                
                Spacer()
                
                if !isListForm {
                    MatrixEditView(matrix: $matrix, isKeyboardShowing: $isKeyboardShowing, tempCol: $tempCol, tempRow: $tempRow, boxColor: .red.opacity(0.8), numCols: numCols, numRows: numRows, sW: sW, sH: sH, showPrincipleButton: $showPrincipleButton)
                } else {
                    ListEditView(matrix: $matrix, sH: sH, isKeyboardShowing: $isKeyboardShowing, showPrincipleButton: $showPrincipleButton)
                }

                      
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isListForm ? "Matrix" : "List") {
                    withAnimation {
                        isListForm.toggle()
                    }
                }
                .frame(width: 75) // Set the width explicitly
                .padding(.trailing, 8)
                .background(Color("ButtonBackgroundStyle"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)

                
            }
        }
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
    
    @Binding var showPrincipleButton: Bool
    
    //*******************************//
    
    struct boxFocused: Hashable {
        let row: Int
        let col: Int
    }
    
    @FocusState private var focusedField: boxFocused?
        
    var body: some View {
        VStack {
            VStack(spacing: 10){
                ForEach(0..<matrix.rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<matrix.cols, id: \.self) { col in
                            TextField("", value: $matrix.values[row][col], formatter: NumberFormatter.decimal)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .frame(width: boxWidth, height: boxHeight)
                                .foregroundStyle(.white)
                                .background(row == tempRow && col == tempCol ? boxColor : Color("ButtonBackgroundStyle"))
                                .clipShape(.rect(cornerRadius: 5))
                                .onTapGesture {
                                    withAnimation {
                                        tempRow = row
                                        tempCol = col
                                        focusedField = boxFocused(row: row, col: col)
                                    }
                                }
                                .focused($focusedField, equals: boxFocused(row: row, col: col))
                        }
                        
                    }
                    
                }
            }
            .myKeyboardModifier($isKeyboardShowing, $showPrincipleButton)
            .toolbar {
                if !showPrincipleButton {
                    ToolbarItem(placement: .principal) {
                        
                        TextField("", value: $matrix.values[tempRow][tempCol], formatter: NumberFormatter.decimal)
                            .padding([.vertical, .leading], 8)
                            .frame(maxWidth: 100)
                            .foregroundStyle(.white)
                            .background(boxColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
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
    SingleMatrixView(matrix: .constant(Matrix([[0.0]])), numCols: .constant(1), numRows: .constant(1), operationType: .transpose, sH: UIScreen.main.bounds.height, sW: UIScreen.main.bounds.width, showPrincipleButton: .constant(false))
}


extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        return formatter
    }
}

struct ListEditView: View {
    
    @Binding var matrix: Matrix
    let sH: Double
    
    @Binding var isKeyboardShowing: Bool
    @Binding var showPrincipleButton: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Row")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 40)
                Text("Col")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 40)
                    
                Text("Values")
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .font(.title3.bold())
            
            ScrollView {
                ForEach(0..<matrix.rows, id: \.self) { row in
                    ForEach(0..<matrix.cols, id: \.self) { col in
                        HStack {
                            
                            Text("\(row + 1) ")
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 40)
                            Text("\(col + 1)")
                                .foregroundStyle(.blue)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 40)
                            
                            TextField("", value: $matrix.values[row][col], formatter: NumberFormatter.decimal)
                                .keyboardType(.decimalPad)
                                .myTextStyle()
                                .myKeyboardModifier($isKeyboardShowing, $showPrincipleButton)
                        }
                        .font(.title3.bold())
                        
                    }
                }
            }
        }
        .frame(maxWidth: 500, maxHeight: sH * 0.55)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color("MenuBackgroundColor"))
                .shadow(radius: 10)
        )
        .padding()
        .scrollIndicators(.hidden)
    }
}

struct KeyboardModifier: ViewModifier {
    
    @Binding var isKeyboardShowing: Bool
    @Binding var showPrincipleButton: Bool
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                withAnimation {
                    isKeyboardShowing = true
                    showPrincipleButton = false
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                withAnimation {
                    isKeyboardShowing = false
                    showPrincipleButton = true
                }
            })
    }
}

extension View {
    func myKeyboardModifier(_ isKeyboardShowing: Binding<Bool>, _ showPrincipleButton: Binding<Bool>) -> some View {
        modifier(KeyboardModifier(isKeyboardShowing: isKeyboardShowing, showPrincipleButton: showPrincipleButton))
    }
}
