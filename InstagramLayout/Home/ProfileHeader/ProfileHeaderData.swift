//
//  ProfileHeaderData.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 27/01/21.
//

import Foundation

// We get Hashable synthesized which means we get automatic refresh if we create new snapshot and any of these properties has a new value.
struct ProfileHeaderData: Hashable {
    let name: String
    let accountType: String
    let postCount: Int
}

extension ProfileHeaderData {
    static var demoProfileData: ProfileHeaderData {
        ProfileHeaderData(name: "Tommy Shelby", accountType: "Peaky Blinders", postCount: 176)
    }
}
