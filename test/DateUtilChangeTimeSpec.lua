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
        min=0,
        sec=0
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
        min=34,
        sec=40
    })
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=0,
        min=0,
        sec=0
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
        min=59,
        sec=59
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
        min=45,
        sec=46
    })
    expected = os.time({
        year=2016, 
        month=1, 
        day=1,
        hour=23,
        min=59,
        sec=59
    })
    -- Act
    dateAtStartOfDay = DateUtil.makeEndOfDay(aDate)
    -- Assert
    lu.assertEquals(dateAtStartOfDay, expected)
end

return TestDateUtilChangeTime
