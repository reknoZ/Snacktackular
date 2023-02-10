//
//  Spot.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Spot: Codable, Identifiable {
	@DocumentID var id: String?
	var name = ""
	var address = ""
	
	var dictionary: [String: Any] {
		return ["name": name, "address": address]
	}
	
}
