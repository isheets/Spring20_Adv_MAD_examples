import kotlinx.coroutines.*
import sun.reflect.annotation.ExceptionProxy
import java.lang.Exception

fun main() {
    /*
    //region: CONSTANTS, VARIABLES, and TYPES

    //variable
    var myVar = 2
    println(myVar)
    myVar += 2
    println(myVar)

    println()

    //constants
    val myConst = 2
    println(myConst)

    //TYPES
    //integer
    val myInt: Int = 4
    val myBillion = 1_000_000_000
    println(myBillion)

    //floating point
    val myDouble: Double = 4.5
    val myFloat: Float = 4.5f

    //boolean
    var myBool: Boolean = true
    myBool = false

    //Char
    val myChar: Char = 'C'
    val newline = '\n'

    //Array
    val intArray = arrayOf(1,2,3,4,5,6)
    intArray.get(1)
    intArray[1]
    intArray.set(1, 10)
    intArray[1] = 10

    val mixedArray = arrayOf('I', "Isaac Sheets", 22, false)

    //Strings
    var myName = "Isaac Sheets"

    //raw strings
    val message = """
        Hi There!
            This is a message
        From:   Isaac
    """.trimIndent()

    println(message)

    val template = "My name is $myName and it is ${myName.length} characters long"
    println(template)

    //NULLABLE TYPES
    var userName: String? = null

    userName = "Isaac"

    //null check
    if (userName != null) {
        println(userName.length)
    } else {
        println("no username")
    }

    //safe call
    println(userName?.length)

    //elvis operator -- defualt value
    println(userName?.length ?: "no username! its null!")

    //!! operator -- discouraged
    println(userName!!.length)

    //endregion

    //region: TYPE CHECKS and CASTING

    //"is" keyword
    var mixedArray = arrayOf("Test string", 'C', 100, 1.5)

    fun stringChecker(x: Any) {
        if(x is String) {
            println("$x has length ${x.length}")
        } else {
            println("$x is not a string")
        }
    }

    mixedArray.map{stringChecker(it)}

    //"as" keyword
    for(item in mixedArray) {
        var cast = item as? String
        println(cast ?: "not a string")
    }

    //endregion


    //region: LOOPS and CONTROLS
    //RANGES
    for(i in 1..5) print("$i ")
    println()
    for(i in 1 until 5) print("$i ")
    println()
    for(i in 1..5 step 2) print("$i ")
    println()
    for(i in 5 downTo 1) print("$i ")
    println()
    println()

    //WHEN EXPRESSION
    val myScore = 110
    val highScore = 100

    when(myScore) {
        in 0 until highScore -> println("below high score")
        highScore -> println("at high score")
        else -> println("new high score!")
    }

    println()

    //FOR LOOPS
    val fruits = arrayOf("Apples", "Oranges", "Bananas", "Cherries")

    for(fruit in fruits) {
        println("Current fruit: $fruit")
    }

    for((i, fruit) in fruits.withIndex()) {
        println("Fruit #$i: $fruit")
    }

    for(i in fruits.indices) {
        println("Fruit #$i: ${fruits[i]}")
    }

    //WHILE
    var loop = 5

    while (loop > 0) {
        println(loop)
        loop--
    }

    //endregion

    //region: COLLECTIONS
    //LISTS
    val myList = mutableListOf(1,2,3,4,5,6,7,7,7)
    myList[0] = 10
    myList.add(2, 100)

    //SETS
    val mySet = mutableSetOf(1,1,1,2,2,3,4,5,5,6,6,6)
    mySet.add(7)
    mySet.map {print("$it ")}

    println()

    myList.toSet().map{"$it "}

    //MAP
    var myMap = mutableMapOf("one" to 1, "two" to 2, "three" to 3)
    myMap["four"] = 4

    println()

    for(pair in myMap.entries) {
        println("${pair.key} to ${pair.value}")
    }

    //endregion


    //region: FUNCTIONS and LAMBDAS

    fun add(x: Int, y: Int): Int {
        println("Adding $x + $y")
        return x+y
    }

    println(add(2,3))

    fun quickAdd(x: Int, y: Int) = x + y
    println(quickAdd(2,4))

    fun printGreeting(name: String, senderName: String = "A friend", message: String = "") {
        println("Hello $name! $message From: $senderName")
    }

    printGreeting("Bob")
    printGreeting(name = "Bill", message = "Hope you're well!")
    printGreeting("Bill","Isaac", "Hope you're well")

    //LAMBDAS
    val nums = setOf(1,6,3,-10,110,10000000, 355,87)
    var highNums = nums.filter { item -> item >= 100  }

    nums.map{print("$it, ")}
    println()
    highNums.map{print("$it, ")}

    //named lambda
    val filterLam: (Int) -> Boolean = {item: Int -> item <= 100}
    val lowNums = nums.filter(filterLam)

    println()
    lowNums.map{print("$it, ")}


    highNums = nums.filter { it >= 100 }
    println()
    highNums.map{print("$it, ")}

    //endregion


    //region: CLASSES

    class Instrument {}

    var myInstrument = Instrument()

    open class Food constructor (var name: String, var calories: Int) {

        var rating: Double? = null

        //secondary constructor
        constructor(name: String, calories: Int, rating: Double) : this(name, calories) {
            this.rating = rating
        }


        init {
            println("init your $name")
        }

        fun eat() {
            println("Eating $name, yummy yum")
        }

        override fun toString(): String {
            return "$name, $calories, ${rating ?: "no rating"}"
        }

    }

    var oatmeal = Food("oatmeal", 500)
    var carrot = Food("carrot", 80, 8.5 )
    println(oatmeal)
    println(carrot)
    oatmeal.eat()

    class Snack(name: String, calories: Int, var category: String = "Snack") : Food(name, calories) {

        constructor(name: String, calories: Int, category: String = "Snack", rating: Double) : this(name, calories, category) {
            this.rating = rating
        }

        init {
            println("making a fun snack")
        }

    }

    var hummus = Snack("hummus", 200, rating = 10.0)
    println(hummus)
    hummus.eat()

    println()

    //DATA CLASS
    data class User(val id: Int, val name: String, val email: String)

    var user1 = User(1, "John", "john@gmail.com")
    var user2 = User(1, "John", "john@gmail.com")

    println(user1)
    println(user1 == user2)

    //destructure instance of data class
    val (id, name, email) = user1

    println(id)
    println(name)
    println(email)

    //endregion


    //region: COROUTINES
    println("before launching coroutine")

    GlobalScope.launch {
        println("in coroutine")
        delay(3000)
        println("coroutine done")
    }

    println("coroutine launched, waiting for result....")
    Thread.sleep(4000L)

    runBlocking {

        var asyncJob = GlobalScope.launch {
            println("in coroutine")
            delay(3000)
            println("coroutine done")
        }

        println("launched coroutine")
        asyncJob.join()
        println("continuing execution")

    }

    //endregion

    */

    //region: EXCEPTIONS

    class MathError(message: String): Exception(message)

    fun divide(dividend: Double, divisor: Double):Double {

        if (divisor == 0.0) {
            throw MathError("Can't divide by 0")
        } else {
            return dividend/divisor
        }
    }

    try {
        val result = divide(50.0, 0.0)
        println("division success")
    } catch (e: Exception){
        println("Bad division! ${e.toString()}")
    } finally {
        println("I'm done trying")
    }



    //endregion
}