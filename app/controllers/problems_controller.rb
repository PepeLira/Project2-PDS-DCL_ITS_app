class ProblemsController < ApplicationController
  before_action :require_user
  before_action :set_problem, only: %i[ show edit update destroy ]

  # GET /problems or /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1 or /problems/1.json
  def show
    @current_steps = []
    Step.where(problem_id: @problem.id).each do |step|
      @current_steps.push(step.step_type)
    end
    @difficulty_b = @problem.get_supports_points
    @difficulty_f = @problem.get_forces_points
    @forces_ecuation_x = @problem.make_xforce_ecuation()#"10 ∗ cos(60°) + Bx + 5 + 8 ∗ cos(45°) = 0"
    @forces_ecuation_y = @problem.make_yforce_ecuation()#"−10 ∗ sin(60°) + By − 8 ∗ sin(45°) + Dy − 5 = 0"
    @moment_ecuation = " 3 ∗ 10 ∗ sin(60°) − 1 − 1 ∗ 8 ∗ cos(45°) − 6 ∗ 8 ∗ sin(45°) − 9 ∗ 5 + 1 ∗ 5 + 11 ∗ Dy"
  end

  # GET /problems/new
  def new
    @admin_teacher = AdminTeacher.first
    @new_structure = Structure.new
    if Problem.first.present?
      @title = "Problem #" + (Problem.last.id + 1).to_s
    else
      @title = "Problem #1" 
    end
    @structure = Structure.new
    @problem = Problem.new
    @problem.build_structure
  end

  # GET /problems/1/edit
  def edit
    @title = "Problem #" + (@problem.id).to_s
  end

  # POST /problems or /problems.json
  def create
    
    @problem = Problem.new(problem_params)
    

    respond_to do |format|
      if @problem.save
        if @problem.step1 == "1"
          @step1 = Step.new(title: nil, description: "nn", step_type: "Representacion", problem_id: @problem.id)
          @step1.save
        end
        
        if @problem.step2 == "1"
          @step2 = Step.new(title: nil, description: "nn", step_type: "Determinar Cuerpos", problem_id: @problem.id)
          @step2.save
        end
        
        if @problem.step3 == "1"
          @step3 = Step.new(title: nil, description: "nn", step_type: "DCL", problem_id: @problem.id)
          @step3.save
        end
    
        if @problem.step4 == "1"
          @step4 = Step.new(title: nil, description: "nn", step_type: "Ecuaciones", problem_id: @problem.id)
          @step4.save
        end

        # create_an_asociated_task(@problem)
        
        format.html { redirect_to problem_url(@problem), notice: "Problem was successfully created." }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1 or /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to problem_url(@problem), notice: "Problem was successfully updated." }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1 or /problems/1.json
  def destroy
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url, notice: "Problem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def create_an_asociated_task(problem)
      Task.create(problem: problem, student_id: 1)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_params
      params.require(:problem).permit(
        :admin_teacher_id, 
        :title, 
        :description, 
        :extern_joins_points, 
        :forces_moments_points,
        :con_rod_points, 
        :ball_joint_points, 
        :image, 
        :step1,
        :step2,
        :step3,
        :step4,
        structure_attributes: [:nodes_list, :segments_list, :struct_link, :force_values, :moment_values, :admin_teacher_id, :moment_reference]
      )
    end
end
