pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
star= {
	x=0,
	y=0,
	z=0,
	pz=z
}
speed = 0.25

function _init()
	stars={}
	for i=1,100 do
		stars[i]=star
		stars[i]=star:new(stars[i])
	end
end

function _update60()
	for i=1,#stars do
		stars[i].update(stars[i])
	end
end

function _draw()
	cls()
	camera(-64,-64)
	for i=1,#stars do
		stars[i].show(stars[i])
	end
end
-->8


function star:new()
 local obj={}
 obj.x=rnd(128)-64
 obj.y=rnd(128)-64
 obj.z=rnd(64)
 -- etc etc more init
 -- set self (star) as prototype so that stars can access methods defined in star
 return setmetatable(obj, {__index=self})
end

function star:update()
	self.z-=speed
	if self.z<0 then 
		self.z=16
		self.x=rnd(32)-16
		self.y=rnd(32)-16
		self.pz=star.z
	end
end	

function star:show()
	sx = mapnums(self.x/self.z,0,1,0,64/2)
	sy = mapnums(self.y/self.z,0,1,0,64/2)
	r	 = mapnums(self.z,0,64,16,0)
	--oval(sx,sy,r,r)
	
	px=mapnums(self.x/self.z,0,1,0,64)
	py=mapnums(self.y/self.z,0,1,0,64)
	
	self.pz=self.z
	
	line(px,py,sx,sy,10)--]]
end
-->8
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
