class SuitesController < ApplicationController
  before_action :set_suite, only: [:show, :update, :destroy]

  # GET /suites
  def index
    @suites = Suite.all
    @suites = @suites.filter_by_nome_suite(params[:nome]) if params[:nome].present?
    render json: @suites
  end

  # GET /suites/1
  def show
    render json: @suite
  end

  # POST /suites
  def create
    valid = ValidateSuite.new.validate_post_suite(suite_params)
    if valid == []
      @suite = Suite.new(suite_params)
      @suite.save
      render json: @suite, status: :created, location: @suite if @suite.save
      render json: ValidateSuite.new.unique_value(@suite.errors), status: :bad_request, location: @suite unless @suite.save
    else
      render json: valid, status: :bad_request
    end
  end

  # PATCH/PUT /suites/1
  def update
    valid = ValidateSuite.new.validate_edit_suite(suite_params)
    if valid == []
      @suite.update(suite_params)
      if @suite.update(suite_params)
        render json: @suite
      end
    else
      render json: valid, status: :bad_request
    end
  end

  # DELETE /suites/1
  def destroy
    begin
      @suite.destroy
      render json: { message: "Suite deletada com sucesso", item: JSON.parse(@suite.to_json) }, status: :ok
    rescue ActiveRecord::InvalidForeignKey
      render json: { message: "A suite possui testes vinculados" }, status: :bad_request
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_suite
    begin
      @suite = Suite.find(params[:id])
    rescue => e
      puts e.message
      render json: { message: "Id da suite não encontrado" }, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def suite_params
    begin
      params.require(:suite).permit(:nome)
    rescue => e
      puts e
    end
  end
end
