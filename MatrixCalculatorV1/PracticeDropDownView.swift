//
//  PracticeDropDownView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 3/9/25.
//

import SwiftUI

struct PracticeDropDownView: View {
    
    @State private var showOtherFeatures = false
    @State private var f1 = false
    @State private var f2 = false
    @State private var f3 = false
    
    var body: some View {

        
        VStack {
            HStack(spacing: 5) {
                
                Button("Something") {
                    
                }
                .SomeModifer(for: 100)
                

                Image(systemName: showOtherFeatures ? "chevron.up": "chevron.down")
                    .onTapGesture {
                        withAnimation {
                            showOtherFeatures.toggle()
                        }
                        
                        DelayButtonAnimation(0.05) {f1.toggle()}
                        DelayButtonAnimation(0.10) {f2.toggle()}
                        DelayButtonAnimation(0.15) {f3.toggle()}
                    }
                    .frame(width: 25)
            }
            
            
            if showOtherFeatures {
                VStack {
                    if f1 {
                        Button("one") {}
                            .SomeModifer(for: 130)
                            .transition(.move(edge: .top))
                    }
                    
                    if !f2 {
                        Spacer()
                    }
                    
                    if f2 {
                        Button("two") {}
                            .SomeModifer(for: 130)
                            .transition(.move(edge: .top))
                    }
                    
                    if !f3 {
                        Spacer()
                    }

                    if f3 {
                        Button("three") {}
                            .SomeModifer(for: 130)
                            .transition(.move(edge: .top))
                    }
                }
                .padding(.top, 10)
                .frame(height: 130)
            } else {
                Rectangle()
                    .opacity(0)
                    .frame(height: 130)
            }
              
        }
        .frame(maxHeight: 300)
    }
    
    func DelayButtonAnimation(_ time: Double, _ action: @escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            action()
        }
        
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
