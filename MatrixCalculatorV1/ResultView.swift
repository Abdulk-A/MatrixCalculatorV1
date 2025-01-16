//
//  ResultView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/16/25.
//

import SwiftUI

struct ResultView: View {
    
    let numRows: Int
    let numCols: Int
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return screenHeight / (denom * 3)
    }
    
    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack {
                VStack(spacing: 10){
                    ForEach(0..<Int(numRows), id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<Int(numCols), id: \.self) { col in
                                
                                Text("0")
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
        .ignoresSafeArea()
    }
}

#Preview {
    ResultView(numRows: 10, numCols: 10)
}
