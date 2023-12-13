//
//  Education.swift
//  IColab
//
//  Created by Kevin Dallian on 14/09/23.
//

import Foundation
import FirebaseFirestore

class Education : Background{
    override init(title: String, company: String, startDate: Date, endDate: Date, desc: String) {
        super.init(title: title, company: company, startDate: startDate, endDate: endDate, desc: desc)
    }
    
    override init(copyFrom other: Background) {
        super.init(copyFrom: other)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let company = try container.decode(String.self, forKey: .company)
        let startDate = try container.decode(Date.self, forKey: .startDate)
        let endDate = try container.decode(Date.self, forKey: .endDate)
        let desc = try container.decode(String.self, forKey: .desc)

        super.init(title: title, company: company, startDate: startDate, endDate: endDate, desc: desc)
    }

    private enum CodingKeys: String, CodingKey {
        case title
        case company
        case startDate
        case endDate
        case desc
    }
    
    public func toDict() -> [String : Any] {
        return [
            "title" : self.title,
            "company" : self.company,
            "startDate" : Timestamp(date: self.startDate),
            "endDate" : Timestamp(date: self.endDate),
            "desc" : self.desc
        ]
    }
    
    static func decode(from data: [[String: Any]]) -> [Education]{
        var educations = [Education]()
        for educationData in data {
            let title = educationData["title"] as! String
            let company = educationData["company"] as! String

            // Convert timestamps to Date objects
            let startDateTimestamp = educationData["startDate"] as! Timestamp
            let startDate = startDateTimestamp.dateValue()
            let endDateTimestamp = educationData["endDate"] as! Timestamp
            let endDate = endDateTimestamp.dateValue()

            let desc = educationData["desc"] as! String

            let education = Education(title: title, company: company, startDate: startDate, endDate: endDate, desc: desc)
            educations.append(education)
        }
        return educations
    }
}
