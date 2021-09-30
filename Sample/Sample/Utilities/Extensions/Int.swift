//
//  Int.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation

extension Int {

   var toTimeString: String {
       let h = self / 3600
       let m = (self % 3600) / 60
       let s = (self % 3600) % 60
       return h > 0 ? String(format: "%02d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
   }

   static func random (lower: Int , upper: Int) -> Int {
       return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
   }

}
