
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

    */


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

}