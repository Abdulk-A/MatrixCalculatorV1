//
//  SingleMatrixView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/27/24.
//

import SwiftUI

struct SingleMatrixView: View {
    
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    //need to check certain phone sizes
    
    @State private var numRows: Int = 1
    @State private var numCols = 2
    
    var boxWidth: Double {
        var denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        
        var denom: Double = numRows > 7 ? Double(numRows) : 7
        
        return screenHeight / (denom * 3)
    }
    
    @State private var num = 0
    @State private var textFields = Array(repeating: "", count: 100)
    
    @FocusState private var isTextFieldFocused: Bool
    
    
    var body: some View {
        ZStack {

            Image("grid2")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            
            VStack {
                
                VStack {
                    Spacer()
                        .frame(maxHeight: 50)
                    
                    HStack {
                        Text("       Rows: \(numRows)")
                            
                        Spacer()
                        
                        Stepper("", value: $numRows, in: 1...10)
                            .labelsHidden() // Hides the default label
                            .background(.white.opacity(0.8)) // Change background color
                            .clipShape(.rect(cornerRadius: 7))
                            
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red.opacity(0.65))
                    .clipShape(.rect(cornerRadius: 5))
                    
                    
                
                    HStack {
                        Text("Columns: \(numCols)")
            
                        Spacer()
                        
                        Stepper("", value: $numCols, in: 1...10)
                            .labelsHidden() // Hides the default label
                            .background(.white.opacity(0.8)) // Change background color
                            .clipShape(.rect(cornerRadius: 7))
                            
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black.opacity(0.8))
                    .clipShape(.rect(cornerRadius: 5))
                    
                    HStack {
                        Text("Columns: \(numCols)")
            
                        Spacer()
                        
                        Stepper("", value: $numCols, in: 1...10)
                            .labelsHidden() // Hides the default label
                            .background(.white.opacity(0.8)) // Change background color
                            .clipShape(.rect(cornerRadius: 7))
                            
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black.opacity(0.8))
                    .clipShape(.rect(cornerRadius: 5))
  
                }
                .padding()
                .bold()
                
                .foregroundStyle(.white)
                .font(.title2)
                    
                Spacer()
                
                VStack(spacing: 10){
                    ForEach(0..<numRows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<numCols, id: \.self) { col in
                                
                                TextField("", value: $num, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .padding(.leading, 5)
                                    .frame(width: boxWidth, height: boxHeight)
                                    .foregroundStyle(.white)
                                    .background(.black.opacity(0.65))
                                    .clipShape(.rect(cornerRadius: 5))
                                    .focused($isTextFieldFocused)
                            }
                            
                        }
                        
                    }
                }
                .padding(.bottom, isTextFieldFocused ? 110 : 0)
                .animation(.easeInOut, value: isTextFieldFocused)
                
                
                Spacer()
            }
            

        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SingleMatrixView()
}
