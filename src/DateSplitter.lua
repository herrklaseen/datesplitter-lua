DateUtil = require('src.DateUtil')
Allotter = require('src.Allotter')

DateSplitter = {}
function DateSplitter:new(startDate, endDate)
    local ds = {}
    ds.startDate = startDate
    ds.endDate = endDate
    setmetatable(ds, self)
    self.__index = self
    return ds
end

function DateSplitter:split(parts)
  if parts < 1 then
    error 'Parts must be larger than zero'
  end

  -- Determine if the number of parts is low
  -- and we want to ensure that there are dates
  -- at the beginning and end of the sequence.
  -- Without this check, we may end up with a sequence
  -- of dates where the first date is not the date
  -- the user asked for. The second check makes sure
  -- that the last date in the sequence is the date the
  -- user asked for.
  local correctedParts
  if parts > 0 then
    correctedParts = parts - 1
  end

  if parts > 1 then
    correctedParts = parts - 2
  end

  local fullDays = DateUtil.daysInInterval(self.startDate, self.endDate)
  local slots = fullDays + 1
  local distribution = Allotter:allot(correctedParts, slots)

  -- Here we add the parts back to the 
  -- start of the sequence
  if parts - correctedParts > 0 then
    distribution[1] = distribution[1] + 1
  end

  -- And to the end of the sequence
  if parts - correctedParts > 1  then
    distribution[#distribution] = distribution[#distribution] + 1
  end

  local returnDates = {}

  local startDateAsTable = os.date('*t', self.startDate)

  local dateIndex = 1
  for slot,parts in ipairs(distribution) do
    local dateAtSlot = os.time({
      year=startDateAsTable.year,
      month=startDateAsTable.month,
      day=startDateAsTable.day + (slot - 1),
      hour=0,
      minute=0,
      second=0
    })
    local durationAtSlot = DateSplitter:getDurationAtDate(dateAtSlot)
    local durationInSeconds = DateSplitter:getDurationInSeconds(durationAtSlot[1], durationAtSlot[2])
    local divisor = 0

    if (parts == 1) then
      divisor = 1
    elseif (parts > 1) then
      divisor = parts - 1
    end

    local interval = math.floor(durationInSeconds / divisor)
    for i=1,parts do
      local aDate = os.time(os.date('*t', dateAtSlot + interval * (i - 1)))
      returnDates[dateIndex] = aDate
      dateIndex = dateIndex + 1
    end
  end

  return returnDates

  --[[
  local dateAsTable = os.date('*t', self.startDate)
  local dateAtIntervalStart = os.time({
    year=dateAsTable.year,
    month=dateAsTable.month,
    day=dateAsTable.day,
    hour=0,
    minute=0,
    second=0
  })

  dateAsTable = os.date('*t', self.endDate)
  local dateAtIntervalEnd = os.time({
    year=dateAsTable.year,
    month=dateAsTable.month,
    day=dateAsTable.day,
    hour=23,
    minute=59,
    second=59
  })

  return { dateAtIntervalStart, dateAtIntervalEnd }
  ]]
end

function DateSplitter:getDurationAtDate(date)
  local dateAsTable = os.date('*t', self.startDate)
  local duration = {}

  local intervalStart = os.time({
    year=dateAsTable.year,
    month=dateAsTable.month,
    day=dateAsTable.day,
    hour=0,
    minute=0,
    second=0
  })

  local intervalEnd = os.time({
    year=dateAsTable.year,
    month=dateAsTable.month,
    day=dateAsTable.day,
    hour=23,
    minute=59,
    second=59
  })

  duration[1] = intervalStart
  duration[2] = intervalEnd
  return duration
end

function DateSplitter:getDurationInSeconds(startDate, endDate)
  return endDate - startDate
end

return DateSplitter
