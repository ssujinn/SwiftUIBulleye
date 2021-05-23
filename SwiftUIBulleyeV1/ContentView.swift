//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by RelMac User Exercise2 on 2021/05/07.
//

import SwiftUI

struct ContentView: View {
    // Properties
    // ============
    
    // stage for User Interface views
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bull eye as close as you can do!")
                //Text("100")
                Text("\(target)")
            }
            Spacer()
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            // Button row
            Button(action: {
                //print("Button pressed")
                print(" Points awarded: \(self.pointsForCurrentRound())")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            // State for alert
            .alert(isPresented: $alertIsVisible){
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Awsome!")){
                        self.startNewRound()
                      })
            }   // End of .alert()
            Spacer()
            // Score row
            // TODO: Add view for the score, rounds, and start over and info buttons
            HStack {
                Button(action:{
                    self.startNewGame()
                }){
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action:{}){
                    Text("Inform")
                }
            }.padding(.bottom, 20)
        }   // End of VStack
        .onAppear() {
            self.startNewGame()
        }
    }   // End of body
    
    // Methods
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(sliderValueRounded).\n" + "The target value is \(target).\n" + "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String{
        let title: String
        
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargetDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    func startNewRound() {
        score = score + pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    func resetSliderAndTarget() {
        //sliderValue = 50
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
} // End of struct

// Preview
// ==================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
