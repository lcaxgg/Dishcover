//
//  RegisterUpperView.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI
import FirebaseFirestoreSwift


struct RegisterUpperPart: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var registrationViewModel: RegistrationViewModel
    
    private let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.black)]
    let registrationValidationService: RegistrationValidationService
    
    var body: some View {
        VStack(spacing: 7.0) {
            
            // MARK: - UPPER PART
            
            HStack {
                Text(AppConstants.firstName)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
        
                TextField(AppConstants.firstNamePlaceHolder, text: registrationViewModel.firstNameBinding)
                    .autocapitalization(.words)
                    .keyboardType(.alphabet)
                    .padding()
                    .onChange(of: registrationViewModel.getFirstName()) { newValue in
                        let firstName = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                        
                        registrationViewModel.setFirstName(with: firstName)
                        registrationValidationService.validateRegistrationData(with: AppConstants.firstNameKey, andWith: registrationViewModel)
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
                
                TextField(AppConstants.lastNamePlaceHolder, text: registrationViewModel.lastNameBinding)
                    .autocapitalization(.words)
                    .keyboardType(.alphabet)
                    .padding()
                    .onChange(of: registrationViewModel.getLastName()) { newValue in
                        let lastName = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                        
                        registrationViewModel.setLastName(with: lastName)
                        registrationValidationService.validateRegistrationData(with: AppConstants.lastNameKey, andWith: registrationViewModel)
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
                
                TextField(AppConstants.emailPlaceHolder, text: registrationViewModel.emailBinding)
                    .keyboardType(.emailAddress)
                    .padding()
                    .onChange(of: registrationViewModel.getEmail()) { newValue in
                        let email = registrationValidationService.validateEmailInput(newValue)
                        
                        registrationViewModel.setEmail(with: email)
                        registrationValidationService.validateRegistrationData(with: AppConstants.emailKey, andWith: registrationViewModel)
                    }
            }
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
        }
    }
}

// MARK: - PREVIEW

struct RegisterUpperPart_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUpperPart(registrationViewModel: RegistrationViewModel(),
                          registrationValidationService: RegistrationValidationService())
        
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 220.0))
    }
}
