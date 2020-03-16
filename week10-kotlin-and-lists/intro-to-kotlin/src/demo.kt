import kotlin.reflect.typeOf

//the main function is the entry point to our program
fun main() {
    //region: constants, variables, and types

    //region: var and val
    //variables (implicit type of Int)
    var myVar = 2 //implicit type (int)
    println(myVar)
    myVar += 2
    println(myVar)

    //constants use val keyword
    val myConst = 2 //implicit type (int)
    println(myConst)
    //can't change a constant! next line won't compile
    //myConst += 2

    //endregion


    //region: basic types (explicitly typed)

    //Integers
    val myInt: Int = 4
    //for larger numbers you can use underscores to make them more readable
    val oneBillion = 1_000_000_000
    println(oneBillion)
    //double (default inferred for floating-point numbers
    val myDouble: Double = 4.50
    //float (if you specifically need a Float you must explicitly ask for it by appending "f" to the number like so)
    val myFloat: Float = 4.5f

    //Booleans
    var myBool = true
    myBool = false
    println(myBool)

    //Chars - single quotes
    var myChar = 'I'
    //use backslash to escape special characters (standard practice)
    var myNewLine = '\n'
    println("$myNewLine $myChar $myChar $myNewLine $myChar")

    //Arrays - immutable size, mutable data, can be mixed type
    //array of ints
    val myIntArray = arrayOf(1,2,3,5)
    //accessing and modifying using getters and setters
    println(myIntArray.get(1))
    myIntArray.set(1, 10)
    //access using index
    println(myIntArray[1])

    //array of mixed type
    var myCharArray = arrayOf('I', 'S', 'A', 'A', 'C', "Sheets", 22)

    //Strings
    var myName = "Isaac Sheets"
    myName = "Isaac C. Sheets"
    println(myName)

    //string literal
    //raw string (preserve white space and new lines)
    val message = """
    Hi there! 
        This is a message
            From:    Isaac
    """//.trimIndent()
    println(message)

    //string template (variables or expressions in strings)
    val template = "My name is $myName and it is ${myName.length} characters long"
    println(template)

    //endregion

    //region: nullable types and checking
    //must have explicit type with question mark to hold a null value
    var score: Int? = null

    //null check (fails)
    if (score != null) {
        println("Score: $score")
    } else {
        println("score is null")
    }

    score = 80

    if (score != null) {
        println("Score: $score")
    }

    score = null

    //safe call (returns result or null)
    println("Safe Call")
    println(score?.minus(10)) //can chain as many safe calls together as necessary

    //elvis operator -- or default value
    println("Elvis Operator:")
    println(score?.minus(10) ?: 10)

    //!! operator -- force not null assertion
    

    //endregion

    //endregion
}