//
//  UserDefults.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation


enum UserDefaultsKeys: String {
   
    case searchs
   
}

extension UserDefaults {
  
    
    static func isFirstLaunch() -> Bool {
          let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
          let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
          if (isFirstLaunch) {
              UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
              UserDefaults.standard.synchronize()
          }
          return isFirstLaunch
      }
    func saveData(value: String, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func saveObject(value: Data, key: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func delete(key: String) {
         removeObject(forKey: key)
         synchronize()
        
    }
    
   
   
    
  
    
}
