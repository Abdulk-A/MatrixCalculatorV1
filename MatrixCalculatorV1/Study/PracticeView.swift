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

    @State private var time_per_question = 0
    
    @State var values = [99,88,77,66,55]
    
    
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: sW, sH: sH)
            
            VStack {
                
                
                if let time_Amount {
                    CountDownTimerView(timeRemaining: $time_per_question)
                        .padding(.top, 50)
                }
                
                ForEach(values.indices, id: \.self) { i in
                    
                    if i == values.count - 1 {
                        Text("Hello")
                            
                    }
                }
                .padding(.bottom, sW / 6)
            
            }
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            
            
            
            if let time_Amount {
                time_per_question = time_Amount
            }
        }
    }
}

#Preview {
    PracticeView(difficulty: "Medium", sH: UIScreen.main.bounds.height, sW: UIScreen.main.bounds.width, time_Amount: 70, user_operations: [.add])
}

struct CountDownTimerView: View {
    
    @Binding var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text("\(minutes < 10 ? "0" : "")\(minutes) | \(seconds < 10 ? "0" : "")\(seconds) ")
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .padding()
                .background(.orange)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
        }
    }
    
    var minutes: Int {
        timeRemaining / 60
    }
    
    var seconds: Int {
        timeRemaining % 60
    }

}

