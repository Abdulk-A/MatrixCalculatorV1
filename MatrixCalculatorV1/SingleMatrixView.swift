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
                        .padding(.bottom, isKeyboardShowing ? 0 : sH / 25)
                } else {
                    ListEditView(matrix: $matrix, tempCol: $tempCol, tempRow: $tempRow, sH: sH, boxColor: .red.opacity(0.8), isKeyboardShowing: $isKeyboardShowing, showPrincipleButton: $showPrincipleButton, sw: sW)
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
                        
                        if !isListForm {
                            FeaturesMenuView2(sW: sW, sH: sH, matrix: $matrix, myOperation: operationType, numRows: $numRows, numCols: $numCols)
                                .padding(.bottom, sH / 12)
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
                .frame(width: 75)
                .padding([.trailing, .vertical], 8)
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

struct boxFocused: Hashable {
    let row: Int
    let col: Int
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
                            .keyboardType(.decimalPad)
                            .padding([.vertical, .leading], 8)
                            .frame(maxWidth: 100)
                            .foregroundStyle(.white)
                            .background(boxColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    
                    ToolbarItemGroup(placement: .keyboard) {
                        HStack {
                            HStack(spacing: 0) {
                                Text("-")
                                    .onTapGesture {
                                        if val > 0 {
                                            matrix[tempRow][tempCol] *= -1
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(val < 0 ? .green : .secondary)
                                    
                                
                                Text("+")
                                    .onTapGesture {
                                        if val < 0 {
                                            matrix[tempRow][tempCol] *= -1
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(val >= 0 ? .green : .secondary)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.left")
                                    .onTapGesture {
                                        if tempCol > 0 {tempCol -= 1 }
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(.secondary)
                                    
                                
                                Image(systemName: "chevron.right")
                                    .onTapGesture {
                                        if tempCol < matrix.cols - 1 {tempCol += 1}
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(.orange)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.down")
                                    .onTapGesture {
                                        if tempRow < matrix.rows - 1 {tempRow += 1}
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 9)
                                    .frame(maxWidth: textWidth)
                                    .background(.secondary)
                                    
                                
                                Image(systemName: "chevron.up")
                                    .onTapGesture {
                                        if tempRow > 0 {tempRow -= 1 }
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 9)
                                    .frame(maxWidth: textWidth)
                                    .background(.red)
                                    
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                        
                        }
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
    
    var val: Double {
        matrix[tempRow][tempCol]
    }
    
    var textWidth: Double {
        sW / 7.2
    }
}

#Preview {
    SingleMatrixView(matrix: .constant(Matrix([[0.0]])), numCols: .constant(1), numRows: .constant(1), operationType: .transpose, sH: UIScreen.main.bounds.height, sW: UIScreen.main.bounds.width, showPrincipleButton: .constant(false))
}


extension NumberFormatter {
    static var decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        formatter.usesGroupingSeparator = false
        return formatter
    }()
}


struct ListEditView: View {
    
    @Binding var matrix: Matrix
    @Binding var tempCol: Int
    @Binding var tempRow: Int
    let sH: Double
    let boxColor: Color
    
    
    @Binding var isKeyboardShowing: Bool
    @Binding var showPrincipleButton: Bool
    
    @FocusState private var focusedField: boxFocused?
    
    let sw: Double
    

    
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
            .padding(.top, 10)
            
            ScrollViewReader { proxy in
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
                                    .myTextStyle(row == tempRow && col == tempCol ? boxColor : Color("ButtonBackgroundStyle"))
                                    .myKeyboardModifier($isKeyboardShowing, $showPrincipleButton)
                                    .onTapGesture {
                                        withAnimation {
                                            tempRow = row
                                            tempCol = col
                                            focusedField = boxFocused(row: row, col: col)
                                        }
                                    }
                                    .focused($focusedField, equals: boxFocused(row: row, col: col))
                                    .id("\(row),\(col)")

                            }
                            .font(.title3.bold())
                            
                        }
                    }
                }
                .onAppear {
                    withAnimation(.bouncy) {
                        proxy.scrollTo("\(tempRow),\(tempCol)", anchor: .center)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        HStack {
                            HStack(spacing: 0) {
                                Text("-")
                                    .onTapGesture {
                                        if val > 0 {
                                            matrix[tempRow][tempCol] *= -1
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(val < 0 ? .green : .secondary)
                                    
                                
                                Text("+")
                                    .onTapGesture {
                                        if val < 0 {
                                            matrix[tempRow][tempCol] *= -1
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(val >= 0 ? .green : .secondary)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.left")
                                    .onTapGesture {
                                        if tempCol > 0 {tempCol -= 1 }
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(.secondary)
                                    
                                
                                Image(systemName: "chevron.right")
                                    .onTapGesture {
                                        if tempCol < matrix.cols - 1 {tempCol += 1}
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: textWidth)
                                    .background(.orange)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.down")
                                    .onTapGesture {
                                        if tempRow < matrix.rows - 1 {tempRow += 1}
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 9)
                                    .frame(maxWidth: textWidth)
                                    .background(.secondary)
                                    
                                
                                Image(systemName: "chevron.up")
                                    .onTapGesture {
                                        if tempRow > 0 {tempRow -= 1 }
                                        focusedField = boxFocused(row: tempRow, col: tempCol)
                                    }
                                    .padding(.vertical, 9)
                                    .frame(maxWidth: textWidth)
                                    .background(.red)
                                    
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(maxWidth: textWidth * 2)
                        
                        }
                    }
                }
            }
        }
        .frame(maxWidth: 500, maxHeight: isKeyboardShowing ? sH * 0.33 : sH * 0.55)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color("MenuBackgroundColor"))
                .shadow(radius: 10)
        )
        .padding()
        .scrollIndicators(.hidden)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar {
            if !showPrincipleButton {
                ToolbarItem(placement: .principal) {
                    
                    Text("\(matrix.values[tempRow][tempCol].formatted(.number))")
                        .padding(8)
                        .frame(maxWidth: 100, alignment: .leading)
                        .foregroundStyle(.white)
                        .background(boxColor)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        }
    }
    
    var val: Double {
        matrix[tempRow][tempCol]
    }
    
    var textWidth: Double {
        sw / 8.0
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
