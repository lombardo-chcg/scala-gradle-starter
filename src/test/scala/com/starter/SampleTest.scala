package com.starter

import org.scalatest.{FlatSpec, Matchers}

class SampleTest extends FlatSpec with Matchers {
  "com.starter" should "run a sample test" in {
    7 + 9 should be(16)
  }
}
