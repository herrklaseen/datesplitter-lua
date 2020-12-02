lu = require('luaunit')
DateUtil = require('src.DateUtil')

TestDateUtilChangeTime = {}
function TestDateUtilChangeTime:testSetStartOfDayWithDefaultDate()
    -- Arrange
    aDate = os.time({year=2016, month=1, day=1})
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=0,
        minute=0,
        second=0
    })
    -- Act
    dateAtStartOfDay = DateUtil.makeStartOfDay(aDate)
    -- Assert
    lu.assertEquals(dateAtStartOfDay, expected)
end

function TestDateUtilChangeTime:testSetStartOfDayWithSpecificTime()
    -- Arrange
    aDate = os.time({
        year=2016,
        month=1,
        day=1,
        hour=9,
        minute=34,
        second=40
    })
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=0,
        minute=0,
        second=0
    })
    -- Act
    dateAtStartOfDay = DateUtil.makeStartOfDay(aDate)
    -- Assert
    lu.assertEquals(dateAtStartOfDay, expected)
end

function TestDateUtilChangeTime:testSetEndOfDayWithDefaultDate()
    -- Arrange
    aDate = os.time({
        year=2016,
        month=1,
        day=1
    })
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=23,
        minute=59,
        second=59
    })
    -- Act
    dateAtStartOfDay = DateUtil.makeEndOfDay(aDate)
    -- Assert
    lu.assertEquals(dateAtStartOfDay, expected)
end

function TestDateUtilChangeTime:testSetEndOfDayWithSpecificTime()
    -- Arrange
    aDate = os.time({
        year=2016,
        month=1,
        day=1,
        hour=13,
        minute=45,
        second=46
    })
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=23,
        minute=59,
        second=59
    })
    -- Act
    dateAtStartOfDay = DateUtil.makeEndOfDay(aDate)
    -- Assert
    lu.assertEquals(dateAtStartOfDay, expected)
end

return TestDateUtilChangeTime
