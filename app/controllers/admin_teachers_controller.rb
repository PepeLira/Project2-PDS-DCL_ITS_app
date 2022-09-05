class AdminTeachersController < ApplicationController
  before_action :set_admin_teacher, only: %i[ show edit update destroy ]

  # GET /admin_teachers or /admin_teachers.json
  def index
    @admin_teachers = AdminTeacher.all
  end

  # GET /admin_teachers/1 or /admin_teachers/1.json
  def show
  end

  # GET /admin_teachers/new
  def new
    @admin_teacher = AdminTeacher.new
  end

  # GET /admin_teachers/1/edit
  def edit
  end

  # POST /admin_teachers or /admin_teachers.json
  def create
    @admin_teacher = AdminTeacher.new(admin_teacher_params)

    respond_to do |format|
      if @admin_teacher.save
        format.html { redirect_to admin_teacher_url(@admin_teacher), notice: "Admin teacher was successfully created." }
        format.json { render :show, status: :created, location: @admin_teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_teachers/1 or /admin_teachers/1.json
  def update
    respond_to do |format|
      if @admin_teacher.update(admin_teacher_params)
        format.html { redirect_to admin_teacher_url(@admin_teacher), notice: "Admin teacher was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_teachers/1 or /admin_teachers/1.json
  def destroy
    @admin_teacher.destroy

    respond_to do |format|
      format.html { redirect_to admin_teachers_url, notice: "Admin teacher was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_teacher
      @admin_teacher = AdminTeacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_teacher_params
      params.require(:admin_teacher).permit(:full_name, :password)
    end
end
