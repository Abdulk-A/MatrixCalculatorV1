//
//  SingleMatrixView4.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/22/25.
//

import SwiftUI

struct SingleMatrixView4: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Image("grid3")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .opacity(0.08)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SingleMatrixView4()
}
