//
//  RegisterUpperView.swift
//  Dishcover
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct RegisterUpperPart: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var registrationViewModel: RegistrationViewModel
    
    private let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
    
    var body: some View {
        VStack(spacing: 7.0) {
            
            // MARK: - UPPER PART
            
            HStack {
                Text(AppConstants.firstName)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                
                TextField(AppConstants.firstNamePlaceHolder, text: $registrationViewModel.registrationModel.firstName)
                    .autocapitalization(.words)
                    .keyboardType(.alphabet)
                    .padding()
                    .onChange(of: registrationViewModel.getFirstName()) { newValue in
                        let firstName = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                        
                        registrationViewModel.setFirstName(with: firstName)
                        registrationViewModel.validateRegistrationData(with: AppConstants.firstNameKey)
                    }
            }
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                .padding(.leading, UIScreen.main.bounds.width * 0.06)
            
            // MARK: - MIDDLE PART
            
            HStack {
                Text(AppConstants.lastName)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                
                TextField(AppConstants.lastNamePlaceHolder, text: $registrationViewModel.registrationModel.lastName)
                    .autocapitalization(.words)
                    .keyboardType(.alphabet)
                    .padding()
                    .onChange(of: registrationViewModel.getLastName()) { newValue in
                        let lastName = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                        
                        registrationViewModel.setLastName(with: lastName)
                        registrationViewModel.validateRegistrationData(with: AppConstants.lastNameKey)
                    }
            }
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                .padding(.leading, UIScreen.main.bounds.width * 0.06)
            
            // MARK: - LOWER PART
            
            HStack {
                Text(AppConstants.email)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                
                TextField(AppConstants.emailPlaceHolder, text: $registrationViewModel.registrationModel.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .onChange(of: registrationViewModel.getEmail()) { newValue in
                        let email = EmailValidationService.validateEmailInput(newValue)
                        
                        registrationViewModel.setEmail(with: email)
                        registrationViewModel.validateRegistrationData(with: AppConstants.emailKey)
                    }
            }
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
        }
    }
}

// MARK: - PREVIEW
//
//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: UIScreen.main.bounds.width, height: 220.0)) {
//    RegisterUpperPart(registrationViewModel: RegistrationViewModel(), registrationValidationService: RegistrationValidationService())
//}
