//
//  String+Utilities.swift
//  Akaibu
//
//  Created by kite1412 on 16/02/26.
//

extension String {
    func truncated(to maxLength: Int, trailing: String? = nil) -> String {
        guard count > maxLength else { return self }
        let endIndex = index(startIndex, offsetBy: maxLength)
        return String(self[..<endIndex]) + (trailing ?? "")
    }
}
