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
                        
                        if !showOtherFeatures {
                            f1 = false
                            f2 = false
                            f3 = false
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                f1 = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                f2 = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                f3 = true
                            }
                        }
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
                    if f2 {
                        Button("two") {}
                            .SomeModifer(for: 130)
                            .transition(.move(edge: .top))
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
