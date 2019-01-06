fun main(args: Array<String>) {
    val boxIds = getBoxIds()
    val checkSum = computeCheckSum(boxIds)
    println("checksum is $checkSum")
    val boxId = findBoxWithPrototypeFabric(boxIds)
    println("correct box id is $boxId")
}

fun computeCheckSum(boxIds: List<String>): Int {
    var numberOfTwos = 0
    var numberOfThrees = 0
    boxIds.forEach { boxId ->
        val letterCountMap: HashMap<Char, Int> = hashMapOf()
        boxId.forEach { character ->
            letterCountMap[character]?.let {
                letterCountMap[character] = it + 1
            } ?: run {
                letterCountMap[character] = 1
            }
        }
        var encounteredTwo = false
        var encounteredThree = false
        letterCountMap.values.forEach {
            if (it == 2 && !encounteredTwo) {
                numberOfTwos ++
                encounteredTwo = true
            }
            if (it == 3 && !encounteredThree) {
                numberOfThrees ++
                encounteredThree = true
            }
        }
    }
    return numberOfTwos * numberOfThrees
}

fun findBoxWithPrototypeFabric(boxIds: List<String>) : String {
    val length = boxIds[0].length
    for (i: Int in 0 until boxIds.size) {
        for (j : Int in i+1 until boxIds.size) {
            val commonSubString = getCommonSubString(boxIds[i], boxIds[j])
            if (commonSubString.length == length-1) {
                return commonSubString
            }
        }
    }
    return ""
}

fun getCommonSubString(s1: String, s2: String) : String {
    var commonString = ""
    s1.forEachIndexed { index, character ->
        if (character == s2[index]) commonString += character
    }
    return commonString
}

