//
//  DatabaseManager.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 08/11/22.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class DatabaseManager{
    var urls: [String] = []
    static let shared = DatabaseManager()
    let database = Database.database().reference(fromURL: "https://self-sightseeing-69ab7-default-rtdb.firebaseio.com/")
    private let storage = Storage.storage().reference()
    private let userdefaultsManager = UserDefaultsManager.shared
    
    func saveCoordinates(lat: Double, long: Double) {
        let object: [Double] = [
            lat,
            long
        ]
        self.database.ref.child("users").child(UIDevice.current.identifierForVendor!.uuidString).setValue(object)
    }
    
    func addImg(userName: String, imgData: UIImage, desc: String,emotion: String, lat: Double, long: Double){
        
        storage.child(UIDevice.current.identifierForVendor!.uuidString).child("\(userName).png").putData(imgData.pngData()!,
                                                                                                         metadata: nil) { _, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return}
            
            self.storage.child(UIDevice.current.identifierForVendor!.uuidString).child("\(userName).png").downloadURL { [self] urL, err in
                guard let url = urL, err == nil else {
                    print("url error")
                    return
                }
                
                let urlString = url.absoluteString
                
                urls.append(urlString)
                
                print("Image URLS: \(urls)")
                let object: [String: Any] = [
                    "device": UIDevice.current.identifierForVendor!.uuidString,
                    "imageUrls" : urls,
                    "comments" :  desc,
                    "emotion" :  emotion,
                    "latitude" : lat,
                    "longtitude" : long,
                ]
                self.database.ref.child("\(userdefaultsManager.getDataCount())").setValue(object)
            }
        }
    }
    

    
}
