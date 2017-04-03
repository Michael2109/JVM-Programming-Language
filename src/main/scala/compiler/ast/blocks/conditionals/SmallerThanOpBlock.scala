/*
 * Cobalt Programming Language Compiler
 * Copyright (C) 2017  Cobalt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package compiler.ast.blocks.conditionals

import compiler.ast.blocks.Block

/**
  * Represents checking if equal - "=="
  *
  * @param superBlockInit The parent block
  */
class SmallerThanOpBlock(var superBlockInit: Block) extends AbstractConditionalBlock(superBlockInit, false, false) {

  def getName: String = ""

  def getValue: String = ""

  def getOpeningCode: String = {
    "IF_ICMPGE"
  }

  def getClosingCode: String = {
    ""
  }

  override def toString: String = getType

  def getType: String = "<SMALLER_THAN_OP>"


}