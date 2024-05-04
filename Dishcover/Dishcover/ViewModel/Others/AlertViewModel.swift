//
//  AlertViewModel.swift
//  Dishcover
//
//  Created by j8bok on 9/27/23.
//

import Foundation

class AlertViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var alertModel = AlertModel()
}

extension AlertViewModel {
    
    // MARK: - GETTER
    
    func getIsPresented() -> Bool {
        alertModel.isPresented
    }
    
    func getTitle() -> String {
        alertModel.title
    }
    
    func getMessage() -> String {
        alertModel.message
    }
    
    // MARK: - SETTER
    
    func setIsPresented(with isPresented: Bool) {
        alertModel.isPresented = isPresented
    }
    
    func setTitle(with title: String) {
        alertModel.title = title
    }
    
    func setMessage(with message: String) {
        alertModel.message = message
    }
}
