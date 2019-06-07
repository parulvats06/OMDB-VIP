//
//  String+DateFormater.swift
//  Movies
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}
