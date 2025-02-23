//
//  PracticeView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/22/25.
//

import SwiftUI

struct PracticeView: View {
    
    
    let difficulty: String
    let sH: Double
    let sW: Double
    let time_Amount: Int?
    let user_operations: [MatrixOperation]

    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack {
                
                
                if let time_Amount {
                    CountDownTimerView(timeAmount: time_Amount)
                        .padding(.top, 50)
                }
                
                
                ScrollView(.horizontal) {

                }
            }
            
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PracticeView(difficulty: "Medium", sH: UIScreen.main.bounds.width, sW: UIScreen.main.bounds.height, time_Amount: 10, user_operations: [.add])
}

struct CountDownTimerView: View {
    
    let timeAmount: Int
    @State private var timeRemaining: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text("\(minutes) | \(seconds)")
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
        }
        .onAppear{
            timeRemaining = timeAmount
        }
    }
    
    var minutes: Int {
        timeAmount / 60
    }
    
    var seconds: Int {
        timeAmount % 60
    }

}

//
//going to have another view for the countdown timer
///*
// 
//
//
// Matrix 1
//let matrix1: [[Int]] = [
//    [1, 2, 3],
//    [4, 5, 6],
//    [7, 8, 9]
//]
//
// Matrix 2
//let matrix2: [[Int]] = [
//    [9, 8, 7],
//    [6, 5, 4],
//    [3, 2, 1]
//]
//
// Matrix 3
//let matrix3: [[Int]] = [
//    [2, 4, 6],
//    [1, 3, 5],
//    [7, 5, 8]
//]
//
// Matrix 4
//let matrix4: [[Int]] = [
//    [5, 1, 3],
//    [2, 6, 4],
//    [9, 7, 8]
//]
