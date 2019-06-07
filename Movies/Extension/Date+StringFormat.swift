//
//  Date+StringFormat.swift
//  Movies
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

extension Date {
    func getYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
}
