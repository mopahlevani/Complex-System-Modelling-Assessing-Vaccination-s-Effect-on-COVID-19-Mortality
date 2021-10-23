turtles-own [
 infected?
 vaccinated?
 dead?
 hours
]
globals [
 %infected
 %vaccinated
 %dead
 %recovered
]
to setup
 clear-all
 reset-ticks
 create-turtles population [
 set shape "person"
 set color white
 set infected? 0
 set vaccinated? 0
 setxy random-pxcor random-pycor
 ]
 ask n-of initialinfected turtles [
 set infected? true
 set color orange
 ]
end
to go
 tick

 ask turtles [
 if dead? = 0 [
 set hours hours + 1
 forward 1
 right 45 - random 90
 ]
 ]
 ask turtles with [color = orange]
 [
 ask other turtles-here [
 if infected? = 0 and vaccinated? = 0 and random 100 < infectiousness
 [
 set color orange
 set infected? 1
 set hours 0
 ]
 ]
 ]
 ask turtles with [color = orange]
 [
 if (hours >= duration) and random 100 < fatalityrate
 [
 set color gray
 set vaccinated? 0
 set dead? 1
 ]
 if (hours >= duration) and random 100 >= fatalityrate
 [
 set color green
 set vaccinated? 1
 set dead? 0
 ]
 ]
set %infected (count turtles with [color = orange] / count turtles)
set %dead (count turtles with [color = gray] / count turtles)
set %vaccinated (count turtles with [color = cyan] / count turtles)
set %recovered (count turtles with [color = green] / count turtles)
 if %infected = 100 [stop]
 if %vaccinated = 100 [stop]
 ask n-of 1 turtles [
 if hours mod vaccinationrate = 0 and hours > vaccinationstart and dead? = 0 [
 set vaccinated? true
 set color cyan
 ]
 ]

end
to-report finished?
 if (count turtles with [color = orange] = 0)
 [
 report true
 ]
end
