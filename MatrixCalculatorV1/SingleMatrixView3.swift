//
//  SingleMatrixView3.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/13/25.
//

import SwiftUI

struct SingleMatrixView3: View {
    
    @FocusState private var isTextFieldFocused: Bool
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return screenHeight / (denom * 3)
    }
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    var topBottomSegment: Double {
        screenHeight / 6.0
    }
    
    var midSegment: Double {
        screenHeight - (topBottomSegment * 2)
    }
    
    
    @State private var numRows: Double = 1
    @State private var numCols: Double = 1
    
    @State private var isKeyboardShowing: Bool = false
    
    
    @State private var num = 0
    
    @State private var tempRow = 1
    @State private var tempCol = 1
    
    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.08)
            
            VStack(spacing: 0) {
                
                if !isKeyboardShowing {
                    HStack(spacing: 0) {

                        Spacer()
                        
                        HStack {
                            
                            Image(systemName: "arrow.uturn.left")
                                .padding(.leading)
                                .font(.title3)
                                .bold()
                                
                                
                
                            HStack(spacing: 0) {
                                TextField("", value: $num, formatter: NumberFormatter())
                                    .frame(height: topBottomSegment / 3)
                                    
                                    .padding(.leading)
                                    
                                    .padding(.trailing)
                                    .background(.black.opacity(0.03))
                                    

                                Image(systemName: "chevron.down")
                                    
                                    
                                    .bold()
                                    .padding(.horizontal)
                                    
                            }
                            .background(.regularMaterial.opacity(0.6))
                            .foregroundStyle(.black)
                            .font(.title3)
                            
                            Image(systemName: "arrow.uturn.right")
                                .padding(.trailing)
                                .font(.title3)
                                .bold()
                                
                                
                        }
                        
                        .background(.black.opacity(0.65))
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.trailing)
                        .foregroundStyle(.white)
                        
                    }
                    .padding(.top)
                    .frame(width: screenWidth, height: topBottomSegment)
                }
                
                
                VStack {
                    
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
                    .toolbar {
                        if isKeyboardShowing {
                            ToolbarItem(placement: .keyboard) {
                                HStack(spacing: 8) {
                                    HStack(spacing: 0) {
                                        Text("Row \(tempRow)")
                                        Stepper("", value: $tempRow, in: 1...10)
                                    }
                                    
                                    HStack(spacing: 0) {
                                        Text("Col \(tempCol)")
                                        Stepper("", value: $tempCol, in: 1...10)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                .frame(width: screenWidth, height: midSegment)
                
                
                if !isKeyboardShowing {
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
                    .padding()
                    .frame(width: screenWidth, height: topBottomSegment)
                }
                
            }
            .frame(width: screenWidth, height: screenHeight)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SingleMatrixView3()
}
