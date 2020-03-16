import kotlin.reflect.typeOf

//the main function is the entry point to our program
fun main() {
    /*
    //region: CONSTANTS, VARIABLES, AND TYPES

    //region: VAR AND VAL
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


    //region: BASIC TYPES (explicitly typed)

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

    //region: NULLABLE TYPES AND CHECKING
    //must have explicit type with question mark to hold a null value
    var score: Int? = null

    //null check (fails)
    if (score != null) {
        println("Score: ${score.minus(10)}")
    } else {
        println("score is null")
    }

    //give score a value
    score = 80

    //null check (succeeds)
    if (score != null) {
        //compiler remembers that we checked null so we can access methods/properties of score inside this block
        println("Score: ${score.minus(10)}")
    }

    score = null

    //safe call (returns result or null)
    println("Safe Call")
    println(score?.minus(10)) //can chain as many safe calls together as necessary

    //elvis operator -- or default value
    println("Elvis Operator:")
    println(score?.minus(10) ?: 10)

    //!! operator -- force not null assertion -- BAD
    //println("Score: ${score!!.toString()}") //causes Runtime Error - Null Pointer Exception :(
    //endregion

    //endregion

    //region: TYPE CHECKS AND CASTING

    //is keyword -- checks type and automatically casts in most cases
    var mixedArray = arrayOf("Test string", 'C', 1_000, 1.00)

    fun typeChecker(x: Any) {
        if(x is String) {
            println("String has length ${x.length}") //x is automatically cast to string
        }
        else {
            println("$x is not a string")
        }
    }

    //check types of each element in array
    mixedArray.map{typeChecker(it)}

    //as (unsafe) and as? (safe) keyword to cast to specific type
    for(item in mixedArray) {
        var cast = item as? String //change to as and see what happens
        if(cast != null) {
            println("successfully cast $cast as String")
        }
    }

    //endregion

    //region: LOOPS and EXPRESSIONS

    //RANGES
    //Kotlin uses ".." syntax and
    for(i in 1..5) println(i)
    println()
    for(i in 1 until 5) println(i)
    println()
    for(i in 1..5 step 2) println(i)
    println()
    for(i in 5 downTo 1) println(i)
    println()


    //WHEN EXPRESSIONS
    val myScore = 80
    val highScore = 120

    //replaces a C style switch statement
    when(myScore) {
        in 0 until highScore -> println("current score less than high score")
        highScore -> println("new high score!")
        else -> println("above high score")
    }
    println()

    //FOR LOOPS
    val fruits = arrayOf("Apples", "Bananas", "Strawberries", "Cherries", "Raspberries")

    //basic syntax
    for(fruit in fruits) {
        println("Current fruit: $fruit")
    }
    println()

    //get the index of the iterator
    for((i, fruit) in fruits.withIndex()) {
        println("Fruit #$i: $fruit")
    }

    println()

    //use indices
    for(i in fruits.indices) {
        println("Fruit #$i: ${fruits[i]}")
    }
    println()

    //WHILE LOOPS
    //nothing new here
    var loop = 5
    while(loop > 0) {
        println(loop)
        loop--
    }

    //endregion
    */

    //region: COLLECTIONS

    //LIST
    val myList = listOf(1,2,3,4,5,6)
    //myList[0] = 10 //won't compile since this list is read-only

    val myMutableList = mutableListOf(1,2,3,4,5,6)
    myMutableList[0] = 10



    //endregion
}
