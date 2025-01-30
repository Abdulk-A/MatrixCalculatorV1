//
//  ResultView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/16/25.
//

import SwiftUI

struct ResultView: View {
    
    @Binding var result: [[Double]]
    
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
    
    var body: some View {
        VStack {
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
    }
}

#Preview {
    ResultView(result: .constant([[0]]), screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}
