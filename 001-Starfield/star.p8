pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
speed=0 --a global variable to store  the current speed

function _init() --run initialization code once before program starts
	stars={}     -- create a table to hold our stars
	poke(0x5f2d, 0x1) --Pico-8 function to activate mouse

	for i=1,100 do	  -- load the stars[] table with 100 stars
		stars[i]=star:new(stars[i])
	end
end

function _update60() --Pico-8 runs this function 60x per second
	for i=1,#stars do
		stars[i].update(stars[i])
	end
	speed=mapnums(stat(32), -16, 143, 1, 3);

end

function _draw()
	cls()
	camera(-64,-64)
	--speed+=0.001
	for i=1,#stars do
		stars[i].show(stars[i])
	end
	--print(stat(32) .. ": " .. speed,8)
end
-->8
star= { --creates a gereric star table
	x=0,
	y=0,
	z=0,
	pz=z
}

function star:new() --an instance function that creates a new star object
 	local obj={}
 	obj.x=rnd(128)-64 --random x between -64 and 64
 	obj.y=rnd(128)-64 --random x between -64 and 64
 	obj.z=rnd(64)	  --random x between 0 and 64
 	return setmetatable(obj, {__index=self}) --metatable causes the return value 'obj' to be treated as an instance of star
end

function star:update() --an instance function that updates the star object
	self.z-=speed -- we are reducing the z-value of ech star by 'speed' on each frame
	if self.z<0 then --reset each star when it reaches 0
		self.z=64
		self.x=rnd(128)-64
		self.y=rnd(128)-64
		self.pz=self.z
	end
end	

function star:show() --an instance function that displaces a star object
	sx = mapnums(self.x/self.z,0,1,1,64) 
	sy = mapnums(self.y/self.z,0,1,1,64)
	r	 = mapnums(self.z,0,64,3.5,0.5)
	
	
	px=mapnums(self.x/self.z,0,1,1,64/speed)
	py=mapnums(self.y/self.z,0,1,1,64/speed)
	
	self.pz=self.z
	
	line(px,py,sx,sy,7)
	circfill(sx,sy,r,7)

end
-->8
--an implementation of the Javascript function map() that maps values from one range onto another range
function mapnums(value, start1, stop1, start2, stop2, withinbounds)
	    local range1 = stop1 - start1
	    local range2 = stop2 - start2
	    value = (value - start1) / range1 * range2 + start2
	    return withinbounds and math.clamp(value, start2, stop2) or value
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
