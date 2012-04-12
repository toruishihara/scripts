#!/usr/bin/env ruby
include Math

$r = 4		#/ radius of whole diameter */
$sf = 0.7 	#/ star facets r between 0.53 and 1.0 */
$pp = 0.5 	#/ pavilion main facets facter, 0.5 is hishigata */

$ch = 2*$r*0.162 	#/* height of table */
$ch2 = $ch*$sf 		#/* height of low point of star_facet */
$pd = -2*$r*0.431	#/* pavilion depth */
$ro =$r*0.53		#/* radius of table */
$rsf=$r*$sf 		#/* radius of table + star_facet */

$pi = Math::PI

#class Tuple
	#def initialize(x,y,z)
		#@x = x
		#@y = y
		#@z = z
		#@t = "xyz"
	#end
#end

def top_octa
	(0..7).each do |i|
		j = i+1
		print_tri(0,0,$ch, 
			$ro*Math.cos(i*$pi/4), $ro*Math.sin(i*$pi/4),$ch,
			$ro*Math.cos(j*$pi/4), $ro*Math.sin(j*$pi/4),$ch)
	end
end

def star_facets
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		print_tri(
			$rsf*Math.cos(k*$pi/4), $rsf*Math.sin(k*$pi/4),$ch2,
			$ro*Math.cos(i*$pi/4), $ro*Math.sin(i*$pi/4),$ch,
			$ro*Math.cos(j*$pi/4), $ro*Math.sin(j*$pi/4),$ch)
	end
end

def kite_facets
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		kk = i-0.5
		print_tri(
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4),0,
			$ro*Math.cos(i*$pi/4), $ro*Math.sin(i*$pi/4),$ch,
			$rsf*Math.cos(k*$pi/4), $rsf*Math.sin(k*$pi/4),$ch2)
		print_tri(
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4),0,
			$ro*Math.cos(i*$pi/4), $ro*Math.sin(i*$pi/4),$ch,
			$rsf*Math.cos(kk*$pi/4), $rsf*Math.sin(kk*$pi/4),$ch2)
	end
end

def up_girdle_facets
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		print_tri(
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4),0,
			$r*Math.cos(k*$pi/4), $r*Math.sin(k*$pi/4),0,
			$rsf*Math.cos(k*$pi/4), $rsf*Math.sin(k*$pi/4),$ch2)
		print_tri(
			$r*Math.cos(j*$pi/4), $r*Math.sin(j*$pi/4),0,
			$r*Math.cos(k*$pi/4), $r*Math.sin(k*$pi/4),0,
			$rsf*Math.cos(k*$pi/4), $rsf*Math.sin(k*$pi/4),$ch2)
	end
end

def lower_girdle
	p = (Math.sin($pi/8) - Math.cos($pi/8))/(-1*Math.sin($pi/8) - Math.cos($pi/8))
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		sk = Math.sin(k*$pi/4)
		ck = Math.cos(k*$pi/4)
		print_tri(
			$r*ck, $r*sk, 0,
			$r*$pp*(ck + p*sk), $r*$pp*(sk - p*ck), $pd*(1-$pp),
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4), 0)
		print_tri(
			$r*ck, $r*sk, 0,
			$r*$pp*(ck - p*sk), $r*$pp*(sk + p*ck), $pd*(1-$pp),
			$r*Math.cos(j*$pi/4), $r*Math.sin(j*$pi/4), 0)
	end
end

def pavilion_main
	p = (Math.sin($pi/8) - Math.cos($pi/8))/(-1*Math.sin($pi/8) - Math.cos($pi/8))
	(0..7).each do |i|
		k = i+0.5
		sk = Math.sin(k*$pi/4)
		ck = Math.cos(k*$pi/4)
		print_tri(
			0,0,$pd,
			$r*ck, $r*sk, 0,
			$r*$pp*(ck + p*sk), $r*$pp*(sk - p*ck), $pd*(1-$pp))
		print_tri(
			0,0,$pd,
			$r*ck, $r*sk, 0,
			$r*$pp*(ck - p*sk), $r*$pp*(sk + p*ck), $pd*(1-$pp))
	end
end

def print_tri(x0, y0, z0, x1, y1, z1, x2, y2, z2)
printf(" facet normal %e %e %e\n", 0, 0, 0)
printf("   outer loop\n")
printf("     vertex %e %e %e\n", x0, y0, z0)
printf("     vertex %e %e %e\n", x1, y1, z1)
printf("     vertex %e %e %e\n", x2, y2, z2)
printf("   endloop\n")
printf(" endfacet\n")
end

printf("solid brilliant\n");
top_octa()
star_facets()
kite_facets()
up_girdle_facets()
lower_girdle()
pavilion_main()
printf("endsolid brilliant\n");
