//
//  RegisterMiddlePart.swift
//  Dishcover
//
//  Created by j8bok on 9/7/23.
//

import SwiftUI

struct RegisterMiddlePart: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var registrationViewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                let textModifier = [TextModifier(font: .system(size: 15.0, weight: .semibold, design: .rounded), color: AppConstants.customBlack)]
                
                Text(AppConstants.address)
                    .configure(withModifier: textModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.19, alignment: .leading)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)

                VStack {
                    TextField(AppConstants.streetNumber, text: $registrationViewModel.registrationModel.streetNumber)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    TextField(AppConstants.streetName, text: $registrationViewModel.registrationModel.streetName)
                        .autocapitalization(.words)
                        .keyboardType(.alphabet)
                        .padding()
                        .onChange(of: registrationViewModel.getStreetName()) { newValue in
                            let streetName = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                            
                            registrationViewModel.setStreetName(with: streetName)
                        }
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    HStack {
                        TextField(AppConstants.barangay, text: $registrationViewModel.registrationModel.barangay)
                            .autocapitalization(.words)
                            .padding()
                            .onChange(of: registrationViewModel.getBarangay()) { newValue in
                                let barangay = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                                
                                registrationViewModel.setBarangay(with: barangay)
                            }
                        
                        VerticalSeparator()
                        
                        TextField(AppConstants.zipCode, text: $registrationViewModel.registrationModel.zipCode)
                            .keyboardType(.numberPad)
                            .padding()
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.06)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    HStack {
                        TextField(AppConstants.city, text: $registrationViewModel.registrationModel.city)
                            .autocapitalization(.words)
                            .keyboardType(.alphabet)
                            .padding()
                            .onChange(of: registrationViewModel.getCity()) { newValue in
                                let city = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                                
                                registrationViewModel.setCity(with: city)
                            }
                        
                        VerticalSeparator()
                        
                        TextField(AppConstants.country, text: $registrationViewModel.registrationModel.country)
                            .autocapitalization(.words)
                            .keyboardType(.alphabet)
                            .padding()
                            .onChange(of: registrationViewModel.getCountry()) { newValue in
                                let country = newValue.filter { $0.isLetter || $0.isWhitespace }.capitalized
                                
                                registrationViewModel.setCountry(with: country)
                            }
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.06)
                }
            }
            .padding(.vertical, UIScreen.main.bounds.height * 0.007)
            
            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
            
            HStack(spacing: 20.0) {
                let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.customGreen)
                
                Image(systemName: AppConstants.mapFill)
                    .configure(withModifier: imageModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.03, height:  UIScreen.main.bounds.height * 0.03)
                
                let textModifier = [TextModifier(font: .system(size: 15.0, weight: .regular, design: .rounded), color: AppConstants.customBlack)]
                
                Text(AppConstants.useLocation)
                    .configure(withModifier: textModifier)
                
                Spacer()
         
                Image(systemName: AppConstants.chevronRight)
                    .configure(withModifier: imageModifier)
                    .frame(width: UIScreen.main.bounds.width * 0.02, height:  UIScreen.main.bounds.height * 0.02)
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.07)
            .frame(height: UIScreen.main.bounds.height * 0.06)
        }
    }
}

// MARK: - PREVIEW

//@available(iOS 17, *)
//#Preview(traits: .fixedLayout(width: UIScreen.main.bounds.width, height: 400.0)) {
//    RegisterMiddlePart(registrationViewModel: RegistrationViewModel())
//}
