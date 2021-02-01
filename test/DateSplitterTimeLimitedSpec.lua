lu = require('luaunit')
DateSplitter = require('src.DateSplitter')

TestDateSplitterTimeLimited = {}

function TestDateSplitterTimeLimited:testWithOnePartReturnsDateAtStartOfInterval()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=2})
    expected = os.time({year=2016, month=1, day=1, hour=8, min=0, sec=0})
    startHour = 8
    endHour = 19
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(1)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expected))
end

function TestDateSplitterTimeLimited:testInvalidStartHourIsCoercedToValid()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expected = os.time({year=2016, month=1, day=1, hour=23, min=0, sec=0})
    startHour = 34
    endHour = 56
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(1)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expected))
end

function TestDateSplitterTimeLimited:testNegativeStartHourIsCoercedToValid()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expected = os.time({year=2016, month=1, day=1, hour=0, min=0, sec=0})
    startHour = -2
    endHour = 56
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(1)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expected))
end

function TestDateSplitterTimeLimited:testInvalidEndHourIsCoercedToValid()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expected = os.time({year=2016, month=1, day=1, hour=8, min=59, sec=59})
    startHour = 8
    endHour = 4
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(2)
    -- Assert
    lu.assertEquals(os.date('%c', dates[2]), os.date('%c', expected))
end

function TestDateSplitterTimeLimited:testWithTwoPartsReturnsDateAtStartAndEndOfInterval()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expectedStart = os.time({year=2016, month=1, day=1, hour=8, min=0, sec=0})
    expectedEnd = os.time({year=2016, month=1, day=1, hour=19, min=59, sec=59})
    startHour = 8
    endHour = 19
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(2)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expectedStart))
    lu.assertEquals(os.date('%c', dates[2]), os.date('%c', expectedEnd))
end

function TestDateSplitterTimeLimited:testWithFourPartsReturnsDateAtStartAndEndOfInterval()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=2})
    expectedStart = os.time({year=2016, month=1, day=1, hour=8, min=0, sec=0})
    expectedEnd = os.time({year=2016, month=1, day=2, hour=19, min=59, sec=59})
    startHour = 8
    endHour = 19
    -- Act
    ds = DateSplitter:new(startDate, endDate, startHour, endHour)
    dates = ds:split(4)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expectedStart))
    lu.assertEquals(os.date('%c', dates[4]), os.date('%c', expectedEnd))
end

return TestDateSplitterTimeLimited
