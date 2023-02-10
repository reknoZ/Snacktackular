//
//  LoginView.swift
//  Snacktackular
//
//  Created by Zicount on 10.02.23.
//
//	Source: www.youtube.com/watch?v=PxAchicsUYY
//	Source: bit.ly/prof-g-swiftui-files

import SwiftUI
import Firebase

struct LoginView: View {
	
	enum Field {
		case email, password
	}
	
	@State private var email = ""
	@State private var password = ""
	@State private var alertIsVisible = false
	@State private var alertMessage = ""
	@State private var buttonsEnabled = false
	
	@State private var path = NavigationPath()

	@FocusState private var focusField: Field?
	
	var body: some View {
		NavigationStack (path: $path) {
			Image("logo")
				.resizable()
				.scaledToFit()
				.padding()
			
			Group {
				TextField("Email", text: $email)
					.keyboardType(.emailAddress)
					.autocorrectionDisabled()
					.textInputAutocapitalization(.never)
					.submitLabel(.next)
					.focused($focusField, equals: .email)
					.onSubmit {
						focusField = .password
					}
					.onChange(of: email) { _ in
						enableButtons()
					}
				
				SecureField("Password", text: $password)
					.submitLabel(.done)
					.focused($focusField, equals: .password)
					.onSubmit {
						focusField = nil
					}
					.onChange(of: password) { _ in
						enableButtons()
					}

			}
			.textFieldStyle(.roundedBorder)
			.overlay {
				RoundedRectangle(cornerRadius: 5)
					.stroke(.gray.opacity(0.5), lineWidth: 2)
			}
			.padding(.horizontal)
			
			HStack {
				Button {
					signIn()
				} label: {
					Text ("Sign In")
				}
				.padding(.trailing)
				
				Button {
					signUp()
				} label: {
					Text ("Sign Up")
				}
				.padding(.leading)
			}
			.disabled(!buttonsEnabled)
			.buttonStyle(.borderedProminent)
			.tint(Color("snackColor"))
			.font(.title2)
			.padding(.top)
			.navigationBarTitleDisplayMode(.inline)

			.navigationDestination(for: String.self) { view in
				if view == "ListView" {
					ListView()
				}
			}

			
			Spacer()
		}
		.padding()
		.alert(alertMessage, isPresented: $alertIsVisible) {
			Button ("OK", role: .cancel) {}
		}
		.onAppear() {
			if Auth.auth().currentUser != nil {
				print ("Already logged in")
				path.append("ListView")
			}
		}
	}
	
	func enableButtons() {
		let emailIsGood = email.count > 5 && email.contains("@")
		let passwordIsGood = password.count > 5
		buttonsEnabled = emailIsGood && passwordIsGood
	}
	
	func signUp() {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print ("😡 SIGN UP ERROR: \(error.localizedDescription)")
				alertMessage = "SIGN UP ERROR: \(error.localizedDescription)"
				alertIsVisible = true
			} else {
				print ("😎 Sign up successful")
				path.append("ListView")
			}
		}
	}
	
	func signIn() {
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if let error = error {
				print ("😡 SIGN IN ERROR: \(error.localizedDescription)")
				alertMessage = "SIGN IN ERROR: \(error.localizedDescription)"
				alertIsVisible = true
			} else {
				print ("🪵 Sign in successful")
				path.append("ListView")
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
