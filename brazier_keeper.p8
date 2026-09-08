pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	
	-- change transparency
	palt(0,false)
	palt(14,true)
	
	-- enable mouse function
	poke(0x5f2d,1)
	
	fp_init()
	em_init()
	pt_init()
	
end

function _update()

	fp_update()
	em_update()
	pt_update()
end

function _draw()
	
	cls(0)
	
	spr(5,47,64,4,4)
	fp_draw()
	spr(1,47,63,4,4)
	em_draw()
	pt_draw()

end
-->8
-- fire particle functions

function fp_init()

	-- fire particle list
	parts={}
	
	stoke=10
	
	-- force on the fire
	force=0
	forcedir=1.5
	forcedel=5
	

end

function fp_update()

	forcedel-=1
	
	if forcedel<0 then
		--increase the amount of force
		force+=.1*forcedir
		forcedel=30
	end
	
	if force>1 or force<-1 then
		forcedir=forcedir*-1
	end
	
	if btnp(4) then
		stoke+=10
	end
		

	for i=1,20 do
		add(parts,{
			x=57+rnd(10),
			y=80+rnd(10),
			c=7,
			r=rnd(3),
			spd=rnd(2)+1,
			l=stoke,
		})
	end
	
	for p in all(parts) do
		p.y-=p.spd
		p.l-=1
		p.r-=.1
		p.x+=force
		
		if p.l<8 then
			p.c=10
		end
		if p.l<5then
			p.c=9
		end
		
		if p.l<0 then
			del(parts,p)
		end
	end
end

function fp_draw()

	for p in all(parts) do
		circfill(p.x,p.y,p.r,p.c)
	end

end
-->8
-- ember functions
function em_init()

	-- storage for embers
	embers={}
	
	emtimer=30

end

function em_update()

	emtimer=emtimer-1
	
	if emtimer<0 then		
		add(embers,{
			-- position and colour
			x=57,
			y=80,
			c=9,
			-- movement
			spdy=1,
			spdx=rnd(0.5)+0.05,
			dir=rnd(2),
			-- floor logic
			onflr=false,
			flrtime=0,
			-- state
			falling=false
		})
		
		-- delay for ember spawn
		emtimer=20
	end
	
	for e in all(embers) do

		if not e.onflr then

			e.y-=e.spdy
			
			-- determine direction of ember
			if flr(e.dir)==1 then
				e.x-=e.spdx
			else
				e.x+=e.spdx
			end
			
			-- handle if embers hit left or right wall
			if e.x<=1 then
				e.x=1
				e.spdx=0
				e.falling=true
			elseif e.x>=126 then
				e.x=126
				e.spdx=0
				e.falling=true
			end
			
			if	not e.falling and (e.y<=rnd(40)+10 or e.x<=1 or e.x>=128) then
				e.falling=true
				e.spdy=-e.spdy
			end
			
			if e.y>=94 then
				e.y=94	
				e.spdx=0
				e.spdy=0
				e.onflr=true
				e.flrtime=90
			end
			
		else
			
			e.flrtime-=1
			
			if e.flrtime<=30 then
				e.c=1
			end
			
			if e.flrtime<=0 then
				del(embers,e)
			end
		end
	end
end

function em_draw()
	
	for e in all(embers) do
		circfill(e.x,e.y,1,e.c)
	end
end
-->8
-- pointer functions

function pt_init()
	pointer={
		x=63,
		y=63
	}
	
end

function pt_update()

	pointer.x=stat(32)
	pointer.y=stat(33)

end

function pt_draw()
	spr(9,pointer.x,pointer.y,2,2)
end	
__gfx__
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee444444444440000000000000000000000000000000000000000
00700700eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefff24444444440000000000000000000000000000000000000000
00077000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffff2444442440000000000000000000000000000000000000000
00077000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffff92444224420000000000000000000000000000000000000000
00700700eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefefef9224444442e0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef924444222ee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefe442222eeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeee77eeeeeeee55eeeeeeeee75eeeeeeeeeeeeee11eeeeeeeeee11eeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeee57eeeeeeee555eeeeeeee75eeeeeeeeeeeeee111eeeeeeeee11eeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeee557eeeeeeee55eeeeee7655eeeeeeeeeeeeee111eeeeeee1111eeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeee556eeeeee555eeeeee755eeeeeeeeeeeeeee1111eeeeee111eeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeeee556eeee55555eeee655eeeeeeeeeeeeeeeee111eeeee111eeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeeee5555555555555555555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeee555555555555555555555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeeee5555555555555555555555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eeee55555e111155551111e55555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000eee5555ee11115555551111ee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000ee55555e1111e555555e1111e55555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
00000000e5555ee1111e55555555e1111ee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000000000000000000000000000
__sfx__
000400000260002600026000260003600036000160002600016000060000600016000160000600006000160001600016000160001600016000160001600016000060000600006000160001600026000060001600
