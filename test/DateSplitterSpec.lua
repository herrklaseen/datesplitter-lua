lu = require('luaunit')
DateSplitter = require('src.DateSplitter')

TestDateSplitter = {}
function TestDateSplitter:testNew()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=2})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    -- Assert
    lu.assertEquals(ds.startDate, startDate)
    lu.assertEquals(ds.endDate, endDate)
end

function TestDateSplitter:testWithOnePartReturnsDateAtStartOfInterval()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=2})
    expected = os.time({year=2016, month=1, day=1, hour=0, minute=0, second=0})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    dates = ds:split(1)
    -- Assert
    lu.assertEquals(os.date('%c', dates[1]), os.date('%c', expected))
end

function TestDateSplitter:testWithTwoPartsReturnsDateAtStartAndEndOfInterval()
    -- Arrange
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expectedOne = os.time({year=2016, month=1, day=1, hour=0, minute=0, second=0})
    expectedTwo = os.time({year=2016, month=1, day=1, hour=23, minute=59, second=59})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    dates = ds:split(2)
    -- Assert
    lu.assertEquals(dates[1], expectedOne)
    lu.assertEquals(dates[2], expectedTwo)
end

return TestDateSplitter
