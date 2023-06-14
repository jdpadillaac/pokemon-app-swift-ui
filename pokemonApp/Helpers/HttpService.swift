//
//  HttpService.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import Foundation


struct ServiceError: Error {
    let err: String
}


class AppHttpService {
    
    func getQithCallback(url: String, completion:  @escaping(Result<[String:Any], ServiceError>) -> Void)  {
        guard let url = URL(string: url) else {
            completion(.failure(ServiceError(  err: "Url error")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(ServiceError(err: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError(err:"Error en data convertion")))
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(.failure(ServiceError(err: "Error in json converison")))
                    return
                }
                
                completion(.success(json))
                return
                
            } catch let err as NSError {
                completion(.failure(ServiceError(err: "Error in http request \(err.localizedDescription)")))
                return
            }
        }
        
        task.resume()
    }
    
    
    func get(url: String)   -> Result<[String:Any], ServiceError> {
        guard let url = URL(string: url) else {
           return .failure(ServiceError(  err: "Url error"))
        }
        
        var result:Result<[String:Any], ServiceError>!
        let semaphore = DispatchSemaphore(value: 0)
        
      let task =   URLSession.shared.dataTask(with: url) { data, response, error in
          
          defer {
              semaphore.signal()
          }
            
            if let error = error {
                result = .failure(ServiceError(err: error.localizedDescription))
                return
            }
            
            guard let data = data else {
                result = .failure(ServiceError(err: "Error in data convertion"))
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    result =  .failure(ServiceError(err: "Error in json converison"))
                    return
                }
                
                result = .success(json)
                return
            } catch let err as NSError {
                result = .failure(ServiceError(err: "Error in http request \(err.localizedDescription)"))
                return
            }
        }
        
        task.resume()
        semaphore.wait()
        
        return result
    }
}
