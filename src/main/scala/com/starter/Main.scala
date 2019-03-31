package com.starter

import org.apache.logging.log4j.LogManager

object Main {
  def main(args: Array[String]) {
    val log = LogManager.getLogger("com.starter.Main")
    log.info("scala-gradle-starter 🚀")
  }
}
