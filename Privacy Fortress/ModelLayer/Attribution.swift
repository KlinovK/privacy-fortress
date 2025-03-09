//
//  Attribution.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

struct Attribution {
    let campaign: String?
    let adSet: String?
    let mediaSource: String?
    let clickId: String?
    let ip: String?

    init(data: [AnyHashable: Any]) {
        campaign = data["campaign"] as? String
        adSet = data["adset"] as? String
        mediaSource = data["media_source"] as? String
        clickId = data["clickid"] as? String
        ip = data["ip"] as? String
    }
}
