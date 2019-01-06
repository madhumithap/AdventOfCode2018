import java.util.*

fun getMinutes(date: Date): Int {
    val calendar = Calendar.getInstance()
    calendar.time = date
    return calendar.get(Calendar.MINUTE)
}