//
//  PracticeSetupView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 2/19/25.
//

import SwiftUI

struct PracticeSetupView: View {
    
    let screenWidth: Double
    let screenHeight: Double
    
    @State private var operationsPicked: [MatrixOperations] = []
    @State private var isOperationsSelected = false
    @State private var isTimerSelected = false
    
    @State private var isTimerOn = false
    
    @State private var opSelection = Array(repeating: false, count: MatrixOperation.allCases.count)
    
    @State private var timeAmount = 0
    
    var difficulties = ["Easy", "Medium", "Hard"]
    @State private var selectedDifficulty = "Easy"
    
    var body: some View {
        ZStack {
            
            GridImageBackgroundView(name: "grid3", sW: screenWidth, sH: screenHeight)
            
            VStack {

                VStack {
                    Text("Practice")
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .blur(radius: 8)
                        .overlay{
                            Text("Practice")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    VStack {
                        
                        Button {
                            
                        } label: {
                            Text("Start")
                        }
                        .buttonStyle(ExampleButton6(backgroundColor: .blue, fontColor: .white))

                        Button {
                            withAnimation {
                                isOperationsSelected.toggle()
                            }
                        } label: {
                            Text("Operations")
                        }
                        .buttonStyle(ExampleButton6())
                        
                        if isOperationsSelected {
                            VStack {
                                ScrollView {
                                    ForEach(MatrixOperation.allCases.indices, id: \.self) { i in
                                        
                                        
                                        
                                        CheckBoxView(isOn: $opSelection[i]) {
                                            Text("\(MatrixOperation.allCases[i].rawValue)")
                                                .foregroundStyle(.white) //have to change this later
                                        }

                                    }
                                }
                                .scrollIndicators(.hidden)
                            }
                            .myBackgroundStyle(height: screenHeight / 4)
                        }
                        
                        Button {
                            withAnimation {
                                isTimerSelected.toggle()
                            }
                        } label: {
                            Text("Settings")
                        }
                        .buttonStyle(ExampleButton6())
                        
                        if isTimerSelected {
                            VStack {
                                ScrollView {
                                    
                                    Picker("Difficulty", selection: $selectedDifficulty) {
                                        ForEach(difficulties, id: \.self) {
                                            Text($0)
                                        }
                                        
                                    }
                                    .pickerStyle(.segmented)
                                    .padding(.bottom, 8)
                                    
                                    Toggle(isOn: $isTimerOn) {
                                        Text("Timer \(isTimerOn ? "on" : "off")")
                                            
                                    }
                                    .padding(.bottom, 8)
                                    
                                    if isTimerOn {
                                        Text("Time per question \(timeAmount)")
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                }
                                .foregroundStyle(.white)
                                .scrollIndicators(.hidden)
                            }
                            .myBackgroundStyle(height: screenHeight / 4)
                        }

                        
                        CustomDismissButton()

                    }
                    .padding()
                }
                .frame(maxWidth: 500)
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color("MenuBackgroundColor"))
                        .shadow(radius: 10)
                )
                .padding()

            }
            .padding(.top, topPadding)
            
        }
        .ignoresSafeArea()
        .onAppear {
            opSelection[0] = true
        }
    }
    
    var topPadding: Double {
        isOperationsSelected ? screenHeight / 10 : 0
    }
}

#Preview {
    PracticeSetupView(screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
}

struct CustomBackgroundStyle: ViewModifier {
    
    let myHeight: Double

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, maxHeight: myHeight)
            .background(Color("ButtonBackgroundStyle"))
            .clipShape(.rect(cornerRadius: 10))
        
    }
}

struct CheckBoxView<Label: View>: View {
    
    @Binding var isOn: Bool
    let label: () -> Label
    
    var body: some View {
        HStack {
            
            label()
            
            Spacer()
            Image(systemName: isOn ? "checkmark.square.fill" : "square")
                .foregroundStyle(isOn ? .red : .secondary)
                .onTapGesture {
                    isOn.toggle()
                }
        }
        .font(.title3)
    }
}
