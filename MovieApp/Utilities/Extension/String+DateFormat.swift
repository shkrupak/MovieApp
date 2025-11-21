//
//  String+DateFormat.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation

enum DateFormat: String {
    case ddMMMy = "dd MMM y"
    case yMMdd = "y-MM-dd"
}

extension String {
    func formatDateTo(inputFormat: DateFormat, outputFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.dateFormat = inputFormat.rawValue
        if let newDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat.rawValue
            return dateFormatter.string(from: newDate)
        } else {
            return nil
        }
    }
}
