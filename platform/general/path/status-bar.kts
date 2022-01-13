#!/usr/bin/env kscript 

//DEPS com.diogonunes:JColor:5.2.0
//DEPS org.json:json:20211205

import java.io.File

import com.diogonunes.jcolor.Ansi.colorize
import com.diogonunes.jcolor.Attribute.*
import org.json.JSONObject

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

// Read current config file
val configStr: String = File("${System.getenv("HOME")}/.zsh_scripts/config.json").readText(Charsets.UTF_8)
val config = JSONObject(configStr)


// Populate the map of tokens to print
val stats: Map<String, String> = mapOf(
    "project" to dirName,
    "git_context" to config.getString("git_context")
)

println(stats.map { (k, v) -> "$k:${colorize("$v", BLUE_TEXT())}" }.joinToString("  "))