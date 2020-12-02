lu = require('luaunit')
Allotter = require('src.Allotter')

TestAllot = {}
function TestAllot:testWithZeroPartsAndOneSlot()
    -- Act
    partsPerSlot = Allotter:allot(0,1)
    -- Assert
    lu.assertEquals(partsPerSlot, { 0 })
end

function TestAllot:testWithZeroPartsAndThreeSlots()
    -- Act
    partsPerSlot = Allotter:allot(0,3)
    -- Assert
    lu.assertEquals(partsPerSlot, { 0, 0, 0 })
end

function TestAllot:testWithOnePartAndOneSlot()
    -- Act
    partsPerSlot = Allotter:allot(1,1)
    -- Assert
    lu.assertEquals(partsPerSlot, { 1 })
end

function TestAllot:testWithTwoPartsAndOneSlot()
    -- Act
    partsPerSlot = Allotter:allot(2,1)
    -- Assert
    lu.assertEquals(partsPerSlot, { 2 })
end

function TestAllot:testWithTwoPartsAndTwoSlots()
    -- Act
    partsPerSlot = Allotter:allot(2,2)
    -- Assert
    lu.assertEquals(partsPerSlot, { 1, 1 })
end

function TestAllot:testWithThreePartsAndTwoSlots()
    -- Act
    partsPerSlot = Allotter:allot(3,2)
    -- Assert
    lu.assertEquals(partsPerSlot, { 1, 2 })
end

function TestAllot:testWithNinePartsAndThreeSlots()
    -- Act
    partsPerSlot = Allotter:allot(9,3)
    -- Assert
    lu.assertEquals(partsPerSlot, { 3, 3, 3 })
end

function TestAllot:testWith61PartsAnd14SlotsSumOfParts()
    -- Act
    partsPerSlot = Allotter:allot(61,14)

    totalParts = 0

    for key, val in pairs(partsPerSlot) do
        totalParts = totalParts + val
    end
    -- Assert
    lu.assertEquals(totalParts, 61)
end

return TestAllot


