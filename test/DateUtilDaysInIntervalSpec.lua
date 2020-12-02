lu = require('luaunit')
DateUtil = require('src.DateUtil')

TestDateUtilDaysInInterval = {}
function TestDateUtilDaysInInterval:testWithStartSameAsEnd()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, startDate)
    -- Assert
    lu.assertEquals(daysInInterval, 0)
end

function TestDateUtilDaysInInterval:testWithEndOneDayAfterStart()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=2})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, endDate)
    -- Assert
    lu.assertEquals(daysInInterval, 1)
end

function TestDateUtilDaysInInterval:testWithEndOneHourAfterStart()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1, hour=0})
    endDate = os.time({year=2016, month=1, day=1, hour=1})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, endDate)
    -- Assert
    lu.assertEquals(daysInInterval, 0)
end

function TestDateUtilDaysInInterval:testWithEndThreeAndAHalfDayAfterStart()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1, hour=0})
    endDate = os.time({year=2016, month=1, day=4, hour=12})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, endDate)
    -- Assert
    lu.assertEquals(daysInInterval, 3)
end

function TestDateUtilDaysInInterval:testWithEndAlmostOneWeekAfterStart()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1, hour=0})
    endDate = os.time({year=2016, month=1, day=7, hour=23, minute=59, second=59})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, endDate)
    -- Assert
    lu.assertEquals(daysInInterval, 6)
end

function TestDateUtilDaysInInterval:testWithEndOneMonthAfterStart()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1, hour=0})
    endDate = os.time({year=2016, month=2, day=1, hour=0})
    -- Act
    daysInInterval = DateUtil.daysInInterval(startDate, endDate)
    -- Assert
    lu.assertEquals(daysInInterval, 31)
end

return TestDateUtilDaysInInterval
