//
//  Utils.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 25/4/24.
//

import Foundation

class Utils{
    class func saveFileToLocal(_ image: UIImage, fileName: String) -> URL{
        let directoryPath =  try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let urlString: NSURL = directoryPath.appendingPathComponent(fileName) as NSURL
        print("Image path : \(urlString)")
        if !FileManager.default.fileExists(atPath: urlString.path!) {
            do {
                try image.jpegData(compressionQuality: 1.0)!.write(to: urlString as URL)
                    print ("Image Added Successfully")
            } catch {
                    print ("Image Not added")
            }
        }
        return urlString as URL
    }
}
