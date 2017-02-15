package test_classes.block.packages

import test_classes.block.Block

class PackageBlock(var directory: String) extends Block(null, true, false) {

  def init() {}

  def getName: String = directory

  def getValue: String = null

  def getType: String = "package"

  def getOpeningCode: String = ""

  def getClosingCode: String = ""

  override def toString: String = "package: " + directory

}