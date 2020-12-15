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
    
    @State var coordinates = [[(Double, Double)]]()
    @State var newCoordinates = [(Double, Double)]()
    @State var inSetCoordinate = [Bool]()
    var body: some View {
        VStack {
            Button(action: {self.alertIsVisible = true;
                fillPointsArray(xLower: -2.0, xUpper: 2.0, xInNum: 5, yLower: -2.0, yUpper: 2.0, yInNum: 5)
                    x=getSliderOneValue();
                    y=getSliderTwoValue();
                    (xNew,yNew)=getUpdatedValues(x:x,y:y)
            }) {
                Text("Press me")
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("FRACTAL"),
                             message: Text( "new x value is ")
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
    func fillPointsArray(xLower:Double, xUpper:Double, xInNum:Int, yLower:Double, yUpper:Double, yInNum:Int) {
        var xCoor:Double
        var yCoor:Double
        let xIncrement=(xUpper-xLower)/Double(xInNum-1)
        let yIncrement=(yUpper-yLower)/Double(yInNum-1)
        for indX in 0...xInNum-1 {
            for indY in 0...yInNum-1{
                xCoor=xLower+Double(indX)*xIncrement
                yCoor=yLower+Double(indY)*yIncrement
                coordinates.append([(xCoor,yCoor)])
                newCoordinates.append((xCoor,yCoor))
                inSetCoordinate.append(true)
            }
        }
        
    }
    func updateCoordinates(){
        var indexCoordinate:Int
        var Xcoordinate:Double
        var Ycoordinate:Double
        var newXcoordinate:Double
        var newYcoordinate:Double
        var coordinate:[(Double,Double)]
            for indexCoordinate in 0...newCoordinates.count-1{
                coordinate = coordinates[(indexCoordinate)]
                Xcoordinate=coordinate[0].0
        }
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
