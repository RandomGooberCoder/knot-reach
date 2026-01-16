/mob/proc/lord_marriage_choice()
	
	var/datum/job/consort_job = SSjob.GetJob("Consort")

	//Safety for if the duke far travels and another duke replaces them.
	if(consort_job.total_positions > 0)
		return

	if(!client)
		addtimer(CALLBACK(src, PROC_REF(lord_marriage_choice)), 50)
		return
	var/marriage_choice = list("Married (Consort)","Single")
	var/choice = input(src, "I am...", "ROGUETOWN - Marriage Options") as anything in marriage_choice
	switch(choice)
		if("Married (Consort)")
			consort_job.total_positions = 1
			consort_job.spawn_positions = 1
