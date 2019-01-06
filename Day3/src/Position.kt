data class Position(val x: Int,
                    val y: Int) {
    override fun equals(other: Any?): Boolean {
        val position = other as? Position
        position?.let {
            return this.x == it.x && this.y == it.y
        }
        return false
    }

    override fun hashCode(): Int {
        var result = x
        result = 31 * result + y
        return result
    }

    fun plus(x: Int, y: Int): Position {
        return Position(this.x + x, this.y + y)
    }

    override fun toString(): String {
        return "Position(x=$x, y=$y)"
    }


}