//
//  FeaturesMenuView1.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 3/11/25.
//

import SwiftUI

struct FeaturesMenuView1: View {
    
    let sW: Double
    let sH: Double
    let isResult: Bool
    @Binding var matrix: Matrix

    @State private var showOtherFeatures = false
    
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {

                Button("Copy") {
                    
                }
                .SomeModifer(for: 130)
                
                Button("Paste") {
                    
                }
                .SomeModifer(for: 130)
                
                Button("Transpose") {
                    matrix.transpose()
                }
                .SomeModifer(for: 130)

                if !isResult {
                    Button("Zero") {
                        Matrix.FillZeros(for: &matrix)
                    }
                    .SomeModifer(for: 130)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FeaturesMenuView1(sW: UIScreen.main.bounds.width, sH: UIScreen.main.bounds.height, isResult: false, matrix: .constant(Matrix([[0]])))
}
