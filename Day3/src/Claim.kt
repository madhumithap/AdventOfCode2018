data class Claim(
    val id: String,
    val position: Position,
    val width: Int,
    val height: Int
) {

    fun getRectangle(): List<Position> {
        val claimPositions: ArrayList<Position> = arrayListOf()
        for (i: Int in 1..width) {
            for (j: Int in 1..height) {
                claimPositions.add(position.plus(i, j))
            }
        }
        return claimPositions
    }
}