//
//  ContentView.swift
//  First iOS App
//
//  Created by Mustafa Mohamed on 12/22/19.
// https://www.raywenderlich.com/3715234-swiftui-getting-started
//

import SwiftUI

struct ContentView: View {
    @State var rTarget = Double.random(in: 0..<1)
    @State var gTarget = Double.random(in: 0..<1)
    @State var bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        VStack {
            HStack {
              // Target color block
              VStack {
                Rectangle()
                .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))

                Text("Match this color").padding();
                
                Button(action: {
                    self.showAlert = true
                }) {
                  Text("Get Score")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
                }
              }
              // Guess color block
              VStack {
                Rectangle()
                .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))

                HStack {
                  HStack {
                    Text("R: \(Int(rGuess * 255.0))")
                    Text("G: \(Int(gGuess * 255.0))")
                    Text("B: \(Int(bGuess * 255.0))")
                  }.padding();
                }
                Button(action: {
                    self.rTarget = Double.random(in: 0..<1)
                    self.gTarget = Double.random(in: 0..<1)
                    self.bTarget = Double.random(in: 0..<1)
                    self.bGuess = 0.5
                    self.rGuess = 0.5
                    self.gGuess = 0.5
                }) {
                  Text("Change Color")
                }
              }
            }
            

            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess,   textColor: .green)
                ColorSlider(value: $bGuess,   textColor: .blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)

    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color

    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }
        .padding()
    }
}
