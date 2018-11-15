//
//  ViewController.swift
//  Weather_Shortcut(API)
//
//  Created by pankaj vats on 15/11/18.
//  Copyright © 2018 pankaj vats. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
//    var array1 = ["1","1","1","1","1"]
    var arr_Temp = [String]()
    var arr_min = [String]()
    var arr_max = [String]()
    var arr_Humidity = [String]()
    var arr_clouds = [String]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let url = "https://samples.openweathermap.org/data/2.5/forecast?q=Delhi,DE&appid=b6907d289e10d714a6e88b30761fae22&#8221"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadJsonWithURL()
        
    }
    
    func downloadJsonWithURL()
    {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON
            {
                response in
                let data = response.result.value
                let allData = data as! NSDictionary
                
                //            print(allData)
                
                let aaa = allData.value(forKey: "list") as! NSArray
                //            print(aaa)
                
                for LISTS in aaa
                {
                    if let list = LISTS as? NSDictionary
                    {
                        
                        if let MAIN = list.value(forKey: "main") as? NSDictionary
                        {
                            
                            if let TEMP = MAIN.value(forKey: "temp") as? Double
                            {
                                self.arr_Temp.append(String(TEMP))
                            }
                            
                            
                            if let Temp_min = MAIN.value(forKey: "temp_min") as? Double
                            {
                                self.arr_min.append(String(Temp_min))
                            }
                            
                            if let Temp_max = MAIN.value(forKey: "temp_max") as? Double
                            {
                                self.arr_max.append(String(Temp_max))
                            }
                            
                            if let Humidity = MAIN.value(forKey: "humidity") as? Int
                            {
                                self.arr_Humidity.append(String(Humidity))
                            }
                        }
                        
                        
                        if let CLOUDS = list.value(forKey: "clouds") as? NSDictionary
                        {
                            if let all_clouds = CLOUDS.value(forKey: "all") as? Int
                            {
                            self.arr_clouds.append(String(all_clouds))
                            }
                        }
                        
                    }
                }
                
                
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
                
                
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Temp.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as! CVC
        
        cell.temp_lbl.text = arr_Temp[indexPath.row]
        cell.min_lbl.text = arr_min[indexPath.row]
        cell.max_lbl.text = arr_max[indexPath.row]
        cell.humidity_lbl.text = arr_Humidity[indexPath.row]
        cell.clouds_lbl.text = arr_clouds[indexPath.row]
        
        return cell
    }
    
}

