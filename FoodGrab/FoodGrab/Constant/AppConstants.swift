//
//  AppConstants.swift
//  FoodGrab
//
//  Created by j8bok on 9/7/23.
//

import Foundation

struct AppConstants {
    // MARK: - TITLES
    
    static let welcomeTitle = "Food that tells a story"
    static let mainTitle = "Explore"
    static let login = "Login"
    static let register = "Register"
    static let addPhoto = "Add Photo"
    
    // MARK: - LABELS
    
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let email = "Email"
    
    static let address = "Address"
    static let streetNumber = "street/building number"
    static let streetName = "street/building name"
    static let barangay = "barangay"
    static let city = "city"
    static let zipCode = "zip Code"
    static let country = "country"
    
    static let userID = "User ID"
    static let userName = "Username"
    static let password = "Password"
    static let confirmPassword = "Confirm Password"
    static let useLocation = "Use your current location"
    
    static let meals = "Meals"
    static let chat = "Chat"
    static let maps = "Maps"
    static let account = "Account"
    
    static let allCategories = "All Categories"
    static let categories = "Categories"
    static let seeAll = "See All"
    static let item = "Item"
    static let items = "Items"

    static let beef = "Beef"
    static let chicken = "Chicken"
    static let dessert = "Dessert"
    static let lamb = "Lamb"
    static let miscellaneous = "Miscellaneous"
    static let pasta = "Pasta"
    static let pork = "Pork"
    static let seaFood = "Seafood"
    static let side = "Side"
    static let starter = "Starter"
    static let vegan = "Vegan"
    static let vegetarian = "Vegetarian"
    static let breakFast = "Breakfast"
    static let goat = "Goat"
    
    // MARK: - FIELDS
    
    static let firstNamePlaceHolder = "enter your first name"
    static let lastNamePlaceHolder = "enter your last name"
    static let emailPlaceHolder = "enter your email"
    static let passwordPlaceHolder = "enter your password"
    static let confrimPasswordPlaceHolder = "re-enter your password"
    static let searchPlaceHolder = "Search food or meal"
    
    // MARK: - VALIDATION MESSAGES
    
    static let fillInFirstName = "Fill in First Name"
    static let fillInLastName = "Fill in Last Name"
    static let fillInEmail = "Fill in Email"
    static let fillInPassword = "Fill in Password"
    static let fillInConfirmPassword = "Fill in Confirm Password"
    
    static let invalidLength = "Invalid Length"
    static let invalidFirstName = "Invalid First Name"
    static let invalidLastName = "Invalid Last Name"
    static let invalidEmail = "Invalid Email"
    static let invalidPassword = "Invalid Password"
    static let notMatchingPasswords = "Passwords are not matching"
    static let successfullyRegistered = "Successfully Registered"
    
    // MARK: - ACCOUNT KEYS
    
    static let firstNameKey = "firstName"
    static let lastNameKey = "firstName"
    static let emailKey = "email"
    static let passwordKey = "password"
    static let confirmPasswordKey = "confirmPassword"
    
    // MARK: - FIREBASE DB COLLECTION NAMES
    
    static let users = "Users"
    
    // MARK: - MEALS DATA KEYS
    
    static let idMealKey = "idMeal"
    static let strMealKey = "strMeal"
    static let strMealThumbKey = "strMealThumb"
    
    // MARK: - ALERT, POPUP MODAL
    
    static let ok = "Ok"
    static let close = "Close"
    static let information = "Information"
    
    // MARK: - COLORS
    
    static let white = "white"
    static let black = "black"
    static let green = "green"
    static let darkGray = "darkGray"
    static let lightGrayOne = "lightGrayOne"
    static let lightGrayTwo = "lightGrayTwo"
    static let lightGrayThree = "lightGrayThree"
    
    // MARK: - IMAGES
    
    static let logo = "logo"
    static let welcomeBackGround = "welcomeBG"
    static let photoCircle = "photo.circle"
    static let photo = "photo"
    static let photoFill = "photo.fill"
    static let personCircleFill = "person.crop.circle.fill"
    static let mapFill = "map.fill"
    static let chevronRight = "chevron.right"
    static let eyeSlash =  "eye.slash"
    static let eye = "eye"
    static let magnifyingglass = "magnifyingglass"
    static let squareGrid = "square.grid.2x2.fill"
    static let messageFill = "message.fill"
    static let arrowUpForwardSquare = "arrow.up.forward.square"
    static let xCircle = "x.circle"
    
    // MARK: - OTHERS
    
    static let emptyString = ""
    static let whiteSpace = " "
    static let equalString = "="
    static let emailRegexOne = "[A-Za-z0-9.@]"
    static let emailRegexTwo = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    static let passwordCharacterSet = "!@#$%^&*()-_=+[]{}|;:'\",.<>?"
}
