//
//  TransposeView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/8/25.
//

import Accelerate
import SwiftUI

struct TransposeView: View {
    
    @State private var matrix = Matrix([[0]])
    
    let sW: Double
    let sH: Double
    let operationType: MatrixOperation
    @State private var power = 2
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    @State private var deter: Double = 0.0 //determinant
    
    @State private var isShowPopup = false
    @State private var isShowPopupInverse = false
    
    @State private var invArr: [Double]? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showPrincipleButton = true
    
    var rows: Int {
        Int(numRows)
    }
    var cols: Int {
        Int(numCols)
    }
    
    var topButtonTitle: String {
        if operationType == .power {
            return "Power \(power)"
        }
        return operationType.rawValue
    }
    
    var body: some View {
        ZStack {
            SingleMatrixView(matrix: $matrix, numCols: $numCols, numRows: $numRows, operationType: operationType, sH: sH, sW: sW, showPrincipleButton: $showPrincipleButton)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 3) {
                                Image(systemName: "chevron.left")
                                Text("Menu")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        if showPrincipleButton && operationType != .power {
                            Button(topButtonTitle) {
                                if operationType == .transpose  {
                                    matrix.transpose()

                                    let temp = numRows
                                    numRows = numCols
                                    numCols = temp

                                }
                                else if operationType == .determinant || operationType == .rank{
                                    withAnimation {
                                        isShowPopup.toggle()
                                    }
                                }
                                else if operationType == .inverse {
                                    Task {
                                        await invArr = matrix.invert()
                                        isShowPopupInverse.toggle()
                                    }
                                }
                            }
                            .foregroundStyle(.white)
                            .background(Color("ButtonBackgroundStyle"))
                            .clipShape(.rect(cornerRadius: 10))
                        } else if showPrincipleButton && operationType == .power {
                            HStack(spacing: 0) {
                                
                                Text("-")
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if power > 2 {
                                            power -= 1
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(.horizontal)
                                    .background(.red)
                                    .font(.title2)
                                
                                Button("\(power)") {
                                    withAnimation {
                                        matrix.power(n: power)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                Text("+")
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if power < 100 {
                                            power += 1
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(.horizontal)
                                    .background(.blue)
                                    .font(.title2)

                            }
                            .frame(maxWidth: 135)
                            .foregroundStyle(.white)
                            .background(Color("ButtonBackgroundStyle"))
                            .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                    
                }
                .sheet(isPresented: $isShowPopupInverse, content: {
                    if let invArr {
                        
                        let invMat = Matrix(arrToMatrix(arr: invArr))
                        
                        ResultView(result: invMat, screenWidth: sW, screenHeight: sH / 1.3, operationType: .inverse)
                    } else {
                        VStack {
                            Text("Inverse cannot be found for this matrix")
                                .padding()
                                .font(.title2)
                            Button("OK") {
                                withAnimation {
                                    isShowPopupInverse.toggle()
                                }
                            }
                            .padding()
                            .foregroundStyle(.white)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 10))
                            .font(.title3)
                        }
                    }
                })
            if isShowPopup && operationType == .determinant {
                DeterminantResult(res: matrix.determinent(), showPopUp: $isShowPopup, sW: sW / 1.5, sH: sH / 3.5, title: "Determinant")
                    .clipShape(.rect(cornerRadius: 15))
            } 
            else if isShowPopup && operationType == .rank {
                let tempMat = matrix.rowEchelonForm()
                DeterminantResult(res: Double(Matrix.countNonZeroRows(tempMat, nRows: rows, nCols: cols)), showPopUp: $isShowPopup, sW: sW / 1.5, sH: sH / 3.5, title: "Rank")
            }
                        
        }
    }
    

    func arrToMatrix(arr: [Double]) -> [[Double]] {
        var result = Array(repeating: Array(repeating: 0.0, count: cols), count: rows)
        
        for i in 0..<rows {
            for j in 0..<cols {
                result[i][j] = arr[i * cols + j]
            }
        }
        
        return result
    }
}

struct DeterminantResult: View {
    
    
    let res: Double
    @Binding var showPopUp: Bool
    let sW: Double
    let sH: Double
    
    let title: String
    
    var body: some View {
        VStack {
            
            HStack {
                Text("\(title) =")
                Text("\(res.formatted())")
                    .bold()
            }
            .font(.title2)
            Button {
                withAnimation {
                    showPopUp.toggle()
                }
            } label: {
                Text("OK")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .font(.title3)
            }
        }
        .frame(width: sW, height: sH)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 4)
        )
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    TransposeView(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, operationType: .power)
}
