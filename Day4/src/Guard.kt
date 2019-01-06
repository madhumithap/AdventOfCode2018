import java.util.*

data class Guard(val id: Int,
                 var latestSleepStartTime: Date? = null,
                 var totalSleptTimeInMinutes: Int = 0,
                 val sleepMap: HashMap<Int, Int> = initSleepMap()) {

    fun wakeUp(date: Date) {
        latestSleepStartTime?.let {
            val wakeUpMinute = getMinutes(date)
            val sleepStartMinute = getMinutes(it)
            totalSleptTimeInMinutes += wakeUpMinute - sleepStartMinute
            updateSleepMap(sleepStartMinute, wakeUpMinute)
        }
    }

    private fun updateSleepMap(sleepStartMinute: Int, wakeUpMinute: Int) {
        (sleepStartMinute until wakeUpMinute).forEach { minute ->
            sleepMap[minute]?.let { numberOfTimesSlept ->
                sleepMap[minute] = numberOfTimesSlept + 1
            }
        }
    }

    fun maximumSleptMinute(): Int {
        return sleepMap.entries.maxBy { it.value }?.key ?: run { 0 }
    }

    fun mostFrequentlySleptMinuteWithTimes(): Pair<Int, Int>? {
        return sleepMap.entries.maxBy { it.value }?.let {
            Pair(it.key, it.value)
        } ?: run { null }
    }
}

fun initSleepMap(): HashMap<Int, Int> {
    val map: HashMap<Int, Int> = hashMapOf()
    (0..59).forEach { map[it] = 0 }
    return map
}
