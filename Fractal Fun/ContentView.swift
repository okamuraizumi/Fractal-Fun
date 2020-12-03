//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var sliderOneValue=0.0

    @State var sliderTwoValue=0.0
    
    @State var alertIsVisible=false
    
    
    var body: some View {
        VStack {
            Button(action: {self.alertIsVisible = true}) {
                Text("Push me")
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("FRACTAL"),
                             message: Text("slider one value is \(getSliderOneValue())\n" +
                             "slider two value is \(getSliderTwoValue())")
                )
            }
            Slider(value: $sliderOneValue, in:-2.0...2.0)
            Slider(value: $sliderTwoValue, in:-2.0...2.0)
        Text("We <3 Math")
            .padding()
            
        }
    }
    func getSliderOneValue() ->Double{
        return sliderOneValue
        
        
    }
    func getSliderTwoValue() ->Double{
        return sliderTwoValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getUpdatedValues(x:Double,y:Double)-> (x_new:Double,y_new:Double) {
   let x_new=(x*x-y*y)
   let y_new=(2*x*y)
    return (x_new, y_new)

}
