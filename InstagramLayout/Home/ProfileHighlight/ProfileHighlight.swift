//
//  ProfileHighlight.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 28/01/21.
//

import UIKit

struct ProfileHighlight: Hashable {
    let id = UUID()
    let image: UIImage
}

extension ProfileHighlight {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ProfileHighlight {
    static var demoHighlights: [ProfileHighlight] {
        let imageNames = (1...12
        ).map({ "flower\($0)" })
        return imageNames.map({ ProfileHighlight(image: UIImage(named: $0)!) })
    }
}
