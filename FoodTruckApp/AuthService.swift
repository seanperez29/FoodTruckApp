//
//  AuthService.swift
//  FoodTruckApp
//
//  Created by Sean Perez on 3/22/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

class AuthService {
    var isRegistered: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Keys.DEFAULTS_REGISTERED)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.Keys.DEFAULTS_REGISTERED)
        }
    }
    var isAuthenticated: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Keys.DEFAULTS_AUTHENTICATED)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.Keys.DEFAULTS_AUTHENTICATED)
        }
    }
    var email: String? {
        get {
            return UserDefaults.standard.value(forKey: Constants.Keys.DEFAULTS_EMAIL) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.Keys.DEFAULTS_EMAIL)
        }
    }
    var authToken: String? {
        get {
            return UserDefaults.standard.value(forKey: Constants.Keys.DEFAULTS_TOKEN) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.Keys.DEFAULTS_TOKEN)
        }
    }
    
    func registerUser(email: String, password: String, completionHandler: @escaping Constants.Callbacks.callback) {
        let json = ["email": email, "password": password]
        let session = URLSession.shared
        guard let url = URL(string: Constants.URLs.POST_REGISTER_ACCOUNT) else {
            isRegistered = false
            completionHandler(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print(error)
            isRegistered = false
            completionHandler(false)
        }
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                print(error!.localizedDescription)
                self.isRegistered = false
                completionHandler(false)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 || statusCode == 409 else {
                print("Returned a status code other than 2xx!")
                self.isRegistered = false
                completionHandler(false)
                return
            }
            self.isRegistered = true
            completionHandler(true)
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func login(email username: String, password: String, completionHandler: @escaping Constants.Callbacks.callback) {
        let json = ["email": username, "password": password]
        let session = URLSession.shared
        guard let url = URL(string: Constants.URLs.POST_LOGIN_ACCOUNT) else {
            isAuthenticated = false
            completionHandler(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print(error)
            completionHandler(false)
            return
        }
        let task = session.dataTask(with: request) { (data, response, error) in
            guard (error == nil) else {
                print(error!.localizedDescription)
                self.isAuthenticated = false
                completionHandler(false)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                print("Returned a status code other than 2xx!")
                self.isAuthenticated = false
                completionHandler(false)
                return
            }
            guard let data = data else {
                print("Unable to obtain data")
                self.isAuthenticated = true
                completionHandler(false)
                return
            }
            let parsedResult: AnyObject
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                print(error)
                self.isAuthenticated = false
                completionHandler(false)
                return
            }
            guard let email = parsedResult["user"] as? String else {
                print("Unable to obtain key 'user' from results")
                self.isAuthenticated = false
                completionHandler(false)
                return
            }
            guard let token = parsedResult["token"] as? String else {
                print("Unable to obtain key 'token' from results")
                self.isAuthenticated = false
                completionHandler(false)
                return
            }
            self.email = email
            self.authToken = token
            self.isAuthenticated = true
            completionHandler(true)
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    static let sharedInstance = AuthService()
}
