//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI


var increment=1.0

struct ContentView: View {
    @State var sliderOneValue=0.0

    @State var sliderTwoValue=0.0
    
    @State var alertIsVisible=false
    
    @State var x=0.0
    @State var y=0.0
    @State var xNew=0.0
    @State var yNew=0.0
    
    @State var my2DArray = Array(stride(from: -2.0, to: increment + 2.0, by: increment))
    let zeroedArray = Array(repeating: 0, count: 7)
        
    var body: some View {
        VStack {
            Button(action: {self.alertIsVisible = true;
                    x=getSliderOneValue();
                    y=getSliderTwoValue();
                    (xNew,yNew)=getUpdatedValues(x:x,y:y)
            }) {
                Text("Push me")
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("FRACTAL"),
                             message: Text( "new x value is \(my2DArray)\n" +
                                           "new y value is \(zeroedArray)\n" )
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

//func getChartPointArray(xMin:Double,xMax:Double,yMin:Double,yMax:Double,increment:Double)-> (Array<Array<Double>>){}
