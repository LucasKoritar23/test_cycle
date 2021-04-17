class StepsController < ApplicationController
  before_action :set_step, only: [:show, :update, :destroy]

  # GET /steps
  def index
    @steps = Step.all
    @steps = @steps.filter_by_nome_step(params[:nome]) if params[:nome].present?
    @steps = @steps.filter_by_suite_id(params[:suite_id]) if params[:suite_id].present?
    @steps = @steps.filter_by_teste_id(params[:teste_id]) if params[:teste_id].present?
    render json: @steps
  end

  # GET /steps/1
  def show
    render json: @step
  end

  # POST /steps
  def create
    valid = ValidateStep.new.validate_post_step(step_params)
    if valid == []
      @step = Step.new(step_params)
      @step.save
      render json: @step, status: :created, location: @step if @step.save
      render json: ValidateStep.new.unique_value(@step.errors), status: :bad_request, location: @step unless @step.save
    else
      render json: valid, status: :bad_request
    end
  end

  # PATCH/PUT /steps/1
  def update
    valid = ValidateStep.new.validate_edit_step(step_params)
    if valid == []
      render json: @step, status: :ok, location: @step if @step.update(step_params)
      render json: ValidateStep.new.unique_value(@step.errors), status: :bad_request, location: @step unless @step.update(step_params)
    else
      render json: valid, status: :bad_request
    end
  end

  # DELETE /steps/1
  def destroy
    begin
      @step.destroy
      render json: { message: "Step deletado com sucesso", item: JSON.parse(@step.to_json) }, status: :ok
    rescue ActiveRecord::InvalidForeignKey
      render json: { message: "O Step possui testes/suites vinculadas" }, status: :ok
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_step
    begin
      @step = Step.find(params[:id])
    rescue => e
      puts e.message
      render json: { message: "Id do step não encontrado" }, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def step_params
    begin
      params.require(:step).permit(:suite_id, :teste_id, :nome)
    rescue => e
      puts e
    end
  end
end
