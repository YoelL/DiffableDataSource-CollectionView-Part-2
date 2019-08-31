//
//  NetworkService.swift
//  DiffableDataSource CollectionView
//
//  Created by Yoel Lev on 31/08/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    
    private let urlString = "https://demo-profiles.s3.eu-west-2.amazonaws.com/profileDemo.json"
    
    func downloadContactsFromServer(completion: @escaping (Bool,[Contact]) -> Void ) {
        var contacts = [Contact]()
        print("---------------------------------")
        print("Attempting to download contacts..")
        print("---------------------------------")
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("---------------------------------")
                print("Failed to download contacts:",err)
                print("---------------------------------")
                completion(false,[])
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            
            do {

                let jsonContacts = try jsonDecoder.decode([JSONContact].self, from: data)
 
                jsonContacts.forEach({ (jsonContact) in
                    contacts.append(Contact(name: jsonContact.name, image: jsonContact.imageUrl))
                    print(jsonContact.name)
                    print(jsonContact.imageUrl)
                })
                
            } catch let jsonDecodeErr {
                print("-------------------------------------------")
                print("Failed to decode with error:", jsonDecodeErr)
                print("-------------------------------------------")
                completion(false,[])
            }
            print("-----------------------")
            print("Finished downloading...")
            print("-----------------------")
            completion(true,contacts)
            
            }.resume()
    }
    
}
