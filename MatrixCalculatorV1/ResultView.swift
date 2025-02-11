//
//  ResultView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/16/25.
//

import SwiftUI

struct ResultView: View {
    
    var result: [[Double]]
    
    var numRows: Int {
        result.count
    }
    var numCols: Int {
        result[0].count
    }
    
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
    
    var flatMatrix: [Double] {
        result.flatMap{ $0 }
    }
    
    @State private var showList = false
    
    var body: some View {
        VStack {
            
            Button(showList ? "Matrix" :  "List") {
                withAnimation {
                    showList.toggle()
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .foregroundStyle(.white)
            .background(.black)
            .clipShape(.rect(cornerRadius: 10))
            .font(.title3)
            .padding(.top)
            
            Spacer()
            
            if showList {
                List {
                    ForEach(0..<numRows, id: \.self) { row in
                        ForEach(0..<numCols, id: \.self) { col in
                            HStack {
                                Text("Row \(row + 1) Column \( col + 1)")
                                Spacer()
                                Text("\(flatMatrix[row * numCols + col].formatted())")
                            }
                            .font(.headline)
                        }
                    }
                }
            } else {
                VStack(spacing: 10){
                    ForEach(0..<numRows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<numCols, id: \.self) { col in
                                
                                Text("\(result[row][col].formatted())")
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .frame(width: boxWidth, height: boxHeight)
                                    
                                    .foregroundStyle(.white)
                                    .background(.black.opacity(0.65))
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                        }
                        
                    }
                }
            }
            Spacer()
            

        }
    }
}

#Preview {
    ResultView(result: [[0]], screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}
