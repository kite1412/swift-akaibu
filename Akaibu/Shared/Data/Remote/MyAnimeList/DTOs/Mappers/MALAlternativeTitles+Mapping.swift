//
//  MALAlternativeTitles+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

extension MALAlternativeTitles {
    func toStrings() -> [String] {
        var titles: [String] = []
        
        if let ja {
            titles.append(ja)
        }
        
        if let synonyms {
            titles.append(contentsOf: synonyms)
        }
        
        return titles
    }
}
