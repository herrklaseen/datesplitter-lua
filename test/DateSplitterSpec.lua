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

function TestDateSplitter:testWithSevenPartsReturnsDateAtStartAndEndOfInterval()
    -- Arrange
    parts = 7
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expectedFirst = os.time({year=2016, month=1, day=1, hour=0, minute=0, second=0})
    expectedLast = os.time({year=2016, month=1, day=1, hour=23, minute=59, second=59})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    dates = ds:split(parts)
    -- Assert
    lu.assertEquals(dates[1], expectedFirst)
    lu.assertEquals(dates[7], expectedLast)
end

function TestDateSplitter:testWith1137PartsReturnsDateAtStartAndEndOfInterval()
    -- Arrange
    parts = 1137
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=1})
    expectedFirst = os.time({year=2016, month=1, day=1, hour=0, minute=0, second=0})
    expectedLast = os.time({year=2016, month=1, day=1, hour=23, minute=59, second=59})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    dates = ds:split(parts)
    -- Assert
    lu.assertEquals(dates[1], expectedFirst)
    lu.assertEquals(dates[parts], expectedLast)
end

function TestDateSplitter:testWithThreePartsAndThreeDaysReturnsDatesAtStartOfEachDate()
    -- Arrange
    parts = 3
    startDate = os.time({year=2016, month=1, day=1})
    endDate = os.time({year=2016, month=1, day=3})
    expectedOne = os.time({year=2016, month=1, day=1, hour=0, minute=0, second=0})
    expectedTwo = os.time({year=2016, month=1, day=2, hour=0, minute=0, second=0})
    expectedThree = os.time({year=2016, month=1, day=3, hour=0, minute=0, second=0})
    -- Act
    ds = DateSplitter:new(startDate, endDate)
    dates = ds:split(parts)
    -- Assert
    lu.assertEquals(os.date(nil, dates[1]), os.date(nil, expectedOne))
    lu.assertEquals(os.date(nil, dates[2]), os.date(nil, expectedTwo))
    lu.assertEquals(os.date(nil, dates[3]), os.date(nil, expectedThree))
end

function TestDateSplitter:testShiftDistributionMoveFirstPositiveToPositionOne()
  -- Arrange
  dist = { 0, 1, }
  expected = { 1, 0 }
  -- Act
  result = DateSplitter:shiftDistribution(dist)
  -- Assert
  lu.assertEquals(result, expected)
end

function TestDateSplitter:testShiftDistributionMoveFirstPositiveToPositionOneAndRestFollows()
  -- Arrange
  dist = { 0, 1, 2, 0}
  expected = { 1, 2, 0, 0 }
  -- Act
  result = DateSplitter:shiftDistribution(dist)
  -- Assert
  lu.assertEquals(result, expected)
end

return TestDateSplitter
