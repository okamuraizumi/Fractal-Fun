//
//  ImageManager.swift
//  Fractal Fun
//
//  Created by Orenda Williams on 6/7/21.
//

import Foundation
import SwiftUI


class FractalImage {
    
    let height:Int;
    let width:Int;
    var xRange:(Double,Double);
    var yRange:(Double,Double);
    var coordinates = [(Double, Double)]();
    var newCoordinates = [(Double, Double)]();
    var inSetCoordinate = [Bool]();
    var colorCoordinates = [UInt32]();
    var count = 0;

    
    init(height:Int=500, width:Int=500, xRange:(Double,Double)=(-2, 2), yRange:(Double,Double)=(-2,2)){
        self.height = height;
        self.width = width;
        self.xRange = xRange;
        self.yRange = yRange;
        fillPointsArray(xLower: xRange.0, xUpper: xRange.1, xInNum: width, yLower: yRange.0, yUpper: yRange.1, yInNum: height);
        
    }
    
    func getUpdatedValues(x:Double,y:Double)-> (x_new:Double,y_new:Double) {
       let x_new=(x*x-y*y)
       let y_new=(2*x*y)
        return (x_new, y_new)

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
    
    func makeImageWithColor() -> UIImage {
            
        let cgImg = self.colorCoordinates.withUnsafeMutableBytes { (ptr) -> CGImage in
            let ctx = CGContext(
                data: ptr.baseAddress,
                width: self.width,
                height: self.height,
                bitsPerComponent: 8,
                bytesPerRow: 4*self.width,
                space: CGColorSpace(name: CGColorSpace.sRGB)!,
                bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue + CGImageAlphaInfo.premultipliedFirst.rawValue
            )!
            return ctx.makeImage()!
        }
        return UIImage(cgImage:cgImg);
    }
    
    
    func updateCoordinates(){
        var Xcoordinate:Double
        var Ycoordinate:Double
        var coordinate:(Double,Double)
        var newCoordinate: (Double,Double)
        var newPoints:(Double,Double)
        var newXcoordinate:Double
        var newYcoordinate:Double
        var currentColor: UInt32
        if (count==0){
            currentColor=0xFFfcba03;
        }
        else {
            currentColor=0xFF3464eb;
        }
        count = (count + 1) % 2;
        for indexCoordinate in 0...newCoordinates.count-1{
            if (inSetCoordinate[indexCoordinate] == false) {
                continue
            };
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
                colorCoordinates[indexCoordinate]=currentColor;
            }
        }
    }
}