fun getBoxIds() : List<String> {
    return arrayListOf(
        "qwubbihrkplymcraxefntvdzns",
        "qwugbihrkplyzcjahefttvdzns",
        "qwugbihrkplymcjoxrsotvdzns",
        "qwugbphrkplympjaxmfotvdzns",
        "qwugbghrkpltbcjaxefotvdzns",
        "qwubbihrwpuymcjaxefotvdzns",
        "qiugpihrkplymcwaxefotvdzns",
        "qwugbihrkplymcjavefotvotns",
        "qwugbihrkpvymcjaxefotvnzes",
        "qwvgbihrkpltmcnaxefotvdzns",
        "qwugvihrkplymvjaxefotvczns",
        "qwugbihrkplymwjazefotvyzns",
        "qwugbihrkplbmcjbxefttvdzns",
        "qhugbihrkplymcjaxefotnazns",
        "qwugbihrkpyyacjacefotvdzns",
        "qwugsihrkpsymcjaxafotvdzns",
        "qwugbihriplymcjixefosvdzns",
        "qwuibihrkjlvmcjaxefotvdzns",
        "qwugbjhrgplymcjaxefotvdzys",
        "qwugnimrkplymcjayefotvdzns",
        "qwumjihrkplymcjexefotvdzns",
        "qwugbihukptymcjaxefotvvzns",
        "qwughthrgplymcjaxefotvdzns",
        "qlugbihrkplymcjbxhfotvdzns",
        "qhugbiyrkplymcjaxefotvdzes",
        "qwugbihrkvlymcjaxecotvtzns",
        "qwugbihrkphymcjaxefitvizns",
        "qwugbbhdtplymcjaxefotvdzns",
        "qwugbihrkplymceaxefotvltns",
        "mwugbihrkptymcpaxefotvdzns",
        "qwugbihrdplymcvaxefotvdwns",
        "qwugbihrkplymcjaxekhtvhzns",
        "qjugbihrkplyjcjaxefonvdzns",
        "qwugbihrjplymcjaxefgtudzns",
        "qlugbihrkplymcjaxefztvdpns",
        "qwugbihrkclyvpjaxefotvdzns",
        "qwugbihrsplymnjhxefotvdzns",
        "qwudbihrbxlymcjaxefotvdzns",
        "qwugbihrkplymcjxxefatvdzng",
        "qwujbihrkplyqdjaxefotvdzns",
        "qwugnihrkplamcjaxefotvmzns",
        "qwugnihrkplymcjajekotvdzns",
        "qwugbihrkslymcjamsfotvdzns",
        "fwugbihrkplymcjaxetotvdzne",
        "qwughihrkplyucfaxefotvdzns",
        "qwuebihrkplymcraxefotvdzgs",
        "qwugbinrkplymcjaxefodvdznh",
        "qwudbihrkplymcjsxefotvjzns",
        "qwlgbihrkzlymcjixefotvdzns",
        "qwugbihckpoymcpaxefotvdzns",
        "qwfgbibskplymcjaxefotvdzns",
        "qwugbihrkplymczaxdfotvuzns",
        "qwugbihwkplymcjaxepxtvdzns",
        "qwubbihrkplymcjaxefntfdzns",
        "qwunbihrkpaymcjaxefotvdzni",
        "qwugfihrkplymujaxefotvdzni",
        "qwugrihrkplymkjaxxfotvdzns",
        "ztugbihrkplymcjaxefotvdznt",
        "qwugbihrkplvmcjaxefotvdzph",
        "qwugtinrfplymcjaxefotvdzns",
        "qwugbihrkplamcjkmefotvdzns",
        "qwtgbihryplymcjaxeeotvdzns",
        "qwugbiazkplymhjaxefotvdzns",
        "pwugbihrkplymklaxefotvdzns",
        "wwugbihkxplymcjaxefotvdzns",
        "dwugbihrgpdymcjaxefotvdzns",
        "qwulbihrkplymcjaxefoqvqzns",
        "qvugbihrkplyhcjtxefotvdzns",
        "qwugbihrkplymcjaxcfotvfzjs",
        "qwugbihrkpkymyjaxdfotvdzns",
        "qwugbinrkplymcjswefotvdzns",
        "qcuguiqrkplymcjaxefotvdzns",
        "qwugbihlkplyccjaxefrtvdzns",
        "qwugbihpkplomcjaxefotvdhns",
        "qwggbphrkplymcjaxbfotvdzns",
        "qwuipihrkplymcjaxefotvdznt",
        "qwugbihrhplyccjaxeforvdzns",
        "qwugbdhrkplymcjdxefotvdznv",
        "qwugbihrkplymcjaxefotvbfos",
        "qwugtihrkplymcocxefotvdzns",
        "qwugbihrkpljmcjaxwfovvdzns",
        "qwugbnhrkplymcjaxefotvdxnm",
        "qwugbihrkpeymcjauefotvlzns",
        "qwugbihjkplymcraxefftvdzns",
        "qwugbghrkplymcjaxefotvizni",
        "qwwgbihrkplymcjrxefotvrzns",
        "qwugbihrkplymzjawexotvdzns",
        "qwugnihrkplymcjpxnfotvdzns",
        "qwugbihrkdlytcjaxecotvdzns",
        "qwugbihrkacymdjaxefotvdzns",
        "qlugbehrkplymcjaxzfotvdzns",
        "fwugbihrkplymcjamefotldzns",
        "qwugbihrkplymcjarefotlszns",
        "qwsgbihrkpnymcjfxefotvdzns",
        "awuubihrkplymcjaxefrtvdzns",
        "qwngbihrkpjtmcjaxefotvdzns",
        "qwugbihrkpltmkjaxefytvdzns",
        "ewugbihrkplymcjvxefotvdzus",
        "qwugbihrpplymcjaxsfmtvdzns",
        "qwrgbihrmplymcjaxefutvdzns",
        "qwugbihrknxymcwaxefotvdzns",
        "qwugbnurkplymcjabefotvdzns",
        "qwugbihrkphomfjaxefotvdzns",
        "qwugbchrkplymcjaxefctvdens",
        "qwugbidrkplymcjaxefotwwzns",
        "qwggbohrkplgmcjaxefotvdzns",
        "nwkgbihrkplymcjaxqfotvdzns",
        "qwuibihrkpnymajaxefotvdzns",
        "qwugsihrzplymujaxefotvdzns",
        "qwugbihrkplumcgaxefodvdzns",
        "qwugbqhrkplymcjaxefotvddts",
        "qwugbiorkpvyacjaxefotvdzns",
        "bjugbihukplymcjaxefotvdzns",
        "qwugbyhrkplymxjaxexotvdzns",
        "vwugbihrkplymcraxefotgdzns",
        "qwugbihrkplymjwaxeaotvdzns",
        "qwpsbihrkplykcjaxefotvdzns",
        "qwugbqhrkplymcjaxefotgdzno",
        "qwugbjhrkplymcjaxefatvczns",
        "qwuglihrkclymcjvxefotvdzns",
        "qjugbihrkpsymcjajefotvdzns",
        "qwugbinrkptymcjaxedotvdzns",
        "qwurbihrkglymcjaxefomvdzns",
        "qfugbihrsxlymcjaxefotvdzns",
        "lwuggihrkplymcjaxefotvdzds",
        "qwugbihrkplymcjhxwfjtvdzns",
        "qwugbhjrkplymcjaxefotvdyns",
        "qwugbihrkplymcjoxefepvdzns",
        "awwgbihryplymcjaxefotvdzns",
        "qpugbihrkplymcjaxekorvdzns",
        "qwulbihrkplymcuapefotvdzns",
        "qwugbwhrkplymljaxefotvdrns",
        "qwugxihrkplymjjalefotvdzns",
        "qwugbmhrkplymcjyxefotvdnns",
        "qwugbihrkplymcjnxgfotsdzns",
        "qwygbihrkplsmczaxefotvdzns",
        "qwugbihrkplymqjaxefovgdzns",
        "qwuwbihrkplymcjaxefktvdznu",
        "qwugbihrkplyfcjaxeoowvdzns",
        "qwufbiyrkplymcjaxedotvdzns",
        "qwusbirrkplymcjaxefotvdlns",
        "qwurbihroplymtjaxefotvdzns",
        "qiugbihrkplymcjaxefvtvmzns",
        "qwugrihrkflymcjaxefotvdzls",
        "qwugbimrzplymcoaxefotvdzns",
        "qyugbiwrkplymcjasefotvdzns",
        "qwubbihrkpiymcjaxefotvdzws",
        "qwugbilrkplymjjgxefotvdzns",
        "qwugbihykplympjaxefotgdzns",
        "qwugmxhrkplymcjaxefotvdins",
        "qwfjbahrkplymcjaxefotvdzns",
        "owuzbihrkplymcbaxefotvdzns",
        "qwugbihrkilymcjaxefotsdzvs",
        "qwugbwhrkplymcpzxefotvdzns",
        "qwugbihrkplymcjlcefotvdjns",
        "kwugbihrkplymcjaxefotvhdns",
        "qwulbihrkplymcfwxefotvdzns",
        "qwxabihrkplyhcjaxefotvdzns",
        "qwugbihrzpoymcjaxefotqdzns",
        "qwugbihrknlymcjabefovvdzns",
        "qyugbihrkplymclaxefotvgzns",
        "qwugbxhrkpgymcjaxefotvdlns",
        "qwuplihrkplymcjaxefhtvdzns",
        "qwugbihruplymcjaxefotmdzps",
        "qwugkihrkplymcqtxefotvdzns",
        "qwugbihrkplymcjaxeyodvszns",
        "qwukbihrkplymojaxefotvczns",
        "nwugbihrkplymcjaxrfothdzns",
        "qwugbihrkklymcjaxqfotvdzcs",
        "qwugbihrkplemcjaxefotvufns",
        "qwugbihrkplymcjaxbfitvdzne",
        "qwugbizrkplymcjaxgfotvdhns",
        "qwulbihrxplymcjaxefolvdzns",
        "jwugbihckpoymcpaxefotvdzns",
        "qwugeihrkplymbjcxefotvdzns",
        "qwuxbihbkplymcjaxeuotvdzns",
        "qwugbshrkplyvcjlxefotvdzns",
        "qwugbimrjplymcjaxtfotvdzns",
        "qwugzikrkplymcjaxefxtvdzns",
        "qwugbihrkplymcjaxefftvdgnq",
        "qwugbihnkilymcjaxemotvdzns",
        "qfugbihrkplyfcjadefotvdzns",
        "qwugbihrkplymrsaxefwtvdzns",
        "qwugfihrkpsymckaxefotvdzns",
        "qwulbihrkplymyjaxefotvdkns",
        "quugbikrkpkymcjaxefotvdzns",
        "qwugbihfgplymdjaxefotvdzns",
        "qougbihrkplemcjaqefotvdzns",
        "qwugbihrkplemcjjxefotvdyns",
        "qfuhbikrkplymcjaxefotvdzns",
        "qhugbihrcplymcjaxefrtvdzns",
        "qwugbmhnkplymcjnxefotvdzns",
        "qwugbihrkplymmjaaefofvdzns",
        "qwugbihrtplykcjaxefoxvdzns",
        "qwugbihrkmvymcjaxefetvdzns",
        "qwugbfjrkplymcjaxefotadzns",
        "qwuibihrrplymcjaxefotvdznv",
        "qwcgbihrkjlymcjzxefotvdzns",
        "qwugbihrkplymcjuxefytvzzns",
        "qwkgwihrkllymcjaxefotvdzns",
        "qwugbihrkplymcpaxgfogvdzns",
        "qwuvbihrkplymcdaxefotvdmns",
        "qwtgbihrkplqmcjgxefotvdzns",
        "qwuglihrkplnmcjaxefptvdzns",
        "qbugbihrkplymcjawefotidzns",
        "qwegbihrvplymcjaxefqtvdzns",
        "qwugbihrgqlyncjaxefotvdzns",
        "qwugbihrpplymcjaxefotvdeqs",
        "qwugbihrkplypzjaxefbtvdzns",
        "qwugbihrkpkyncjanefotvdzns",
        "qwugbshrkplymcjaxefotfdzys",
        "qwugbihrkpymmcjaxefotzdzns",
        "qwugbphrkplymcjaxefotvdzru",
        "qyugbihrkplamcjjxefotvdzns",
        "qwugbihrmphymcjaxefotedzns",
        "qwuafihrkplymcjaxefozvdzns",
        "qwugwihrkplymcjaxwfotvdzws",
        "qwugbihrkzlymcjaxjfotvdznz",
        "uwugsihrkplypcjaxefotvdzns",
        "qwugbihrkplymcjaxefotudzur",
        "qwugbihrkplymcjoxefotfdzng",
        "qwugbihxkplymcjamebotvdzns",
        "qpugvihrkplymcjaxefotvdzhs",
        "qwugbihrkplyocgaxefotvdzss",
        "qwugbihrkplymcpaqekotvdzns",
        "qwunbihrkplymclaxefitvdzns",
        "qzugbihrkplsmcjaxebotvdzns",
        "qvugbihrkplymcjsxefotvmzns",
        "qwugbihrkprymcyaxkfotvdzns",
        "qwugbihukplymcjaxefotzlzns",
        "qwusbihrkplymcjaxwfotxdzns",
        "qwugbihrwplymcjaxefbtcdzns",
        "qwugbihrkplymcjpxefotkdons",
        "qwugbihrkhlymcjaxefohvwzns",
        "qwukbihrkplymxjaxefotvdzms",
        "qwugbiprkplsmcjaxefotvdznm",
        "qwugbqhrkplymcjawwfotvdzns",
        "qwugbihrkprymcjaxefotvdxnb",
        "qwugbihrkplymcjaxefoivpzos",
        "qwugbuhrkplymcjaxefotvdzsb",
        "qwugblhrcplymcjaxefotvdyns",
        "qtuabihrkplymejaxefotvdzns",
        "qwucbihrkplyvcjaxefotvdznu",
        "rwugbyhrkplymcjaxefotvdzrs",
        "qruybihrkpsymcjaxefotvdzns",
        "qwugbihrjpwymcjaxejotvdzns",
        "qwugbihshplymcjaxefoavdzns",
        "vwugbihrkplymwjaxefotvdznc",
        "qwugbihrkpmymcjvxcfotvdzns",
        "qkxgbihrkplymcjnxefotvdzns"
    )
}
