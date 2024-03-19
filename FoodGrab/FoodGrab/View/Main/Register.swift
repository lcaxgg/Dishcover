//
//  Register.swift
//  FoodGrab
//
//  Created by j8bok on 8/30/23.
//

import SwiftUI
import SwiftfulLoadingIndicators
import AlertToast

import Alamofire

struct Register: View {
    
    // MARK: - PROPERTIES
    
    @State private var isAddPhotoTapped: Bool = false
    @State private var isPresentedMainScreen: Bool = false
    @State private var deviceOrientation: UIDeviceOrientation = .unknown
    
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var alertViewModel = AlertViewModel()
    
    private let registrationValidationService = RegistrationValidationService()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    
                    // MARK: - HEADER
                    
                    VStack(spacing: (deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight) ? geometry.size.height * 0.04 : geometry.size.height * 0.015) {
                        
                        let imageModifier = ImageModifier(contentMode: .fill, color: AppConstants.lightGrayTwo)
                        
                        Image(systemName: AppConstants.personCircleFill)
                            .configure(withModifier: imageModifier)
                            .frame(width: geometry.size.width * 0.07, height:  geometry.size.height * 0.07)
                        
                        let textModifier =  [TextModifier(font: .system(size: 16.0, weight: .light, design: .rounded), color: isAddPhotoTapped ? AppConstants.lightGrayTwo : AppConstants.green)]
                        
                        Text(AppConstants.addPhoto)
                            .configure(withModifier: textModifier)
                            .onTapGesture {
                                withAnimation {
                                    isAddPhotoTapped.toggle()
                                }
                                
                                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                                    withAnimation {
                                        isAddPhotoTapped.toggle()
                                    }
                                }
                            }
                    }
                    .padding(.top, geometry.size.height * 0.02)
                    
                    HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                    
                    // MARK: - BODY
                    
                    VStack(spacing: 0) {
                        RegisterUpperPart(registrationViewModel: registrationViewModel,
                                          registrationValidationService: registrationValidationService)
                        
                        Group {
                            HorizontalSeparator(color: AppConstants.lightGrayOne, height: geometry.size.height * 0.05)
                            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                        }
                        
                        RegisterMiddlePart(registrationViewModel: registrationViewModel)
                        
                        Group {
                            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                            HorizontalSeparator(color: AppConstants.lightGrayOne, height: geometry.size.height * 0.05)
                            HorizontalSeparator(color: AppConstants.lightGrayThree, height: 1.0)
                        }
                        
                        // MARK: - FOOTER
                        
                        RegisterLowerPart(registrationViewModel: registrationViewModel,
                                          registrationValidationService: registrationValidationService)
                    }
                    
                    let attribute = ButtonOneAttributes(text: AppConstants.register,
                                                        bgColor: registrationViewModel.shouldDisableButton ? AppConstants.lightGrayTwo : registrationViewModel.invalidFields.count > 0 ? AppConstants.lightGrayTwo : AppConstants.green,
                                                        fontWeight: .semibold,
                                                        fontSize: geometry.size.height * 0.02,
                                                        cornerRadius: 10.0, isEnabled: true)
                    
                    ButtonOne(attribute: attribute)
                        .frame(height: geometry.size.height * 0.055)
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.horizontal, geometry.size.width * 0.04)
                        .onTapGesture(perform: {
                            AuthManager.processRegistration(with: registrationViewModel, andWith: alertViewModel)
                        })
                }//: ScrollView
                .opacity(registrationViewModel.isProccessingRegistration ? 0.5 : 1.0)
            }
            
            if registrationViewModel.isProccessingRegistration {
                LoadingIndicator(animation: .threeBalls, color: Color(AppConstants.green), size: .large, speed: .normal)
            }
        }//: ZStack
        .ignoresSafeArea(.keyboard)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { _ in
                deviceOrientation = UIDevice.current.orientation
            }
            
            UIScrollView.appearance().showsVerticalScrollIndicator = false
            registrationViewModel.initDictionary()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationBarTitle(AppConstants.register, displayMode: .inline)
        .navigationBarBackButtonHidden(registrationViewModel.isProccessingRegistration)
        .disabled(registrationViewModel.isProccessingRegistration)
        .alert(isPresented: Binding(get: { alertViewModel.getIsPresented() }, set: { _ in })) {
            Alert(
                title: Text(alertViewModel.getTitle()),
                message: Text(alertViewModel.getMessage()),
                dismissButton: .default(Text(AppConstants.ok), action: {
                    isPresentedMainScreen = true
                })
            )
        }
        .background(
            NavigationLink(AppConstants.emptyString, destination: Meals(screenSize: CGSize()), isActive: $isPresentedMainScreen)
        )
    }
}

// MARK: - PREVIEW


#Preview {
    CustomPreview { Register() }
}
