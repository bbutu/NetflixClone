//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Beka Buturishvili on 15.11.22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
