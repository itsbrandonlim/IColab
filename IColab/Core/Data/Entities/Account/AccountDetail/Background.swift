//
//  Background.swift
//  IColab
//
//  Created by Kevin Dallian on 18/09/23.
//

import Foundation

class Background : Hashable, Codable{
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        company = try container.decode(String.self, forKey: .company)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        desc = try container.decode(String.self, forKey: .desc)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)
        try container.encode(company, forKey: .company)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(desc, forKey: .desc)
    }
}
