import UIKit

//*************************************
//MARK: String Literals and Raw Strings

//string literal (interpolation is still supported the same way as regular string)
/* let multiline = """
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
print(rawLiteral) */

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
//show intial print statment format
print("""
Beverages:
\(coffee)
\(tea)
""")

//extend the String.StringInterpolation
extension String.StringInterpolation {
    //use the mutating keyword since we are modifything the properties of a value type (String is a struct)
    mutating func appendInterpolation(_ value: MenuItem) {
        appendInterpolation("\(value.name)......$\(value.price)")
    }
}
*/

//MARK: Optionals — review



//MARK: Type Casting

//MARK: Closures

//MARK: Enums

//MARK: Errors

//MARK: Guard Statements
