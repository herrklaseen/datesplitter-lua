local fraction = require('symbolics.types.fraction')

local frac1 = fraction.new(2,3)
local frac2 = fraction.new(3, 4)

local diff = fraction.approx(fraction.subtract(frac2, frac1))
print('diff is ' .. diff)

if fraction.approx(fraction.subtract(frac1, frac2)) > 0 then
    print 'frac 1 is smaller than frac 2'
else
    print 'frac 1 is not smaller than frac 2'
end
