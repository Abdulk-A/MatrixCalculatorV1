////
////  MainScreen5.swift
////  MatrixCalculatorV1
////
////  Created by Abdullah Abdulkareem on 12/26/24.
////
//
//import SwiftUI
//
//struct MainScreenView: View {
//    
//    let screenWidth = UIScreen.main.bounds.width
//    let screenHeight = UIScreen.main.bounds.height
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                
//                GridImageBackgroundView(name: "grid2", sW: screenWidth, sH: screenHeight)
//                                
//                VStack {
//                    Text("Menu")
//                        .frame(maxWidth: .infinity)
//                        .font(.largeTitle)
//                        .foregroundStyle(.white)
//                        .blur(radius: 8)
//                        .overlay{
//                            Text("Menu")
//                                .font(.largeTitle)
//                                .foregroundStyle(.white)
//                                .bold()
//                        }
//                    VStack {
//                        
//                        NavigationLink(destination: OperationsView(screenWidth: screenWidth, screenHeight: screenHeight)) {
//                            
//                            Text("Calculator")
//                                .myTextStyle()
//                        }
//                        
//                        NavigationLink(destination: PracticeSetupView(screenWidth: screenWidth, screenHeight: screenHeight)) {
//                            
//                            Text("Practice")
//                                .myTextStyle()
//                        }
//                        
//                        
//                        Button {
//                            
//                        } label: {
//                            Text("Feedback")
//                        }
//                        .buttonStyle(ExampleButton6())
//
//                    }
//                    .padding()
//                }
//                .frame(maxWidth: 500)
//                .padding(.vertical)
//                .background(
//                    RoundedRectangle(cornerRadius: 15)
//                        .foregroundStyle(Color("MenuBackgroundColor"))
//                        .shadow(radius: 10)
//                )
//                .padding()
//                    
//            }
//            .ignoresSafeArea(.all)
//        }
//    }
//}
//
//#Preview {
//    MainScreenView()
//}
//



