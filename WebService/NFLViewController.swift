//
//  ContentView.swift
//  WebService
//
//  Created by Dayton Steffeny on 11/15/19.
//  Copyright © 2019 Dayton Steffeny. All rights reserved.
//

import SwiftUI
import UIKit

class NFLViewController: UITableViewController {
    
    var standings: [standing]?
    let jsonURL = "https://api.nfl.com/docs/league/models/json/standings.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJson(nflHandler: { NFLArray, error in
            if let NFLArray = NFLArray {
                self.standings = NFLArray
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func loadJson(nflHandler: @escaping ([standing]?, Error?) -> Void) {
        guard let url = URL(string: jsonURL) else {
            print("Error: Bad URL")
            return
        }
        
        var NFLArray = [standing]()
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
            
            if let root = jsonResponse as? [String: Any] {
                if let feed = root["feed"] as? [String: Any] {
                    if let results = feed["results"] as? [Dictionary<String, Any>] {
                        for item in results {
                            NFLArray.append(standing(item))
                        }
                        
                        nflHandler(NFLArray, nil)
                    }
                }
            }
            
            
        })
        
        task.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings?.count ?? 0
    }
    

}

