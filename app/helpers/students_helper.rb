module StudentsHelper
    def generate_next_task(student)
        student_join_select_stat = student.extern_joins_stat
        student_forces_select_stat = student.forces_moments_stat
        problems_available = get_available_problems(student)
        if problems_available.present?
            while true
                problems_available.each do |problem|
                    if compatible_stats(student_forces_select_stat, student_join_select_stat, problem)
                        return Task.create!(
                            extern_joins_exp: problem.extern_joins_points/10,
                            forces_moments_exp: problem.forces_moments_points/10,
                            problem_id: problem.id,
                            student_id: student.id)
                    end
                end
                student_join_select_stat += 2
                student_forces_select_stat += 2
            end
        end
    end

    def problems_available?
        Problem.first.present?
    end

    def compatible_stats(current_force_stat, current_join_stat, problem)
        problem_join_stat_diference = problem.extern_joins_points - 2 <= current_join_stat
        problem_force_stat_diference = problem.forces_moments_points - 2 <= current_force_stat
        if problem_force_stat_diference && problem_force_stat_diference
            true
        else
            false
        end
    end

    def get_available_problems(student)
        student_tasks = get_student_tasks(student)
        completed_problems = []
        if student_tasks.present?
            student_task.each do |task|
                completed_problems.push(task.problem)
            end
        end
        available_problems = []
        Problem.all.each do |problem|
            if !completed_problems.include? problem
                available_problems.push(problem)
            end
        end
        available_problems
    end

    def get_student_tasks(student)
        Task.where(student: student)
    end
end
