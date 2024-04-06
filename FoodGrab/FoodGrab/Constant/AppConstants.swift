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
    static let mealNavTitle = "Explore"
    static let chatNavTitle = "Chat"
    static let accountNavTitle = "Account"
    
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
    
    static let userID = "User Id"
    static let userName = "Username"
    static let password = "Password"
    static let confirmPassword = "Confirm Password"
    static let useLocation = "Use your current location"
    
    static let allCategories = "All Categories"
    static let categories = "Categories"
    static let item = "Item"
    static let items = "Items"
    static let mealName = "Meal Name"
    static let ingredients = "Ingredients"
    static let instructions = "Instructions"
    
    // MARK: - BUTTONS, OTHER ACTIONS
    
    static let meals = "Meals"
    static let chat = "Chat"
    static let maps = "Maps"
    static let account = "Account"
    
    static let login = "Login"
    static let register = "Register"
    static let addPhoto = "Add Photo"
    static let back = "Back"
    static let share = "Share"
    static let seeAll = "See All"
    static let showDetails = "Show Details"
    static let hideDetails = "Hide Details"
    
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
    
    static let playVideo = "Play Video"
    
    // MARK: - FIELDS
    
    static let firstNamePlaceHolder = "enter your first name"
    static let lastNamePlaceHolder = "enter your last name"
    static let emailPlaceHolder = "enter your email"
    static let passwordPlaceHolder = "enter your password"
    static let confrimPasswordPlaceHolder = "re-enter your password"
    static let searchPlaceHolder = "Search"
    
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
    
    // MARK: - FIREBASE DB COLLECTION & FILE NAMES
    
    static let users = "Users"
    static let conversations = "Conversations"
    static let images = "Images"
    
    // MARK: - MEALS, RECIPES
    
    static let idMeal = "idMeal"
    static let strMeal = "strMeal"
    static let strCategory = "strCategory"
    
    static let strIngredients = "strIngredients"
    static let strIngredient1 = "strIngredient1"
    static let strIngredient2 = "strIngredient2"
    static let strIngredient3 = "strIngredient3"
    static let strIngredient4 = "strIngredient4"
    static let strIngredient5 = "strIngredient5"
    static let strIngredient6 = "strIngredient6"
    static let strIngredient7 = "strIngredient7"
    static let strIngredient8 = "strIngredient8"
    static let strIngredient9 = "strIngredient9"
    static let strIngredient10 = "strIngredient10"
    static let strIngredient11 = "strIngredient11"
    static let strIngredient12 = "strIngredient12"
    static let strIngredient13 = "strIngredient13"
    static let strIngredient14 = "strIngredient14"
    static let strIngredient15 = "strIngredient15"
    static let strIngredient16 = "strIngredient16"
    static let strIngredient17 = "strIngredient17"
    static let strIngredient18 = "strIngredient18"
    static let strIngredient19 = "strIngredient19"
    static let strIngredient20 = "strIngredient20"
    
    static let strMeasures = "strMeasures"
    static let strMeasure1 = "strMeasure1"
    static let strMeasure2 = "strMeasure2"
    static let strMeasure3 = "strMeasure3"
    static let strMeasure4 = "strMeasure4"
    static let strMeasure5 = "strMeasure5"
    static let strMeasure6 = "strMeasure6"
    static let strMeasure7 = "strMeasure7"
    static let strMeasure8 = "strMeasure8"
    static let strMeasure9 = "strMeasure9"
    static let strMeasure10 = "strMeasure10"
    static let strMeasure11 = "strMeasure11"
    static let strMeasure12 = "strMeasure12"
    static let strMeasure13 = "strMeasure13"
    static let strMeasure14 = "strMeasure14"
    static let strMeasure15 = "strMeasure15"
    static let strMeasure16 = "strMeasure16"
    static let strMeasure17 = "strMeasure17"
    static let strMeasure18 = "strMeasure18"
    static let strMeasure19 = "strMeasure19"
    static let strMeasure20 = "strMeasure20"
    
    static let strIngredientsWithMeasures = "strIngredientsWithMeasures"
    static let strInstructions = "strInstructions"
    static let strYoutube = "strYoutube"
    static let strMealThumb = "strMealThumb"
    
    static let recipe = "Recipe"
    
    // MARK: - ALERT, POPUP MODAL
    
    static let ok = "Ok"
    static let close = "Close"
    static let information = "Information"
    static let error = "Error"
    
    // MARK: - COLORS
    
    static let white = "white"
    static let black = "black"
    static let green = "green"
    static let darkGray = "darkGray"
    static let darkGrayOne = "darkGrayOne"
    static let lightGrayOne = "lightGrayOne"
    static let lightGrayTwo = "lightGrayTwo"
    static let lightGrayThree = "lightGrayThree"
    
    // MARK: - IMAGES
    
    static let logo = "logo"
    static let welcomeBackGround = "welcomeBG"
  
    static let photoCircle = "photo.circle"
    static let photo = "photo"
    static let photoFill = "photo.fill"
    static let personXmark = "person.crop.circle.fill.badge.xmark"
    
    static let personCircleFill = "person.crop.circle.fill"
    static let mapFill = "map.fill"
    static let squareGrid = "square.grid.2x2.fill"
    static let messageFill = "message.fill"
    static let playFill = "play.fill"
    
    static let chevronLeft = "chevron.left"
    static let chevronRight = "chevron.right"
    static let arrowUpForwardSquare = "arrow.up.forward.square"
    
    static let eyeSlash =  "eye.slash"
    static let eye = "eye"
    static let magnifyingglass = "magnifyingglass"
    static let xCircle = "x.circle"
    
    static let squareAndPencil = "square.and.pencil"
    
    // MARK: - OTHERS
    
    static let emptyString = ""
    static let whiteSpaceString = " "
    static let dashString = "-"
    static let underScoreString = "_"
    static let equalString = "="
    static let emailRegexOne = "[A-Za-z0-9.@]"
    static let emailRegexTwo = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    static let passwordCharacterSet = "!@#$%^&*()-_=+[]{}|;:'\",.<>?"
}
