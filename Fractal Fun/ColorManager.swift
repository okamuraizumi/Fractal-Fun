//
//  ColorManager.swift
//  Fractal Fun
//
//  Created by Orenda Williams on 6/7/21.
//

import Foundation
import SwiftUI

func getColor (pixelValue:Bool) -> UIColor{
    if (pixelValue){
        return .blue
    }
    else{
        return .red
    }
}
