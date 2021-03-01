class QasController < ApplicationController
  before_action :set_qa, only: [:show, :update, :destroy]

  # GET /qas
  def index
    @qas = Qa.all
    @qas = @qas.filter_by_nome_qa(params[:nome]) if params[:nome].present?
    render json: @qas
  end

  # GET /qas/1
  def show
    render json: @qa
  end

  # POST /qas
  def create
    valid = ValidateQa.new.validate_post_qa(qa_params)
    if valid == []
      @qa = Qa.new(qa_params)
      @qa.save
      render json: @qa, status: :created, location: @qa if @qa.save
      render json: ValidateQa.new.unique_value(@qa.errors), status: :bad_request, location: @qa unless @qa.save
    else
      render json: valid, status: :bad_request
    end
  end

  # PATCH/PUT /qas/1
  def update
    valid = ValidateQa.new.validate_edit_qa(qa_params)
    if valid == []
      @qa.update(qa_params)
      if @qa.update(qa_params)
        render json: @qa
      end
    else
      render json: valid, status: :bad_request
    end
  end

  # DELETE /qas/1
  def destroy
    @qa.destroy
    render json: { message: "QA deletado com sucesso" }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_qa
    @qa = Qa.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def qa_params
    begin
      params.require(:qa).permit(:id, :nome, :tribo, :squad)
    rescue => e
      puts e
    end
  end
end
