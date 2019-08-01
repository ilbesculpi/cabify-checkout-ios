//
//  Environment.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/31/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import Foundation

enum Environment {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let environment = "APP_ENVIRONMENT"
            static let serverUrl = "SERVER_URL"
            static let containerName = "APP_CONTAINER"
            static let currencySymbol = "APP_CURRENCY_SYMBOL"
        }
    }
    
    
    // MARK: - Plist
    
    /** Access the Plist Config file. */
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    /** Access APP_ENVIRONMENT from Plist Config file. */
    static let environment: String = {
        guard let env = Environment.infoDictionary["APP_ENVIRONMENT"] as? String else {
            fatalError("App Environment not set in plist for this environment");
        }
        return env
    }()
    
    /** Access SERVER_URL from Plist Config file. */
    static let serverUrl: URL = {
        guard let rootURLstring = Environment.infoDictionary["SERVER_URL"] as? String else {
            fatalError("Server URL not set in plist for this environment");
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Invalid Server URL");
        }
        return url;
    }()
    
    /** Access APP_CONTAINER from Plist Config file. */
    static let containerName: String = {
        guard let container = Environment.infoDictionary["APP_CONTAINER"] as? String else {
            fatalError("App Container not set in plist for this environment");
        }
        return container
    }()
    
    /** Access APP_CONTAINER from Plist Config file. */
    static let currencySymbol: String = {
        guard let currency = Environment.infoDictionary["APP_CURRENCY_SYMBOL"] as? String else {
            print("[WARN] Currency Symbol not set in plist for this environment. Fallback to '$'");
            return "$"
        }
        return currency
    }()
    
    
}
