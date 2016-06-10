//
//  CityModel.swift
//  BayAreaNewHome
//
//  Created by Daniel Kong on 5/4/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import Foundation
import Fuzi

public class CityModel: NSObject {
    public var countyName: String?
    public var link: String?
    public var cityList: [CityModel] = []
    public var newHouseList: [NewHouseModel] = []

    public init(element: XMLElement?) {
        guard let element = element else {
            return
        }
        
        if let tagAArr: [XMLElement] = element.children(tag: "a") where tagAArr.count > 0 {
            if let pair: [String: String] = tagAArr[0].attributes {
                link = pair["href"] ?? ""
            }
            countyName = tagAArr[0].stringValue ?? "All"
        }
        
        if let tagULArray: [XMLElement] = element.children(tag: "ul") where tagULArray.count > 0 {
            if let child: [XMLElement] = tagULArray[0].children where tagULArray[0].children.count > 0 {
                for i in 0..<child.count {
                    let cityModel = CityModel(element: child[i])
                    cityList.append(cityModel)
                }
            }
        }
    }
}
