//
//  Utils.swift
//  xverifydemoapp
//
//  Created by Minh Tri on 30/11/2023.
//

import UIKit

class Utils {
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    class func saveFileToLocal(_ image: UIImage, fileName: String) -> URL {
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
    
    class func removeFileFromLocal(fileUrl: URL) {
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
            } catch {
                Log.debug("Could not delete file, probably read-only filesystem")
            }
        }
    }
}

// MARK: - Constants
enum Constant {
  static let videoDataOutputQueueLabel = "vn.jth.xverifydemoapp.VideoDataOutputQueue"
  static let sessionQueueLabel = "vn.jth.xverifydemoapp.SessionQueue"
}

