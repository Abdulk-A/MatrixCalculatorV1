//
//  SingleMatrixView2.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/12/25.
//

import SwiftUI

struct SingleMatrixView2: View {
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var topBarHeight: Double {
        screenHeight / 6.0
    }
    
    var middleBarHeight: Double {
        screenHeight / 7.0
    }
    
    var bottomBarHeight: Double {
        screenHeight - (middleBarHeight + topBarHeight)
    }
    
    var topBarColWidthLR: Double {
        screenWidth / 6.0
    }
    
    var topBarColWidthM: Double {
        screenWidth * 0.6
    }
    
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1

    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return screenHeight / (denom * 3)
    }
    
    @State private var num = 0
    @State private var textFields = Array(repeating: "", count: 100)
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack {
                VStack {
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        
                        Spacer()
                        
                        Image(systemName: "arrow.uturn.left")
                            .frame(width: topBarColWidthLR, height: topBarHeight)
                            .font(.title3)
                        
                        HStack {
                            TextField("", value: $num, formatter: NumberFormatter())
                                .padding()
                                .background(.regularMaterial)
                                
                            
                            Image(systemName: "arrow.uturn.right")
                                .frame(width: topBarColWidthLR)
                                .font(.title3)
                        }
                        
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                        
                    }
                    .frame(width: screenWidth, height: topBarHeight)
                    .background(.black.opacity(0.65))
                }
                
                VStack {
                    HStack {
                        Text("R")
                        Slider(value: $numRows, in: 1...10, step: 1)
                        Text("\(Int(numRows))")
                    }
                    HStack {
                        Text("C")
                        Slider(value: $numCols, in: 1...10, step: 1)
                        Text("\(Int(numCols))")
                    }
                }
                
                .padding(.horizontal)
                .frame(width: screenWidth, height: middleBarHeight)
                
                VStack {
                    
                    Spacer()
                    
                    
                    VStack(spacing: 10){
                        ForEach(0..<Int(numRows), id: \.self) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<Int(numCols), id: \.self) { col in
                                    
                                    TextField("", value: $num, formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: boxWidth, height: boxHeight)
                                        
                                        .foregroundStyle(.white)
                                        .background(.black.opacity(0.65))
                                        .clipShape(.rect(cornerRadius: 5))
                                        .focused($isTextFieldFocused)
                                        
                                }
                                
                            }
                            
                        }
                    }
                    
                    Spacer()
                    Spacer()
                }
                .frame(width: screenWidth, height: bottomBarHeight)
                
                
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SingleMatrixView2()
}
