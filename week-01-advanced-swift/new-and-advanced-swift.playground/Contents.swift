import UIKit

//*************************************
//MARK: String Literals and Raw Strings

//string literal (interpolation is still supported the same way as regular string)
let multiline = """
    this string is pre-formatted
and it takes up
  multiple lines
"""
print(multiline)

//raw string - no need to escape special characters!
let raw = #"I don't want to "go to work" I just want to "sleep""#
print(raw)

//interpolation is a little different for raw strings
let unreadMessages = 3
let rawInterpolation = #"You have \#(unreadMessages) unread messages"#
print(rawInterpolation)

//especially useful for RegEx
let names = "Ariel, Danny, Aileen, David, Annie, Matt, Laura"
let aileenRegEx = "\\bAileen\\b"
let aileenBetterRegEx = #"\bAileen\b"#

let aileenRange = names.range(of: aileenBetterRegEx, options: .regularExpression)
print(names[aileenRange!])

//raw and literal strings can be used together
let rawLiteral = #"""
Literally such a raw string
Yeah, and super literal...
"""#
print(rawLiteral)

//********************
//MARK: Boolean Toggle Method
/*
var booleansAreEasyToToggle: Bool = false
print(booleansAreEasyToToggle)
booleansAreEasyToToggle.toggle()
print(booleansAreEasyToToggle)
 */

//MARK: Custom String Interpolation?
/*
//create struct
struct MenuItem {
    var name: String
    var price: Double
}

//instantiate
let coffee = MenuItem(name: "Coffee", price: 3.35)
let tea = MenuItem(name: "Tea", price: 2.25)
//show initial print statement format
print("""
Beverages:
\(coffee)
\(tea)
""")

//extend the String.StringInterpolation
extension String.StringInterpolation {
    //use the mutating keyword since we are modifying the properties of a value type (String is a struct)
    mutating func appendInterpolation(_ value: MenuItem) {
        appendInterpolation("\(value.name)......$\(value.price)")
    }
}
*/

//MARK: Optionals — review
/*
//declare optional variable and no initial assignment, thus the initial value is nil
var score: Int?
print("Score: \(score)")

//assign a value
score = 80
//force unwrap the optional -- not good since program will crash if the optional is nil
print("Score: \(score!)")

//first check the value to ensure it is not nil -- still not the best way
if score != nil {
    //then force unwrap
    print("The score is \(score!)")
}

//optional binding! -- great!
if let currentScore = score {
    print("The score is \(currentScore)")
}

//unwrapping with a coalescing operator and a default value
score = nil
let myScore = score ?? 0
print("My score is \(myScore)")

//optional chaining: gracefully accessing members, properties, or methods of optionals
struct Developer {
    var name: String
    var app: App?
}

struct App {
    var title: String = "First - First Responder Health"
}

let nate = Developer(name: "Nate") //, app: App()) - uncomment to give the optional property a value
print(nate.dietaryRestriction!.type) //runtime error! try to access property of nil optional

//proper way to access optional property -- try it with an optional that has
if let app = nate.app?.title {
    print("\(nate.name) has released the following apps: \(app)")
} else {
    print("\(nate.name) has not released any apps")
} */

//MARK: Type Casting

/*
//declare a super class
class Commuter {
    var efficiency: Int
    init(efficiency: Int){
        self.efficiency = efficiency
    }
}

//two sub classes with unique properties and intializers
class Bike : Commuter {
    var type: String
    init(efficiency: Int, type: String) {
        //set the breed property
        self.type=type
        //pass name to init in super class
        super.init(efficiency: efficiency)
    }
}

class Skates : Commuter {
    var brand: String
    init(efficiency: Int, brand: String) {
        //set the brand property
        self.brand=brand
        //pass the efficiency to init in super class
        super.init(efficiency: efficiency)
    }
}

var myCommuters = [Bike(efficiency: 8, type: "road"), Bike(efficiency: 6, type: "mountain"), Skates(efficiency: 4, brand: "Rollerblade"), Skates(efficiency: 3, brand: "K2")]

var bikeCount = 0
var skateCount = 0
//the "is" operator tests if an object is a certain type and returns true or false
for commuter in myCommuters {
    if commuter is Bike {
        bikeCount += 1
    }
    if commuter is Skates {
        skateCount += 1
    }
}

//the "as?" operator attempts to downcast to a type returns an optional that is nil if downcast was unsuccessful
//needed to work with objects that are subclass types
for commuter in myCommuters {
    if let bike = commuter as? Bike {
        print("Commuter is of type Bike")
    }
    if let skates = commuter as? Skates {
        print("Commuter is of type Skates")
    }
}
 */

//MARK: Closures

//test array
let roster = ["Evan", "Eva", "Tommy", "Tom", "Nicole", "Sharon"]

// **long winded way to sort strings - not good
/*
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedRoster = roster.sorted(by: backward)
print(reversedRoster)
 */

// **use a closure - better
/*
var reversedRoster = roster.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})
print(reversedRoster)
*/

// **utilize implicit return type (only for single expression closure)
/*
var reversedRoster = roster.sorted(by: {s1, s2 in s1 > s2})
print(reversedRoster)
 */

// **shorthand argument names
/*
var reversedRoster = roster.sorted(by: {$0 > $1})
print(reversedRoster)
*/

// ** and the absolute least amount of code - kind of a little overboard if you ask me...
/*
var reversedRoster = roster.sorted(by: >)
print(reversedRoster)
 */

//MARK: Enums
/*
//create enum
enum JobStatus {
    case notStarted
    case inProgress
    case done
}

//example struct that uses it
struct Job {
    var title: String
    var status: JobStatus
}

//example instance
var lab1 = Job(title: "Lab 1", status: JobStatus.notStarted)

//switch statement on the enum - the JobStatus type is implied...
switch lab1.status {
case .notStarted:
    print("Get to work!")
case .inProgress:
    print("I'm working on it")
case .done:
    print("Pay me")
default:
    print("unknown status")
}
*/

//MARK: Errors
/*
//create enum, conform to Error protocol
enum APIError: Error {
    case Forbidden
    case NotFound
    case RequestTimeout
    case UnknownResponse
}

//dummy function to check response -- throws error if response is bad or returns string if response is good or uknown
func checkResponse(status: Int) throws -> String {
    switch status {
    case 403: throw APIError.Forbidden
    case 404: throw APIError.NotFound
    case 408: throw APIError.RequestTimeout
    case 200: return "OK"
    default: throw APIError.UnknownResponse
    }
}

//call the function using a do catch statement and a try keyword
do {
    let status = try checkResponse(status: 400)
    print("Good to go, no worries")
} catch {
    print(error)
}

//better yet, catch specific types of errors and handle each individually
do {
    let status = try checkResponse(status: 404)
    print("Good to go, no worries")
} catch APIError.Forbidden {
    print("You don't have permission to access this resource")
} catch APIError.NotFound {
    print("Couldn't find the resource")
} catch APIError.RequestTimeout {
    print("Took too long to get resource")
} catch APIError.UnknownResponse {
    print("Something went wrong. Don't know what.")
}
*/

//MARK: Guard Statements

/*
//enum for an error
enum MathError: Error {
    case DivideByZero
}

//use a guard statement to exit early if the divisor is 0
func divide(dividend: Double, divisor: Double) throws -> Double {
    guard divisor != 0 else {
        throw MathError.DivideByZero
    }
    return dividend/divisor
}

do {
    print(try divide(dividend: 3, divisor: 0))
} catch MathError.DivideByZero {
    print("Cannot divide by 0!")
}
*/
