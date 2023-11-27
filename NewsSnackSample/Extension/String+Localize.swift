//
//  String+Localize.swift
//  NewsSnackSample
//
//  Created by Laurie Biguet on 02/11/2023.
//

import Foundation

extension String {
    private var notFoundString: String {
        "_____String not found_____"
    }
    
    var localize: String {
        var res = NSLocalizedString(self, value: notFoundString, comment: "")
        
        if res == notFoundString {
            print("No localization found for key \(self)")
            res = self
        }
        return res
    }
    
    func localize(_ args: CVarArg...) -> String {
        return String(format: localize, args)
    }
}

