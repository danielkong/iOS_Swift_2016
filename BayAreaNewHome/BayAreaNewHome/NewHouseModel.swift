//
//  NewHouseModel.swift
//  BayAreaNewHome
//
//  Created by Daniel Kong on 5/30/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//
/*
     ▿ Optional<XMLElement>
     ▿ Some : <tr>
        <td align="left" valign="top">
        <div class="small">
     <img src="/images/spacer.gif" width="12" height="12" border="0"/>
        </div>
        </td>
        
        <td align="left" valign="top">
     <div class="small">
     <a href="/home_finder/d/brookfield_residential/capri_at_jordan_ranch" class="blue">
     Capri at Jordan Ranch			</a>
     </div>
        </td>
        <td align="left" valign="top"><div class="small">Single Family HomesBrookfield Residential </div></td>
        <td align="left" valign="top"><div class="small">Dublin</div></td>
        <td align="left" valign="top"><div class="small">
     
     4</div></td>
     <td align="right" valign="top"><div class="small">From the mid&amp;nbsp
     $900,000</div></td>
     </tr>
 */
import Foundation
import Fuzi

public class NewHouseModel: NSObject {
    public var communityName: String?
    public var type: String?
    public var builderName: String?
    public var cityName: String?
    public var bedsName: String?
    public var startingPrices: String?
    
    public var link: String?
//    public var cityList: [CityModel] = []
    
    public init(element: XMLElement?) {
        guard let house = element else {
            return
        }
        
        if house.children.count == 6 {
            let rawCommunityName = house.children[1].stringValue
            
            communityName = rawCommunityName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
 // "\n\t\t\n\t\t\t\nBarnwell\t\t\t\n\t\t\n\t"
            builderName = house.children[2].stringValue
            cityName = house.children[3].stringValue
            bedsName = house.children[4].stringValue // "\n\n4 - 5"
            startingPrices = house.children[5].stringValue // "Now Open!           &nbsp\nn/a"
            
        }

//
//        if let tagULArray: [XMLElement] = element.children(tag: "ul") where tagULArray.count > 0 {
//            if let child: [XMLElement] = tagULArray[0].children where tagULArray[0].children.count > 0 {
//                for i in 0..<child.count {
//                    let cityModel = CityModel(element: child[i])
//                    cityList.append(cityModel)
//                }
//            }
//        }
    }
}
