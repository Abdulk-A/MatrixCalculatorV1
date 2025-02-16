//
//  TextRecognitionPracticeView.swift
//  MatrixCalculatorV1
//
//  Created by Abdullah Abdulkareem on 1/28/25.
//

import SwiftUI
import Vision
import CoreML

struct TextRecognitionPracticeView: View {
    
    @State private var stuff = []
    
    var body: some View {
        VStack {

            ForEach(stuff.indices, id: \.self) { num in
                Text("\(stuff[num])")
            }
            
            Button {
                textRecognizer()
            } label: {
                Text("Show Numbers")
                    .padding()
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .font(.title)
            }
        }
    }
    func textRecognizer() {
        guard let cgImage = UIImage(named: "matrixSample")?.cgImage else {return}
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request \(error).")
        }
    }

    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {return}
        let text = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
//        print(text)

        for num in text {
            stuff.append(num)
        }
        
        print(stuff)
    }
}



#Preview {
    TextRecognitionPracticeView()
}
