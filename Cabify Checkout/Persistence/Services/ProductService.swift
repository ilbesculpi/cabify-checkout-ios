//
//  ProductService.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/27/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation
import Alamofire
import Promises

class ProductService: ProductRepository {
    
    let baseUrl: String = "https://api.myjson.com/bins";
    
    func fetchProducts() -> Promise<[Product]> {
        
        let promise = Promise<[Product]> { (resolve, reject) in
            
            let fetchUrl = "\(self.baseUrl)/4bwec";
            
            AF.request(fetchUrl).responseJSON { (response) in
                
                guard let json = response.value as? [String : Any] else {
                    // Handle invalid response error
                    print("[ERROR] invalid response");
                    reject(ServiceError.invalidResponse);
                    return;
                }
                
                guard let array = json["products"] as? [[String : Any]] else {
                    // Handle invalid response error
                    print("[ERROR] response doesn't contain 'products' entry");
                    reject(ServiceError.invalidResponse);
                    return;
                }
                
                //print("[DEBUG] response array: \(json)");
                do {
                    let products = try Product.list(json: array);
                    resolve(products);
                }
                catch {
                    // TODO: handle parsing error
                    print("[ERROR] parsing error: \(error.localizedDescription)");
                    reject(error);
                }
                
            }
        }
        
        return promise;
    }

}
