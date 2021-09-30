//
//  CGFloat.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
