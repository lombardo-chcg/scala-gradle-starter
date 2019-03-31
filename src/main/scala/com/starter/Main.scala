package com.starter

import org.apache.logging.log4j.LogManager

object Main {
  def main(args: Array[String]) {
    val log = LogManager.getLogger(this.getClass)
    log.info("Hello from Gradle starter pack! 🚀")
  }
}
