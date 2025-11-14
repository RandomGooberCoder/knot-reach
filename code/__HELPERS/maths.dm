/**
 * Get a list of turfs in a line from `starting_atom` to `ending_atom`.
 *
 * Uses the ultra-fast [Bresenham Line-Drawing Algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm).
 */
/proc/get_line(atom/starting_atom, atom/ending_atom)
	var/current_x_step = starting_atom.x//start at x and y, then add 1 or -1 to these to get every turf from starting_atom to ending_atom
	var/current_y_step = starting_atom.y
	var/starting_z = starting_atom.z

	var/list/line = list(get_turf(starting_atom))//get_turf(atom) is faster than locate(x, y, z)

	var/x_distance = ending_atom.x - current_x_step //x distance
	var/y_distance = ending_atom.y - current_y_step

	var/abs_x_distance = abs(x_distance)//Absolute value of x distance
	var/abs_y_distance = abs(y_distance)

	var/x_distance_sign = SIGN(x_distance) //Sign of x distance (+ or -)
	var/y_distance_sign = SIGN(y_distance)

	var/x = abs_x_distance >> 1 //Counters for steps taken, setting to distance/2
	var/y = abs_y_distance >> 1 //Bit-shifting makes me l33t.  It also makes get_line() unnecessarily fast.

	if(abs_x_distance >= abs_y_distance) //x distance is greater than y
		for(var/distance_counter in 0 to (abs_x_distance - 1))//It'll take abs_x_distance steps to get there
			y += abs_y_distance

			if(y >= abs_x_distance) //Every abs_y_distance steps, step once in y direction
				y -= abs_x_distance
				current_y_step += y_distance_sign

			current_x_step += x_distance_sign //Step on in x direction
			line += locate(current_x_step, current_y_step, starting_z)//Add the turf to the list
	else
		for(var/distance_counter in 0 to (abs_y_distance - 1))
			x += abs_x_distance

			if(x >= abs_y_distance)
				x -= abs_y_distance
				current_x_step += x_distance_sign

			current_y_step += y_distance_sign
			line += locate(current_x_step, current_y_step, starting_z)
	return line

/// Returns human-readable (compass) direction from angle.
/proc/get_precise_direction_from_angle(angle)
	// ATAN2 gives angle from positive x-axis (east) to the vector
	// We need to:
	// 1. Convert to compass degrees (0°=north, 90°=east)
	// 2. Invert the direction (show direction TO target FROM player)

	// Normalize angle first
	angle = (angle + 360) % 360

	// Convert to compass bearing (0°=north, 90°=east)
	var/compass_angle = (450 - angle) % 360  // 450 = 360 + 90

	// Return direction based on inverted compass angle
	// Return direction based on inverted compass angle
	switch(compass_angle)
		if(348.75 to 360, 0 to 11.25)
			return "north"
		if(11.25 to 33.75)
			return "north-northeast"
		if(33.75 to 56.25)
			return "northeast"
		if(56.25 to 78.75)
			return "east-northeast"
		if(78.75 to 101.25)
			return "east"
		if(101.25 to 123.75)
			return "east-southeast"
		if(123.75 to 146.25)
			return "southeast"
		if(146.25 to 168.75)
			return "south-southeast"
		if(168.75 to 191.25)
			return "south"
		if(191.25 to 213.75)
			return "south-southwest"
		if(213.75 to 236.25)
			return "southwest"
		if(236.25 to 258.75)
			return "west-southwest"
		if(258.75 to 281.25)
			return "west"
		if(281.25 to 303.75)
			return "west-northwest"
		if(303.75 to 326.25)
			return "northwest"
		if(326.25 to 348.75)
			return "north-northwest"
