//
//  Modeldata.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 05/05/23.
//

import Foundation

struct Modeldata<DataType> where DataType: Decodable {
    var list:  [DataType]
    
    init(fileName: String) {
        list = [DataType]()
        
        if let data: Data = fetchJsonFile(filename: fileName){
            
            let decoder = JSONDecoder()
            
            
            do {
                list = try decoder.decode([DataType].self, from: data)
                
            } catch {
                fatalError("Error parsing \(fileName) as \([DataType].self): \(error)")
            }
        } else {
            let fileName2 = fileName + ".json"
            
            guard let file = Bundle.main.url(forResource: fileName2, withExtension: nil)
            else { fatalError("File \(fileName2) not found")}
            
            let decoder = JSONDecoder()
            
            let data: Data
            
            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("\(fileName2) not loaded: \(error)")
            }
            do {
                list = try decoder.decode([DataType].self, from: data)
                
            } catch {
                fatalError("Error parsing \(fileName2) as \([DataType].self): \(error)")
            }
        }
        
    }
    
    func fetchJsonFile(filename: String) -> Data? {
        let urlString = "http://localhost:3000/\(filename)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var responseData: Data?
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { semaphore.signal() }
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
                print("File not found")
                return
            }
            
            responseData = data
        }
        
        task.resume()
        semaphore.wait()
        
        return responseData
    }
    
}

