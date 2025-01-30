//
//  MainScreen5.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 12/26/24.
//

import SwiftUI

struct MainScreenView5: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {


            Image("grid2")
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
                .opacity(0.2)
                            
            VStack {
                Text("Menu")
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .blur(radius: 8)
                    .overlay{
                        Text("Menu")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .bold()
                    }
                VStack {
                    Button {
                        
                    } label: {
                        Text("Calculator")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    
                    Button {
                        
                    } label: {
                        Text("Practice")
                    }
                    .buttonStyle(ExampleButton6())
                    
                    
                    Button {
                        
                    } label: {
                        Text("Feedback")
                    }
                    .buttonStyle(ExampleButton6())

                }
                .padding()
            }
            .frame(maxWidth: 500)
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.gray.opacity(0.5))
                    .shadow(radius: 10)
            )
            .padding()
            

                
        }
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    MainScreenView5()
}

struct ExampleButton6: ButtonStyle {
    
    var buttonOpacity = 0.4
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding()
        
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black.opacity(buttonOpacity))
            )
            .font(.title.bold())
            

            .foregroundStyle(.white.opacity(0.8))
            .padding(.bottom, 6)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 6)
            
    }
}


