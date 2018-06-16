
# vns.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira (https://github.com/isadorasop)"

include("./instance_parser.jl")
include("./data_structure.jl")

function print_solution(sol::Solution)

	station::Int64 = 0
    foreach(x->println("Station $(station+=1) is composed by $(x[1]) and has $(x[2]) time unit(s) of cycle time.") ,sol.stations)
    print("\n")
    println("The solution has $(length(sol.stations)) stations.")
    print("\n")

end

function dfs(inst::Instance, task_a::Int64, task_b::Int64)

	for i in 1:inst.number_of_tasks
		# println("Visiting $i")
		if inst.adjacency_matrix[task_a, i]
			if i == task_b
			    return true	    
			elseif dfs(inst, i, task_b)
				return true
			end
		end
	end

	return false
end

function verify_precedence(inst::Instance, task_a::Int64, task_b::Int64)
	if(inst.adjacency_matrix[task_a, task_b] || inst.adjacency_matrix[task_b, task_a])
	    return true
	else
		return !(dfs(inst, task_a, task_b) || dfs(inst, task_b, task_a))
	end
end


function verify_task_time(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	return (sol.stations[station_index][2] + inst.tasks_time[task]) <= inst.maximum_cicle_time
    
end

function add_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	if verify_task_time(inst, sol, station_index, task)

		for task_b in sol.stations[station_index][1]
			if !(verify_precedence(inst, task, task_b))
			    return false
			end
		end

		push!(sol.stations[station_index][1], task)
		# temp::Int64 = sol.stations[station_index][2] + inst.tasks_time[task]
		sol.stations[station_index] = tuple(sol.stations[station_index][1],
			sol.stations[station_index][2] + inst.tasks_time[task])

		# println(temp)

		return true
	    
	end

	return false
    
end

function remove_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	filter!(x->x != task, sol.stations[station_index][1])
	sol.stations[station_index] = tuple(sol.stations[station_index][1],
			sol.stations[station_index][2] - inst.tasks_time[task])

end

function simple_initial_solution(inst::Instance)
    
    sol::Solution = Solution([])

    for i in 1:inst.number_of_tasks
        push!(sol.stations, tuple([i], inst.tasks_time[i]))
    end

    # print_solution(sol)

    return sol

end

# function greedy_initial_solution(inst::Instance)

# 	sol::Solution = Solution([])

# end


function main()

	filename::String = ARGS[1]
	cycle_time::Int64 = parse(Int64, ARGS[2])
	seed::Int64 = parse(Int64, ARGS[3])

	full_instance::Instance = read_instance_file(filename, cycle_time)

	initial_solution = simple_initial_solution(full_instance)

	print_solution(initial_solution)

	println(add_task(full_instance, initial_solution, 1, 2))

	print_solution(initial_solution)

	remove_task(full_instance, initial_solution, 1, 2)

	print_solution(initial_solution)

	# for i in 1:full_instance.number_of_tasks
	# 	for j in 1:full_instance.number_of_tasks
	# 		println("($i -> $j) is $(verify_precedence(full_instance, i, j))")
	# 		verify_precedence(full_instance, i, j)
	# 	end
	# end

	# for i in 1:full_instance.number_of_tasks
	# 	for j in 1:full_instance.number_of_tasks
	#    		println("Precedence of ($(i), $(j))$(verify_precedence(full_instance, i, j))")
	#    	end 
	# end
    
end

main()