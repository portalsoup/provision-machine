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
            Create or update a single key/value pair in the context file
        """.trimIndent()
    )

    System.exit(0)
}

if (args.size < 2) {
    println("Need both a key and a pair")
    System.exit(1)
}

val pwd = runCmd("pwd").first()
val dirName = runCmd("basename", pwd).first()

// Read current config file
val contextFile = File("${System.getenv("HOME")}/.zsh_scripts/context.json")
val contextStr: String = contextFile.readText(Charsets.UTF_8)
val context = JSONObject(contextStr)

// add or update key
context.put(args[0], args[1])

contextFile.writeText(context.toString())