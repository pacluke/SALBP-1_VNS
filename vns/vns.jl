
# vns.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira (https://github.com/isadorasop)"

include("./instance_parser.jl")
include("./data_structure.jl")

function print_solution(sol::Solution)

	station::Int64 = 0
    foreach(x->println("Station $(station+=1) is composed by $(x[1]) and has $(x[2]) time unit(s) of cycle time."),
    	sol.stations)
    print("\n")
    println("The solution has $(length(sol.stations)) stations.")
    print("\n")

end

function dfs(inst::Instance, task_a::Int64, task_b::Int64)

	for i::Int64 in 1:inst.number_of_tasks
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

	return ((sol.stations[station_index][2] + inst.tasks_time[task]) <= inst.maximum_cicle_time)

end

function add_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	if station_index <= length(sol.stations)

		if verify_task_time(inst, sol, station_index, task)

			for task_b in sol.stations[station_index][1]
				if !(verify_precedence(inst, task, task_b))
				    return false
				end
			end

			push!(sol.stations[station_index][1], task)
			sol.stations[station_index] = tuple(sol.stations[station_index][1],
				sol.stations[station_index][2] + inst.tasks_time[task])

			return true
		end

		return false
	else

		push!(sol.stations, tuple([task], inst.tasks_time[task]))
		return true
	end

	return false
end

function remove_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	filter!(x->x != task, sol.stations[station_index][1])
	sol.stations[station_index] = tuple(sol.stations[station_index][1],
			sol.stations[station_index][2] - inst.tasks_time[task])

	if length(sol.stations[station_index][1]) == 0
		deleteat!(sol.stations, station_index)
	end

end

function get_station_by_task(sol::Solution, task::Int64)

	for i::Int64 in 1:length(sol.stations)
	    if task in sol.stations[i][1]
	        return i
	    end
	end

    return 0
end

function get_minor_station(sol::Solution)

	minor_index = 1

	for index::Int64 in 1:length(sol.stations)

	    if sol.stations[minor_index][2] > sol.stations[index][2]
	        minor_index = index
	    end

	end

	return minor_index

end

function simple_initial_solution(inst::Instance)

    sol::Solution = Solution([])

    for i::Int64 in 1:inst.number_of_tasks
        push!(sol.stations, tuple([i], inst.tasks_time[i]))
    end

    # print_solution(sol)

    return sol

end

function greedy_initial_solution(inst::Instance)

	# de alguma forma, criar uma solução gulosa
	# que não seja muito custosa, mas que ajude
	# a começar bem o algoritmo

	#TODO

	sol::Solution = Solution([])

	check = Array{Bool}(inst.number_of_tasks)
	sol_index::Int64 = 1

	for k::Int64 in 1:inst.number_of_tasks
		check[k] = false
	end

	for i::Int64 in 1:inst.number_of_tasks
		if check[i] == false
			push!(sol.stations, tuple([i], inst.tasks_time[i]))
			check[i] = true
			for j::Int64 in i+1:inst.number_of_tasks
				if check[j] == false
					insert = add_task(inst, sol, sol_index, j)
					if insert == true
						check[j] = true
					end
				end
			end
			sol_index = sol_index +1
		end
	end
	return sol
end

function generate_neighbours(inst::Instance, sol::Solution, neighbourood_number::Int64)

	# gerar soluções da forma menos custosa possível

    #TODO

    neighbourood::Array{Solution, 1} = []


    # for i::Int64 in 1:Int64(ceil(inst.number_of_tasks/2))
    for i::Int64 in 1:inst.number_of_tasks

    	station_index::Int64 = 1
    	added::Bool = false

    	neighbour::Solution = deepcopy(sol)

    	while ((station_index <= length(sol.stations)))

    		task_station = get_station_by_task(neighbour, inst.ordered_tasks[i])

    	    if (task_station != station_index)

	    	    added = add_task(inst, neighbour, station_index, inst.ordered_tasks[i])

	    	    if added
	    	    	remove_task(inst, neighbour, task_station, inst.ordered_tasks[i])
	    	    	push!(neighbourood, neighbour)
	    	    	break
	    	    end

	    	end

	    	station_index += 1

    	end

    end

    neigh_length::Int64 = length(neighbourood)

    for csgo::Int64 in 1:neighbourood_number

    	for neigh in 1:neigh_length

		    for i::Int64 in 1:Int64(ceil(inst.number_of_tasks/2))

		    	station_index::Int64 = 1
		    	added::Bool = false

		    	neighbour::Solution = deepcopy(neighbourood[neigh])

		    	while ((station_index <= length(neighbourood[neigh].stations)))

		    		task_station = get_station_by_task(neighbour, inst.ordered_tasks[i])

		    	    if (task_station != station_index)

			    	    added = add_task(inst, neighbour, station_index, inst.ordered_tasks[i])

			    	    if added
			    	    	remove_task(inst, neighbour, task_station, inst.ordered_tasks[i])
			    	    	push!(neighbourood, neighbour)
			    	    	break
			    	    end

			    	end

			    	station_index += 1

		    	end

		    end

    	end

    end


    return neighbourood

end

function shake(inst::Instance, sol::Solution, neighbourood::Int64)

	# acho que vou usar a shake pra remover nodos e a
	# geradora de vizinhos pra colocar dentro

    #TODO

end

function local_search(solutions::Array{Solution, 1})

	# tem que escolher a melhor solução em um vetor de soluções
	# mas se duas tiverem o mesmo número de estaçãoes
	# como escolher qual é mais promissora?

    #TODO

    best_solution::Solution = solutions[1]

    for i in 2:length(solutions)
        if (length(solutions[i].stations) <= length(best_solution.stations))
        	best_solution = solutions[i]
        end
    end

    return best_solution

end

function VNS(inst::Instance, initial_solution::Solution, max_neighborhoods::Int64, max_iterations::Int64)
    # tic() # tempo inicial

    # for i in 1:max_iterations
    #     k = 1

    #     while k <= max_neighborhoods

    #         x1 = shake(inst, initial_solution, k)

    #         x2 = local_search(generate_neighbours(inst, x1, k)) # aqui seria o hill climbing

    #         if length(x2.stations) < length(initial_solution.stations)
    #             initial_solution = x2
    #             k = 1
    #         else

    #             k += 1
    #         end
    #     end
    # end

    # toc() # tempo final
    # return initial_solution
end



function main()

	filename::String = ARGS[1]
	cycle_time::Int64 = parse(Int64, ARGS[2])
	seed::Int64 = parse(Int64, ARGS[3])

	full_instance::Instance = read_instance_file(filename, cycle_time)

	initial_solution = simple_initial_solution(full_instance)

	greedy_solution = greedy_initial_solution(full_instance)

	# print_solution(initial_solution)

	# println(add_task(full_instance, initial_solution, 1, 2))

	# print_solution(initial_solution)

	# remove_task(full_instance, initial_solution, 1, 1)

	#print_solution(initial_solution)
	print_solution(greedy_solution)

	# println(get_minor_station(initial_solution))


	neighbourhood::Array{Solution, 1} = generate_neighbours(full_instance, initial_solution, 10)

	# for i::Int64 in 1:length(neighbourhood)
	#    println("..::: Solution $i :::..")
	#    print_solution(neighbourhood[i])
	# end

	print_solution(local_search(neighbourhood))


	####################################################################

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
