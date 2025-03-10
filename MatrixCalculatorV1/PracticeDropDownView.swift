//
//  PracticeDropDownView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 3/9/25.
//

import SwiftUI

struct PracticeDropDownView: View {
    
    @State private var showOtherFeatures = false
    
    var body: some View {
//        Button(isListForm ? "Matrix" : "List") {
//            withAnimation {
//                isListForm.toggle()
//            }
//        }
//        .frame(width: 75)
//        .padding([.trailing, .vertical], 8)
//        .background(Color("ButtonBackgroundStyle"))
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .foregroundStyle(.white)
        
        
        HStack(spacing: 5) {
            
            Button("Something") {
                
            }
            .SomeModifer(for: 100)
            

            Image(systemName: showOtherFeatures ? "chevron.up": "chevron.down")
                .onTapGesture {
                    withAnimation {
                        showOtherFeatures.toggle()
                    }
                }
                .frame(width: 25)
        }
        
        VStack {
            if showOtherFeatures {
                Button("one") {}
                    .SomeModifer(for: 130)
                Button("two") {}
                    .SomeModifer(for: 130)
                Button("three") {}
                    .SomeModifer(for: 130)
            }
        }
        .padding(.top, 10)
        
        
    }
}

#Preview {
    PracticeDropDownView()
}

struct SomeViewModifier: ViewModifier {
    
    let myWidth: Double
    
    func body(content: Content) -> some View {
        content
            .frame(width: myWidth)
            .padding([.trailing, .vertical], 8)
            .background(Color("ButtonBackgroundStyle"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.white)
    }
}

extension View {
    
    func SomeModifer(for width: Double) -> some View {
        modifier(SomeViewModifier(myWidth: width))
    }
}
