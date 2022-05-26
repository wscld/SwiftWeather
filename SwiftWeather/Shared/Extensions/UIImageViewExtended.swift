//
//  UIImageViewExtended.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 26/05/22.
//

import Foundation
import UIKit

class UIImageViewExtended:UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
