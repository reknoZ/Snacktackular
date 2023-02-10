//
//  SpotDetailView.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//

import SwiftUI

struct SpotDetailView: View {
	@EnvironmentObject var spotVM: SpotViewModel
	@State var spot: Spot
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		VStack {
			Group {
				TextField("Name", text: $spot.name)
					.font(.title)
				TextField("Address", text: $spot.address)
					.font(.title2)
			}
			.textFieldStyle(.roundedBorder)
			.overlay {
				RoundedRectangle(cornerRadius: 5)
					.stroke(.gray.opacity(0.5), lineWidth: 2)
			}
			.padding(.horizontal)
			
			Spacer()
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(spot.id == nil)
		.toolbar {
			if spot.id == nil {
				ToolbarItem(placement: .cancellationAction) {
					Button ("Cancel") {
						dismiss()
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button ("Save") {
						Task {
							let success = await spotVM.saveSpot(spot)
							if success  {
								dismiss()
							} else {
								print ("Error saving spot")
							}
						}
						dismiss()
					}
				}
			}
		}
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			SpotDetailView(spot: Spot())
				.environmentObject(SpotViewModel())
		}
    }
}
