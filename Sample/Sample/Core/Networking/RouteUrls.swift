//
//  RouteUrls.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//


let kBaseURL = ""
let kImageBaseURL = ""


enum Route: String {
    
    //MARK: - User
    case Login = "/users/login"
    
    
    func url() -> String{
        return kBaseURL + self.rawValue
    }
}
