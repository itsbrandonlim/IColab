//
//  Experience.swift
//  IColab
//
//  Created by Kevin Dallian on 14/09/23.
//

import Foundation
import FirebaseFirestore

class Experience : Background {
    override init(title: String, company: String, startDate: Date, endDate: Date, desc: String) {
        super.init(title: title, company: company, startDate: startDate, endDate: endDate, desc: desc)
    }
    
    override init(copyFrom other: Background) {
        super.init(copyFrom: other)
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
    
    static func decode(from data: [String: Any]) -> Experience{
        let title = data["title"] as! String
        let company = data["company"] as! String

        let startDateTimestamp = data["startDate"] as! Timestamp
        let startDate = startDateTimestamp.dateValue()
        let endDateTimestamp = data["endDate"] as! Timestamp
        let endDate = endDateTimestamp.dateValue()

        let desc = data["desc"] as! String

        let experience = Experience(title: title, company: company, startDate: startDate, endDate: endDate, desc: desc)
        return experience
    }
}
