//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI


//var increment=1.0

struct Square: Shape {
    
    var coordinate: (Double,Double)
    var scale: CGFloat
    var color: Color
    //var inSetCoordinate = [false,true,true,true,true,true,true,true,false];
//
//    mutating func updatePoints(_ newInSetCoordinate:[Bool], _ newCoordinates:[(Double, Double)]){
//        inSetCoordinate =  newInSetCoordinate;
//        coordinates = newCoordinates;
//    }
//
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let Xcoordinate=coordinate.0;
        let Ycoordinate=coordinate.1;
        let rectangle=CGRect(x:CGFloat(Xcoordinate), y:CGFloat(Ycoordinate), width: scale, height: scale);
        path.addRect(rectangle);
     
////        let rotations = 5
////        let amount = .pi / CGFloat(rotations)
////        let transform = CGAffineTransform(rotationAngle: amount)
//
//        for i in 0...(inSetCoordinate.count-1){
//            let color=getColor(pixelValue:inSetCoordinate[i]);
//            color.set();
//            let coordinate = coordinates[i];
//            let Xcoordinate=coordinate.0*20;
//            let Ycoordinate=coordinate.1*20;
//            let rectangle=CGRect(x:CGFloat(Xcoordinate), y:CGFloat(Ycoordinate), width: 20, height: 20);
//            path.addRect(rectangle);
//
//        }
//
////        for _ in 0 ..< rotations {
////            path = path.applying(transform)
////
////            path.addRect(CGRect(x: -rect.width / 2, y: -rect.height / 2, width: rect.width, height: rect.height))
////        }
//
        return path
    }
    
}


struct BagOSquares: View {
    var scale: CGFloat = 50
    var rows: [GridItem] =
        Array(repeating: .init(.flexible(minimum: 50), spacing: 0.0, alignment: .topLeading), count: 3)
    
    var body: some View {
        let square = Square(coordinate: (0,0), scale: scale, color: .red);
        let square2 = Square(coordinate: (0,0), scale: scale, color: .blue);
        let square3 = Square(coordinate: (0,0),scale: scale, color: .purple);
        let square4 = Square(coordinate: (0,0), scale: scale, color: .yellow);
        let square5 = Square(coordinate: (0,0),scale: scale, color: .green);
        let square6 = Square(coordinate: (0,0), scale: scale, color: .black);
        LazyVGrid(columns: rows, alignment: .leading, spacing: 0.0 ) {
        
            square.fill(square.color).padding(0.0)
            square2.fill(square2.color).padding(0.0)
            square3.fill(square3.color).padding(0.0)
            square4.fill(square4.color).padding(0.0)
            square5.fill(square5.color).padding(0.0)
            square6.fill(square6.color).padding(0.0)
        }
    

    }
    
   
//    //@State var coordinates = [(Double, Double)]();
//    //@State var inSetCoordinate = [Bool]();
//
//    //func updatePoints(newInSetCoordinate:[Bool], newCoordinates:[(Double, Double)]){
//        _//inSetCoordinate = State(initialValue: newInSetCoordinate);
//        _//coordinates = State(initialValue: newCoordinates);
////    }
}

struct ContentView: View {
    @State var sliderOneValue=1.0

    @State var sliderTwoValue=1.0
    @State var sliderThreeValue=10.0
    
    @State var alertIsVisible=false
    
    @State var x=0.0
    @State var y=0.0
    @State var numOfPoints=10
    @State var xNew=0.0
    @State var yNew=0.0
    
    
    @State var coordinates = [(Double, Double)]()
    @State var newCoordinates = [(Double, Double)]()
    @State var inSetCoordinate = [Bool]()
    @State var colorCoordinates = [UInt32]()
    
    
    @State var bagOSquares=BagOSquares()
    
    init(){
        fillPointsArray(xLower: -2.0, xUpper: 2.0, xInNum: numOfPoints, yLower: -2.0, yUpper: 2.0, yInNum: numOfPoints)
        
    }
    
    var body: some View {
                
        
        VStack() {
            Button(action: {self.alertIsVisible = true;
                    x=getSliderOneValue();
                    y=getSliderTwoValue();
                    numOfPoints=getSliderThreeValue();
                    coordinates = [(Double, Double)]();
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
//                spiroSquare.spiroSquare.updatePoints(inSetCoordinate, newCoordinates)
//                self.view
//                self.viewToReload.layoutIfNeeded()
//                    print(newCoordinates);
//                    print(inSetCoordinate);
            }) {
                Text("New Values")
            }

            Slider(value: $sliderOneValue, in:1.0...3.0)
            Slider(value: $sliderTwoValue, in:1.0...3.0)
            Slider(value: $sliderThreeValue, in:10.0...100.0)
            
            Text("We <3 Math\(numOfPoints)").padding();
            
            var imageCreated = makeImageWithColor(colorCoordinates, numOfPoints: numOfPoints);
            Image(uiImage:imageCreated);
//            UIImage(imageCreated);
//            let imageView = UIImageView(image: imageCreated);
//            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
//            self.view.addSubview(imageView);
//            bagOSquares.frame(width:50, height: 50)
            
//            bagOSquares.square
//                 //.stroke()
//                .fill(bagOSquares.s               quare.color)
//
//
//
//             bagOSquares.square2
//                  //.stroke()
//              .fill(bagOSquares.square2.color)
              
              
        
        }
       
    }
    
    func getSliderOneValue() ->Double{
        return sliderOneValue;
    }
    
    func getSliderTwoValue() ->Double{
        return sliderTwoValue;
    }
    
    func getSliderThreeValue() ->Int{
        return Int(sliderThreeValue.rounded());
    }
    
    func fillPointsArray(xLower:Double, xUpper:Double, xInNum:Int, yLower:Double, yUpper:Double, yInNum:Int) {
        var xCoor:Double
        var yCoor:Double
        let xIncrement=(xUpper-xLower)/Double(xInNum-1)
        let yIncrement=(yUpper-yLower)/Double(yInNum-1)
        for indX in 0...xInNum-1 {
            for indY in 0...yInNum-1{
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
        var newPoints:(Double,Double)
        var newXcoordinate:Double
        var newYcoordinate:Double
        for indexCoordinate in 0...newCoordinates.count-1{
            coordinate = newCoordinates[indexCoordinate];
            Xcoordinate=coordinate.0;
            Ycoordinate=coordinate.1;
            newPoints = getUpdatedValues(x:Xcoordinate, y:Ycoordinate);
            newXcoordinate = newPoints.0;
            newYcoordinate = newPoints.1;
            newCoordinates[indexCoordinate]=newPoints;
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
//    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//    UIGraphicsBeginImageContextWithOptions(size, false, 0)
//    color.setFill()
//    UIRectFill(rect)
//    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//    UIGraphicsEndImageContext()
//    return image)
    
//    var srgbArray = [UInt32](repeating: 0xFFfcba03, count: 100)
//
//    for index in 1...50{
//        srgbArray.append(contentsOf: [UInt32](repeating: 0xFF8803fc, count:100));
//        srgbArray.append(contentsOf: [UInt32](repeating: 0xFFfcba03, count:100));
//    }
    
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

//func getChartPointArray(xMin:Double,xMax:Double,yMin:Double,yMax:Double,increment:Double)-> (Array<Array<Double>>){}

