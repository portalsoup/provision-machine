#!/usr/bin/env kscript 

// https://mvnrepository.com/artifact/com.diogonunes/JColor
//DEPS com.diogonunes:JColor:5.2.0

import com.diogonunes.jcolor.Ansi.colorize
import com.diogonunes.jcolor.Attribute.*

fun runCmd(cmd: String, vararg args: String): List<String> {
    return ProcessBuilder(cmd, *args).start().inputStream.reader(Charsets.UTF_8).readLines()
}

if (args.joinToString(" ").contains("help")) {
    println(
        """
            Print a single row of key/value pairs with each value colored ${colorize("blue", BLUE_TEXT())}
        """.trimIndent()
    )

    System.exit(0)
}

val pwd = runCmd("pwd").first()
val dirName = runCmd("basename", pwd).first()

val stats: Map<String, String> = mapOf(
    "project" to dirName,
    "git-context" to System.getenv("GIT_CONTEXT")
)

println(stats.map { (k, v) -> "$k:${colorize("$v", BLUE_TEXT())}" }.joinToString("  "))