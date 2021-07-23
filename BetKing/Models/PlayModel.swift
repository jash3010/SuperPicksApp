//
//  PlayModel.swift
//  BetKing
//
//  Created by MAC on 23/07/21.
//

import Foundation

// MARK: - PlayModel
class PlayModel: Codable {
    let payload: Payload?
    let errorCode: Int?
    let errorTimeStamp, errorMessage: String?
    let hasError: Bool?
    
    enum CodingKeys: String, CodingKey {
        case payload = "payload"
        case errorCode = "errorCode"
        case errorTimeStamp = "errorTimeStamp"
        case errorMessage = "errorMessage"
        case hasError = "hasError"
    }

    init(payload: Payload?, errorCode: Int?, errorTimeStamp: String?, errorMessage: String?, hasError: Bool?) {
        self.payload = payload
        self.errorCode = errorCode
        self.errorTimeStamp = errorTimeStamp
        self.errorMessage = errorMessage
        self.hasError = hasError
    }
}

// MARK: - Payload
class Payload: Codable {
    let totalCount: Int?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case totalCount = "totalCount"
    }
    
    init(totalCount: Int?, items: [Item]?) {
        self.totalCount = totalCount
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let externalEvents: [ExternalEvent]?
    let matches: [Match]?
    let result: Result?
    let id: Int?
    let drawDate: String?
    let drawName, betStartDate: String?
    let betEndDate: String?
    let processingStatusID: Int?

    enum CodingKeys: String, CodingKey {
        case matches = "matches"
        case externalEvents = "externalEvents"
        case result = "result"
        case id = "id"
        case drawDate = "drawDate"
        case drawName = "drawName"
        case betStartDate = "betStartDate"
        case betEndDate = "betEndDate"
        case processingStatusID = "processingStatusID"
    }

    init(externalEvents: [ExternalEvent]?, matches: [Match]?, result: Result?, id: Int?, drawDate: String?, drawName: String?, betStartDate: String?, betEndDate: String?, processingStatusID: Int?) {
        self.externalEvents = externalEvents
        self.matches = matches
        self.result = result
        self.id = id
        self.drawDate = drawDate
        self.drawName = drawName
        self.betStartDate = betStartDate
        self.betEndDate = betEndDate
        self.processingStatusID = processingStatusID
    }
}

// MARK: - ExternalEvent
class ExternalEvent: Codable {
    let id, drawID, orderIndex: Int?
    let eventName: String?
    let eventDate: String?
    let externalID: String?
    let teamID, matchID: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case drawID = "drawId"
        case orderIndex = "orderIndex"
        case eventName = "eventName"
        case eventDate = "eventDate"
        case externalID = "externalId"
        case teamID = "teamId"
        case matchID = "matchId"
    }

    init(id: Int?, drawID: Int?, orderIndex: Int?, eventName: String?, eventDate: String?, externalID: String?, teamID: Int?, matchID: Int?) {
        self.id = id
        self.drawID = drawID
        self.orderIndex = orderIndex
        self.eventName = eventName
        self.eventDate = eventDate
        self.externalID = externalID
        self.teamID = teamID
        self.matchID = matchID
    }
}

// MARK: - Match
class Match: Codable {
    let id: Int?
    let date: String?
    let name, externalID, thirdPartyID: String?
    let mediaTag: String?
    let deleted: Bool?
    let originalID: String?
    let cancelled: Bool?
    let relatedEventsOrderIndex: [Int]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case name = "name"
        case externalID = "externalId"
        case thirdPartyID = "thirdPartyId"
        case mediaTag = "mediaTag"
        case deleted = "deleted"
        case originalID = "originalId"
        case cancelled = "cancelled"
        case relatedEventsOrderIndex = "relatedEventsOrderIndex"
    }

    init(id: Int?, date: String?, name: String?, externalID: String?, thirdPartyID: String?, mediaTag: String?, deleted: Bool?, originalID: String?, cancelled: Bool?, relatedEventsOrderIndex: [Int]?) {
        self.id = id
        self.date = date
        self.name = name
        self.externalID = externalID
        self.thirdPartyID = thirdPartyID
        self.mediaTag = mediaTag
        self.deleted = deleted
        self.originalID = originalID
        self.cancelled = cancelled
        self.relatedEventsOrderIndex = relatedEventsOrderIndex
    }
}

// MARK: - Result
class Result: Codable {
    let drawName: String?
    let status: Int?
    let picks: [Pick]?
    let machinePicks: [String]?
    let highestWinnings: String?

    enum CodingKeys: String, CodingKey {
        case drawName = "drawName"
        case status = "status"
        case picks = "picks"
        case machinePicks = "machinePicks"
        case highestWinnings = "highestWinnings"
    }
    
    init(drawName: String?, status: Int?, picks: [Pick]?, machinePicks: [String]?, highestWinnings: String?) {
        self.drawName = drawName
        self.status = status
        self.picks = picks
        self.machinePicks = machinePicks
        self.highestWinnings = highestWinnings
    }
}

// MARK: - Pick
class Pick: Codable {
    let value: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case id = "id"
    }
    
    init(value: String?, id: Int?) {
        self.value = value
        self.id = id
    }
}










// MARK: - Item
class Itemss: Codable {
    let externalEvents: ExternalEventsss?
    let matches: [Match]?
    let result: Result?
    let id: Int?
    let drawDate: String?
    let drawName, betStartDate: String?
    let betEndDate: String?
    let processingStatusID: Int?

    init(externalEvents: ExternalEventsss?, matches: [Match]?, result: Result?, id: Int?, drawDate: String?, drawName: String?, betStartDate: String?, betEndDate: String?, processingStatusID: Int?) {
        self.externalEvents = externalEvents
        self.matches = matches
        self.result = result
        self.id = id
        self.drawDate = drawDate
        self.drawName = drawName
        self.betStartDate = betStartDate
        self.betEndDate = betEndDate
        self.processingStatusID = processingStatusID
    }
}


// MARK: - ExternalEvent
class ExternalEventsss: Codable {
    let firstTeam: MatchDic?
    let secondTeam: MatchDic?

    init(firstTeam: MatchDic?, secondTeam: MatchDic?) {
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
    }
}


// MARK: - ExternalEvent
class MatchDic: Codable {
    let id, drawID, orderIndex: Int?
    let eventName: String?
    let eventDate: String?
    let externalID: String?
    let teamID, matchID: Int?

    init(id: Int?, drawID: Int?, orderIndex: Int?, eventName: String?, eventDate: String?, externalID: String?, teamID: Int?, matchID: Int?) {
        self.id = id
        self.drawID = drawID
        self.orderIndex = orderIndex
        self.eventName = eventName
        self.eventDate = eventDate
        self.externalID = externalID
        self.teamID = teamID
        self.matchID = matchID
    }
}
