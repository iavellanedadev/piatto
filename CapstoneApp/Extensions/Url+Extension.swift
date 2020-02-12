//
//  Url+Extension.swift
//  CapstoneApp
//
//  Created by Consultant on 1/28/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation
import UIKit

extension URL
{
    func getImage(completion: @escaping (UIImage?) -> Void)
    {
        URLSession.shared.dataTask(with: self) { (dat, _, _) in
            if let data = dat{
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
            
        }.resume()
    }
}
