#!/usr/bin/env kscript 

import kotlin.random.Random

if (args.joinToString(" ").contains("help")) {
    println(
        """
        Roll dice. 

        {rolls}d{faces} {command}

        Specify a command to perform operations on the results:

            sum - Sum all the rolls together
            average - Display the average of all rolls as a floating point

        Example:

            3d5 - throw three 6 faced die
            10d2 average - throw ten 2 sided die and calculate the average between throws

        """.trimIndent()
    )

    System.exit(0)
}

// matches a format like: `2d20 sum average`
val regex = Regex("(\\d+)d(\\d+)\\s*(.*)")

val argsStr = args.joinToString(" ")
val match = regex.find(argsStr) ?: throw RuntimeException("Invalid format")
val die = match.groupValues[1].toInt()
val faces = match.groupValues[2].toInt()
val commands: List<String> = match.groupValues[3]?.split(" ") ?: emptyList()

println("rolled $die die with $faces sides")

val results = 1.rangeTo(die)
    .map { Random.nextInt(faces) + 1 } 

println("Rolled: $results")

if (commands.contains("sum")) {
    val summed = results.fold(0) { acc: Int, next: Int -> acc + next }
    println("The sum of all rolls is $summed")
}

if (commands.contains("average")) {
    val averaged = results.average()
    println("The average of all rolls is $averaged")
}