//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI


var increment=1.0

struct ContentView: View {
    @State var sliderOneValue=1.0

    @State var sliderTwoValue=1.0
    @State var sliderThreeValue=2.0
    
    @State var alertIsVisible=false
    
    @State var x=0.0
    @State var y=0.0
    @State var numOfPoints=0
    @State var xNew=0.0
    @State var yNew=0.0
    
    
    @State var coordinates = [[(Double, Double)]]()
    @State var newCoordinates = [(Double, Double)]()
    @State var inSetCoordinate = [Bool]()
    
    var body: some View {
        VStack {
            Button(action: {self.alertIsVisible = true;
                    x=getSliderOneValue();
                    y=getSliderTwoValue();
                    numOfPoints=getSliderThreeValue();
                    coordinates = [[(Double, Double)]]();
                    newCoordinates = [(Double, Double)]();
                    inSetCoordinate = [Bool]();
                    fillPointsArray(xLower: -x, xUpper: x, xInNum: numOfPoints, yLower: -y, yUpper: y, yInNum: numOfPoints);
            }) {
                Text("Initialize")
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("FRACTAL"),
                             message: Text( "new x value is  \(x) \n" +
                                            "new y value is  \(y) \n" +
                                            "numOfPoints value is \(numOfPoints)")
                )
            }
            
            Button(action: {
                    updateCoordinates();
                    print(newCoordinates);
                    print(inSetCoordinate);
            }) {
                Text("New Values")
            }
            
            Slider(value: $sliderOneValue, in:1.0...3.0)
            Slider(value: $sliderTwoValue, in:1.0...3.0)
            Slider(value: $sliderThreeValue, in:2.0...10.0)
            
            Text("We <3 Math").padding();
            Image("bcnp").padding(1);
            
        }
        
    }
    func getSliderOneValue() ->Double{
        return sliderOneValue
        
        
    }
    func getSliderTwoValue() ->Double{
        return sliderTwoValue
    }
    func getSliderThreeValue() ->Int{
        return Int(sliderThreeValue.rounded())
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
        var Xcoordinate:Double
        var Ycoordinate:Double
        var coordinate:(Double,Double)
        for indexCoordinate in 0...newCoordinates.count-1{
            coordinate = newCoordinates[indexCoordinate];
            Xcoordinate=coordinate.0;
            Ycoordinate=coordinate.1;
            newCoordinates[indexCoordinate]=getUpdatedValues(x:Xcoordinate, y:Ycoordinate);
            if( (Xcoordinate*Xcoordinate + Ycoordinate*Ycoordinate) > 4 ){
                inSetCoordinate[indexCoordinate]=false;
            }
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
