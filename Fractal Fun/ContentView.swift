//
//  ContentView.swift
//  Fractal Fun
//
//  Created by Izumi Okamura on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible=false
    @State var numOfPoints=10
    @State var fractalImage=FractalImage();
    @State var imageCreated=UIImage();
    
    init(){
        imageCreated = fractalImage.makeImageWithColor();
    }
    
    var body: some View {
                
        
        VStack() {
            
            Button(action: {
                fractalImage.updateCoordinates();
                imageCreated=fractalImage.makeImageWithColor();
//                Image(uiImage:imageCreated);

            }) {
                Text("Iterate")
            }
            
            Text("We <3 Math\(numOfPoints)").padding();
            
            Image(uiImage:imageCreated);
              
        }
       
    }
    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}


