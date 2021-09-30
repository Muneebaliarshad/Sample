//
//  Double.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation


extension Double{
    
    var cleanValue: String{
        //return String(format: 1 == floor(self) ? "%.0f" : "%.2f", self)
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.0f", self)//
    }
    
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
    
}
