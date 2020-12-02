lu = require('luaunit')
DateUtil = require('src.DateUtil')

TestDateUtil = {}
function TestDateUtil:testWithStartSameAsEnd()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, startDate)
    -- Assert
    lu.assertEquals(daysInInterval, 0)
end

os.exit( lu.LuaUnit.run() )
