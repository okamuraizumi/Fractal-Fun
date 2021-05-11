//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var sliderThreeValue=10.0
    @State var alertIsVisible=false
    @State var numOfPoints=10
    @State var coordinates = [(Double, Double)]()
    @State var newCoordinates = [(Double, Double)]()
    @State var inSetCoordinate = [Bool]()
    @State var colorCoordinates = [UInt32]()
    
    
    init(){
        fillPointsArray(xLower: -2.0, xUpper: 2.0, xInNum: numOfPoints, yLower: -2.0, yUpper: 2.0, yInNum: numOfPoints)
        
    }
    
    var body: some View {
                
        
        VStack() {
            Button(action: {self.alertIsVisible = true;
                    numOfPoints=getSliderThreeValue();
                    coordinates = [(Double, Double)]();
                    newCoordinates = [(Double, Double)]();
                    inSetCoordinate = [Bool]();
                    fillPointsArray(xLower: -2, xUpper: 2, xInNum: numOfPoints, yLower: -2, yUpper: 2, yInNum: numOfPoints);
                
            }) {
                Text("Initialize")
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(title: Text("FRACTAL"),
                             message: Text("numOfPoints value is \(numOfPoints)")
                )
            }
            
            Button(action: {
                    updateCoordinates();

            }) {
                Text("Iterate")
            }

            
            Slider(value: $sliderThreeValue, in:10.0...100.0)
            
            Text("We <3 Math\(numOfPoints)").padding();
            
            var imageCreated = makeImageWithColor(colorCoordinates, numOfPoints: numOfPoints);
            Image(uiImage:imageCreated);
              
        }
       
    }
    
    func getSliderThreeValue() ->Int{
        return Int(sliderThreeValue.rounded());
    }
    
    func fillPointsArray(xLower:Double, xUpper:Double, xInNum:Int, yLower:Double, yUpper:Double, yInNum:Int) {
        var xCoor:Double
        var yCoor:Double
        let xIncrement=(xUpper-xLower)/Double(xInNum-1)
        let yIncrement=(yUpper-yLower)/Double(yInNum-1)
        for indY in 0...yInNum-1 {
            for indX in 0...xInNum-1{
                xCoor=xLower+Double(indX)*xIncrement;
                yCoor=yLower+Double(indY)*yIncrement;
                coordinates.append((xCoor,yCoor));
                newCoordinates.append((xCoor,yCoor));
                inSetCoordinate.append(true);
                colorCoordinates.append(0xFF8803fc);
            }
        }
        
    }
    func updateCoordinates(){
        var Xcoordinate:Double
        var Ycoordinate:Double
        var coordinate:(Double,Double)
        var newCoordinate: (Double,Double)
        var newPoints:(Double,Double)
        var newXcoordinate:Double
        var newYcoordinate:Double
        for indexCoordinate in 0...newCoordinates.count-1{
           newCoordinate = newCoordinates[indexCoordinate];
           coordinate = coordinates[indexCoordinate];
            Xcoordinate=newCoordinate.0;
            Ycoordinate=newCoordinate.1;
            newPoints = getUpdatedValues(x:Xcoordinate, y:Ycoordinate);
            newXcoordinate = newPoints.0 + coordinate.0;
            newYcoordinate = newPoints.1 + coordinate.1;
            newCoordinates[indexCoordinate]=(newXcoordinate,newYcoordinate);
            if( (newXcoordinate*newXcoordinate + newYcoordinate*newYcoordinate) > 4 ){
                inSetCoordinate[indexCoordinate]=false;
                colorCoordinates[indexCoordinate]=0xFFfcba03;
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


func getColor (pixelValue:Bool) -> UIColor{
    if (pixelValue){
        return .blue
    }
    else{
        return .red
    }
}

func makeImageWithColor(_ colors: [UInt32], numOfPoints: Int) -> UIImage {
    var colorsArray = colors;
        
    let cgImg = colorsArray.withUnsafeMutableBytes { (ptr) -> CGImage in
        let ctx = CGContext(
            data: ptr.baseAddress,
            width: numOfPoints,
            height: numOfPoints,
            bitsPerComponent: 8,
            bytesPerRow: 4*numOfPoints,
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue + CGImageAlphaInfo.premultipliedFirst.rawValue
        )!
        return ctx.makeImage()!
    }
    return UIImage(cgImage:cgImg);
}
