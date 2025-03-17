//
//  ResultView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/16/25.
//

import SwiftUI

struct ResultView: View {
    
    //values coming from another view//
    
    let result: Matrix
    let screenWidth: Double
    let screenHeight: Double
    let operationType: MatrixOperation
    
    //*******************************//
    

    @State private var showList = false
    
    var body: some View {
        VStack {
            
            if operationType == .inverse {
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
            }
            
            Spacer()
            
            if showList {
                


                ScrollView {
                    VStack {
                        GeometryReader { proxy in
                            VStack(alignment: .leading) {
                                HStack(spacing: 0) {
                                    Text("Row")
                                        .frame(width: proxy.size.width * 0.25)
                                    Text("Column")
                                        .frame(width: proxy.size.width * 0.25)
                                        .foregroundStyle(.red.opacity(0.65))
                                    Spacer()
                                    Text("Value")
                                        .frame(width: proxy.size.width * 0.25)
                                }
                                .padding(.bottom)
                                .font(.title3)
                                .bold()

                                LazyVStack(alignment: .leading) {
                                    ForEach(0..<numRows, id: \.self) { row in
                                        ForEach(0..<numCols, id: \.self) { col in
                                            HStack {
                                                Text("\(row + 1)")
                                                    .frame(width: proxy.size.width * 0.25)
                                                Text("\(col + 1)")
                                                    .frame(width: proxy.size.width * 0.25)
                                                    .foregroundStyle(.red.opacity(0.65))
                                                Spacer()
                                                Text("\(flatMatrix[row * numCols + col].formatted())")
                                                    .frame(width: proxy.size.width * 0.25)
                                            }
                                            .padding(.bottom, 2)
                                            .font(.headline)
                                            .border(width: 3, edges: [.bottom], color: .black)
                                            .padding(.bottom, 4)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }

                    }
                }
                .multilineTextAlignment(.center)
                .scrollIndicators(.hidden)
                .padding()

                
            } else {
                VStack(spacing: 10){
                    ForEach(0..<numRows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<numCols, id: \.self) { col in
                                
                                Text("\(result.values[row][col].formatted())")
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .frame(width: boxWidth, height: boxHeight)
                                    
                                    .foregroundStyle(.white)
                                    .background(Color("ButtonBackgroundStyle"))
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                            
                        }
                        
                    }
                }
            }
            Spacer()
            

        }
    }
    
    var numRows: Int {
        result.rows
    }
    var numCols: Int {
        result.cols
    }
    
    var boxWidth: Double {
        let denom: Double = numCols > 7 ? Double(numCols) : 7
        return screenWidth / (denom * 1.6)
    }
    
    var boxHeight: Double {
        let denom: Double = numRows > 7 ? Double(numRows) : 7
        return screenHeight / (denom * 3)
    }
    
    var flatMatrix: [Double] {
        result.values.flatMap{ $0 }
    }
    
}

struct ListResultView: View {
    
    let matrix: Matrix

    let sH: Double
        
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
                            
                            Text("\(matrix.values[row][col].formatted())")
                                .frame(maxWidth: .infinity, alignment: .leading) // Ensures text aligns properly
                                .myTextStyle(Color("ButtonBackgroundStyle"))
                                

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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


#Preview {
    ResultView(result: Matrix([[0]]), screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height, operationType: .add)
}


extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
