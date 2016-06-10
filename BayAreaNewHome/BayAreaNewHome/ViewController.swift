///
//  ViewController.swift
//  BayAreaNewHome
//
//  Created by Daniel Kong on 5/1/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit
import Fuzi
//import AsyncDisplayKit
import Alamofire

private let kTableViewCell = "tableViewCell"

class ViewController: UIViewController {
    var tableCount: Int = 0
    var rootCityOrCountyModel: CityModel?
    var newHouseModel: NewHouseModel?
    var tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(model: CityModel) {
        self.rootCityOrCountyModel = model
        super.init(nibName:nil, bundle: nil)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init(_ coder: NSCoder? = nil) {
        self.rootCityOrCountyModel = nil
        
        if let coder = coder {
            super.init(coder: coder)!
        }
        else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        // super.encodeWithCoder(aCoder) is optional, see notes below
        aCoder.encodeObject(self.rootCityOrCountyModel, forKey: "rootModel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightTextColor()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // first page, initial loading
        if self.rootCityOrCountyModel == nil {
            // list: http://www.newhomesmag.com/home_finder/index_city.php
            // map: http://www.newhomesmag.com/home_finder/index.php
            Alamofire.request(.GET, "http://www.newhomesmag.com/home_finder/index_city.php").responseJSON { response in
                let html = String(data: response.data!, encoding: NSUTF8StringEncoding) ?? ""
                do {
                    // if encoding is omitted, it defaults to NSUTF8StringEncoding
                    let doc = try HTMLDocument(string: html, encoding: NSUTF8StringEncoding)
                    
                    for element in doc.xpath("//div") {
                        if element.attr("style") == "color:#000000; font-family: Arial, Helvetica; font-size: 12px; text-decoration:none;" {
                            self.rootCityOrCountyModel = CityModel.init(element: element)
                            
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.tableView.reloadData()
                    }
//                    self.tableView.reloadData()
                    
                } catch let error {
                    print(error)
                }
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
        }
        
        // get builder list, no sub cities,
        else if rootCityOrCountyModel?.cityList.count == 0 && rootCityOrCountyModel?.newHouseList.count == 0 {
            // http://www.newhomesmag.com/home_finder/alameda/dublin/0/0/
            let builderUri = "http://www.newhomesmag.com" + (rootCityOrCountyModel?.link)!
            Alamofire.request(.GET, builderUri).responseJSON { response in
                let html = String(data: response.data!, encoding: NSUTF8StringEncoding) ?? ""
                do {
                    // if encoding is omitted, it defaults to NSUTF8StringEncoding
                    let doc = try HTMLDocument(string: html, encoding: NSUTF8StringEncoding)
                    
                    for element in doc.xpath("//tr") { // tr
                        // get leaf node
                        if element.children.count == 2 {
                            if let xmlElement: XMLElement = element.children[1] {
                                let doc2 = try HTMLDocument(string: xmlElement.description, encoding: NSUTF8StringEncoding)
                                for img in doc2.xpath("//img") {
                                    if img.attr("src") == "/images/spacer.gif" && img.attr("height") == "12" && img.attr("width") == "12" {
                                        if let homeResult: XMLElement = img.parent?.parent?.parent {
                                            let newHouse = NewHouseModel.init(element: homeResult)
                                            if newHouse.communityName == "Barnwell" {
                                                NSLog("stop")
                                            }
                                            self.rootCityOrCountyModel!.newHouseList.append(newHouse)
//                                            if let index = self.rootCityOrCountyModel!.newHouseList.indexOf(newHouse) where index < self.roo {
//                                                self.rootCityOrCountyModel!.newHouseList.append(newHouse)
//                                            }
                                        }

                                    }
                                }
                            }
                        }
                        // fatal error: Index out of range
//                        if let xmlElement: XMLElement = element.children[1] where element.children.count == 2 {
//                            NSLog("here")
//                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.tableView.reloadData()
                    }
//                    self.tableView.reloadData()
                    
                } catch let error {
                    print(error)
                }
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
        }

    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let newRootModel = rootCityOrCountyModel?.cityList[indexPath.row] {
//        self.rootModel = newRootModel
//        tableView.reloadData()
            let newVC = ViewController(model: newRootModel)
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = rootCityOrCountyModel else {
            return 0
        }
        if model.cityList.count == 0 && model.newHouseList.count > 0 {
            return model.newHouseList.count
        }
        return model.cityList.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCell, forIndexPath: indexPath)
        
        if self.rootCityOrCountyModel!.cityList.count == 0 && self.rootCityOrCountyModel!.newHouseList.count > 0 {
            cell.textLabel!.text = rootCityOrCountyModel?.newHouseList[indexPath.row].communityName

        } else {
            cell.textLabel!.text = rootCityOrCountyModel?.cityList[indexPath.row].countyName

        }
        
        
        return cell
    }


}
