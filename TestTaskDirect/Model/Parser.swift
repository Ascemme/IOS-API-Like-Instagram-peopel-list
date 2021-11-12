//
//  Parser.swift
//  TestTaskDirect
//
//  Created by Temur on 11/11/2021.
//


//MARK: - Creating JSON parser for Updating cell


import Foundation
import UIKit

struct Parser{
    func parse(completed: @escaping ([UserModel]) ->()){
        guard let url = URL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users") else{ return }
        let session = URLSession.shared
        session.dataTask(with: url) {( data, response, error) in
            
        if error == nil{
            
            do{
                //print (try JSONSerialization.jsonObject(with: data!, options: []))
                let json = try JSONDecoder().decode(Items.self, from: data!)
                //print(json)
                
                DispatchQueue.main.async {
                    completed(json.items)
                }
                    
            }catch{
                print(error)
            }
        }
        
        
        }.resume()
    }
    
    
}
