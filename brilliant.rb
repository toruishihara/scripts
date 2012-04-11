#!/usr/bin/env ruby
include Math

$ch = 8*0.162
$ch2 = $ch*0.8
$pd = -8*0.431
$pd2 = $pd*0.75
$r = 4
$ro =$r*0.53
$rsf=$r*0.7 
$rl = $r*0.25

$pi = Math::PI

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
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		print_tri(
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4),0,
			$r*Math.cos(k*$pi/4), $r*Math.sin(k*$pi/4),0,
			$rl*Math.cos(k*$pi/4), $rl*Math.sin(k*$pi/4),$pd2)
		print_tri(
			$r*Math.cos(j*$pi/4), $r*Math.sin(j*$pi/4),0,
			$r*Math.cos(k*$pi/4), $r*Math.sin(k*$pi/4),0,
			$rl*Math.cos(k*$pi/4), $rl*Math.sin(k*$pi/4),$pd2)
	end
end

def pavilion_main
	(0..7).each do |i|
		j = i+1
		k = i+0.5
		kk = i-0.5
		print_tri(
			$r*Math.cos(i*$pi/4), $r*Math.sin(i*$pi/4),0,
			$rl*Math.cos(k*$pi/4), $rl*Math.sin(k*$pi/4),$pd2,
			$rl*Math.cos(kk*$pi/4), $rl*Math.sin(kk*$pi/4),$pd2)
		print_tri(
			0,0,$pd,
			$rl*Math.cos(k*$pi/4), $rl*Math.sin(k*$pi/4),$pd2,
			$rl*Math.cos(kk*$pi/4), $rl*Math.sin(kk*$pi/4),$pd2)
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
