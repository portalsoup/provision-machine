#!/usr/bin/env kscript 

//DEPS org.json:json:20211205

import java.io.File

import org.json.JSONObject

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

// Read current config file
val contextFile = File("${System.getenv("HOME")}/.zsh_scripts/context.json")
val contextStr: String = contextFile.readText(Charsets.UTF_8)
val context = JSONObject(contextStr)

// add or update key
context.put(args[0], args[1])

// write new context back
contextFile.writeText(context.toString())