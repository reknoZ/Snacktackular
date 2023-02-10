//
//  SpotViewModel.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject {
	@Published var spot = Spot()
	
	func saveSpot (_ spot: Spot) async -> Bool {
		let db = Firestore.firestore()
		
		if let id = spot.id {
			do {
				try await db.collection("spots").document(id).setData(spot.dictionary)
				print ("Spot updated successfully")
				return true
			} catch {
				print ("ERROR: Spot update failed: \(error.localizedDescription)")
				return false
			}
		} else {
			do {
				var _ = try await db.collection("spots").addDocument(data: spot.dictionary)
				print ("Spot added successfully")
				return true
			} catch {
				print ("ERROR: Spot add failed: \(error.localizedDescription)")
				return false
			}

		}
	}
}
