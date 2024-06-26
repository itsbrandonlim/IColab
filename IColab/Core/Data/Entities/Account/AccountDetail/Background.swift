//
//  Background.swift
//  IColab
//
//  Created by Kevin Dallian on 18/09/23.
//

import Foundation
import FirebaseFirestore

class Background : Hashable{
    var title : String
    var company : String
    var startDate : Date
    var endDate : Date
    var desc : String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case company
        case startDate
        case endDate
        case desc
    }
    
    init(title: String, company: String, startDate: Date, endDate: Date, desc: String) {
        self.title = title
        self.company = company
        self.startDate = startDate
        self.endDate = endDate
        self.desc = desc
    }
    
    init(copyFrom other: Background) {
        self.title = other.title
        self.company = other.company
        self.startDate = other.startDate
        self.endDate = other.endDate
        self.desc = other.desc
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(company)
        hasher.combine(startDate)
        hasher.combine(endDate)
        hasher.combine(desc)
    }
    
    static func == (lhs: Background, rhs: Background) -> Bool {
        return lhs.title == rhs.title &&
        lhs.company == rhs.company &&
        lhs.startDate == rhs.endDate &&
        lhs.endDate == rhs.endDate &&
        lhs.desc == rhs.desc
    }
}
