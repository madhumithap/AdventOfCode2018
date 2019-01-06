import java.util.*

data class ReposeRecord(val date: Date,
                        val statement: String) {
    fun isGuardBeginningShift(): Boolean {
        return statement.startsWith("Guard")
    }

    fun isGuardFallingAsleep(): Boolean {
        return statement.startsWith("falls")
    }

    fun isGuardWakingUp(): Boolean {
        return statement.startsWith("wakes")
    }

    fun getGuardId() : Int? {
        val guardIdString = statement.substringAfter('#').substringBefore(' ')
        return if (statement.length != guardIdString.length) guardIdString.toInt() else null
    }
}