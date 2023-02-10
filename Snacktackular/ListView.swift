//
//  ListView.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//

import SwiftUI
import Firebase

struct ListView: View {
	@Environment(\.dismiss) var dismiss
	@State private var sheetIsPresented = false
	
    var body: some View {
		List {
			Text ("List items will go here.")
		}
		.listStyle(.plain)
		.navigationBarBackButtonHidden()
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button ("Sign Out") {
					do {
						try Auth.auth().signOut()
						print ("Sign out successful!")
						dismiss()
					} catch {
						print ("ERROR: Sign out failed")
					}
				}
			}

			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					sheetIsPresented.toggle()
				} label: {
					Image (systemName: "plus")
				}
			}
		}
		.sheet(isPresented: $sheetIsPresented) {
			NavigationStack {
				SpotDetailView(spot: Spot())
			}
		}
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			ListView()
		}
    }
}
