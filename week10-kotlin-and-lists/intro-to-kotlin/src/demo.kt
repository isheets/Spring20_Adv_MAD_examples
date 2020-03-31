import kotlinx.coroutines.*
import java.lang.Exception

//the main function is the entry point to our program
fun main() {
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

    //region: COLLECTIONS

    //LIST
    //immutable (can only perform read operations)
    val myList = listOf(1,2,3,4,5,6,5,4,3,2,1)
    //myList[0] = 10 //won't compile since this list is read-only
    println(myList[0])

    //mutable list (can perform read AND write operations)
    val myMutableList = mutableListOf(1,2,3,4,5,6)
    myMutableList[0] = 10
    println(myMutableList[0])

    //SETS - not necessarily ordered
    //immutable
    val mySet = setOf(1,2,3,4,5,6,6,6,6) // create mutable set using mutableSetOf()
    mySet.map{println(it)}

    //list to set
    val uniqueList = myList.toSet()
    myList.map{print(it)}
    println()
    uniqueList.map{print(it)}
    println('\n')

    //MAPS
    var myMap = mutableMapOf("one" to 1, "two" to 2, "three" to 3)
    myMap["four"] = 4

    for(pair in myMap.entries) {
        println("${pair.key} to ${pair.value}")
    }

    //endregion

    //region: FUNCTIONS and LAMBDAS

    //NOTE: these are all local scope functions meaning they are functions within a function (inside of the main() function)
    //syntax for member functions (inside classes) and top level functions (not inside anything) is the same

    //basic syntax = "fun functionName(parameter1: Type, parameter2: Type): ReturnType {}
    fun add(x: Int, y: Int): Int {
        println("Adding $x + $y")
        return x+y
    }

    //single expression function with implicit return type
    fun quickAdd(x: Int, y: Int) = x + y

    println(add(2,2))
    println(quickAdd(3,3))

    //default, named arguments
    fun printGreeting(name: String, senderName: String = "A friend", message: String = "" ) {
        println("Hello $name! $message From: $senderName")
    }

    printGreeting("Bob")
    printGreeting(name = "Bill", message = "Hope you're well.")
    printGreeting(name = "mary", senderName = "Isaac")

    println()

    //LAMBDAS
    //functions that are not declared but passed immediately as expressions
    val nums = setOf(1, 6, 3, 22, 10_000, 0, -300, 100, 355, 87)
    //filter the list to only have items greater than 100
    var highNums = nums.filter {item -> item >= 100 }


    //printing using the map() function is actually another example of a lambda!
    nums.map { print("$it ,") }
    println()
    highNums.map {print("$it ,")}

    //alternate syntax for lambdas
    //named lambda

    //named lambda (longest syntax, same result)
    val filterLam: (Int) -> Boolean = { item: Int -> item >= 100 }
    highNums = nums.filter(filterLam)

    //using implicit parameter name (works when it only takes a single parameter)
    //shortest syntax, same result
    highNums = nums.filter { it >= 100 }

    //endregion

    //region: CLASSES and INTERFACES

    //plain class, no constructor
    class Instrument {

    }
    //empty instance
    var myInstrument = Instrument()

    //class with primary constructor
    open class Food constructor (var name: String, var calories: Int) {

        //private property
        var rating: Double? = null

        //public method
        fun eat() {
            println("eating $name, yummy yum")
        }

        //init
        init {
            println("init your $name!")
        }



        //secondary constructor to add a rating
        constructor(name: String, calories: Int, rating: Double) : this(name, calories) {
            this.rating = rating
        }

        //override the toString()
        override fun toString(): String {
            return "$name, $calories, ${rating ?: "no rating"}"
        }
    }
    //oatmeal instance
    var oatmeal = Food("oatmeal", 500)
    //hummus instance
    var carrot = Food("carrot", 50, 8.0)

    println(oatmeal)
    println(carrot)

    carrot.eat()

    //inheritance (add open keyword to parent class)
    class Snack(name: String, calories: Int, var category: String = "Snack") : Food(name, calories) {

        //secondary constructor for rating functionality
        constructor(name: String, calories: Int, category: String = "Snack", rating: Double): this(name,calories,category) {
            this.rating = rating
        }
        init {
            println("making a fun snack: $name")
        }

    }

    var hummus = Snack("Hummus", 200, rating = 10.0)

    hummus.eat()
    println(hummus)

    println()

    //DATA CLASSES

    data class User(val id: Int, val name: String, val email: String)

    var user1 = User(1,"John", "password123")
    var copyUser1 = User(1, "John", "password123")

    println(user1)
    println(user1 == copyUser1)

    //destructure
    val (id, name, email) = user1

    //endregion

    //region: COROUTINES
    //basic example
    println("before launching coroutine")

    GlobalScope.launch { // new coroutine in background
        println("in coroutine")
        delay(1000) //non-blocking suspension of coroutine execution
        println("coroutine done")
    }

    println("Coroutine launched, waiting for result")
    Thread.sleep(2000L) //sleep the execution of the application so it keeps everything alive until coroutine finishes

    println()
    //better example
    runBlocking{ //start a new blocking coroutine on the current thread (main in our case)
        var asyncJob = GlobalScope.launch { // new coroutine in background
            println("starting coroutine code")
            delay(1000) //non-blocking suspension of coroutine execution
            println("coroutine done")
        }

        println("launched coroutine")
        asyncJob.join()
        println("continuing execution")
    }

    // 

    //region: EXCEPTIONS

    //custom type
    class MathError(message: String): Exception(message)

    fun divide(dividend: Double, divisor: Double): Double {

        if (divisor == 0.0) {
            throw MathError("Can't divide by 0!")
        }
        else {
            return dividend/divisor
        }

    }

    try {
        val result = divide(50.0, 0.0)
        println("Successful division: $result")
    } catch (e: Exception){
        println("Bad division! ${e.toString()}")
    } finally {
        println("I'm done trying")
    }
    //endregion
}
