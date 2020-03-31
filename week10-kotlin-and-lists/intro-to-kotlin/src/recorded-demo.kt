
//entry point for program
fun main() {

    //region: CONSTANTS, VARIABLES, and TYPES

    //VARIABLES
    var myVar = 2 //implicit type of Int
    println(myVar)
    myVar += 2
    println(myVar)

    println()

    //CONSTANT
    val myConst = 2 //inferred int type
    println(myConst)

    //TYPES
    //integers
    val myInt: Int = 4
    val oneBillion: Int = 1_000_000_000
    println(oneBillion)

    //floating types
    val myDouble: Double = 4.5
    val myFloat: Float = 4.5f

    //boolean
    var myBool = true
    myBool = false

    //Char - single quotes
    var myChar = 'I'
    var newline = '\n'
    print(myChar)
    print(newline)
    print(newline)

    //Array
    val myIntArray = arrayOf(1,2,3,4,5)
    println(myIntArray.get(1))
    myIntArray.set(1, 10)
    println(myIntArray[1])

    val myMixedArray = arrayOf('I', 'S', 'A', 'A', 'C', 22, "Sheets")

    println()

    //Strings
    var myName: String = "Isaac Sheets"
    myName = "Isaac C. Sheets"
    println(myName)

    //string literals
    val message = """
        Hi There!
            This is a message!
        From:
                    Isaac
    """.trimIndent()

    println(message)

    //string template
    val template = "Hi my name is $myName and it is ${myName.length} character long"
    println(template)
    println()

    //NULLABLE TYPES and SAFETY
    var score: Int? = null

    score = 80

    if (score != null) {
        println("Score: ${score.minus(10)}")
    } else {
        println("score is null")
    }

    score = null

    //safe call
    println("Safe call: ")
    print(score?.minus(10)) //can chain as many together

    //elvis operator -- or default value
    println("Elvis Operator")
    println(score?.minus(10) ?: 10)

    //!! operator -- BAD
    println("Score: ${score!!.toString()}")

    //endregion

}