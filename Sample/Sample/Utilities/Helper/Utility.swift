//
//  Utility.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit
import Alamofire


class Utility : NSObject {
    
    final class func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    final class func shareData(_ stringURL: String) {
        let myWebsite = NSURL(string: stringURL)
        guard let url = myWebsite else {
            print("nothing found")
            return
        }
        
        let shareItems:Array = [url] as [Any]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems as [Any], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        UIApplication.getTopViewController()?.present(activityViewController, animated: true, completion: nil)
    }
    
}
