//
//  FileServiceManager.swift
//  CapstoneApp
//
//  Created by Consultant on 2/6/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation

struct FileServiceManager
{
    static func saveFile(data: Data, isVideo: Bool)
    {
        let hash = "\(data.hashValue)"
        let path = isVideo ? hash + ".mov": hash
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path) else {return}
        do{
            try data.write(to: url)
            print("Data Saved : \(path)")
        }
        catch {
            print("Couldn't Save To Location: \(path)")
        }
    }
    
    static func loadFile(from path: String) -> URL?
    {
        let document = FileManager.SearchPathDirectory.documentDirectory
        let userMask = FileManager.SearchPathDomainMask.userDomainMask
        
        let paths = NSSearchPathForDirectoriesInDomains(document, userMask, true)
        
        guard let fullPath = paths.first else {return nil}
        
        return URL(fileURLWithPath: fullPath).appendingPathComponent(path)
    }
}
