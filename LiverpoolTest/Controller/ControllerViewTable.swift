//
//  ControllerViewTable.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation
import UIKit
class ControllerViewTable {
    var arrayRecord: [ModelCell] = []
    func callProducts(parametro: String, page: String, total: String, completion: @escaping (_ result: [ModelCell]?, _ error: String?) -> Void) {
        
        Networking.init().getRequest(parametro: parametro, page: page, total: total) { (result, error) in
            
            if error != nil {
                completion(nil, error!)
            }
            else {
                
                let records = result?.plpResults?.records
                let semaphore = DispatchSemaphore(value: 1)
                for record in records! {
                    DispatchQueue.main.async {
                        semaphore.wait()
                        Networking.init().downloadImage(url: record.smImage) { [weak self](img, error) in
                            if img != nil {
                                print(record)
                                
                                self?.arrayRecord.append(ModelCell(titulo: record.productDisplayName, precio: String(record.listPrice), ubicacion: record.seller, image: ((UIImage(data: img!) ?? UIImage(named: "liverpool"))!)))
                                semaphore.signal()
                            } else {completion(nil, error)}
                        }
                        completion(self.arrayRecord, nil)
                    }
                    
                    
                }
                
            }
            
            
        }
        
        
        
    }
}
