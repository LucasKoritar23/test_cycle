class TestesController < ApplicationController
  before_action :set_testis, only: [:show, :update, :destroy]

  # GET /testes
  def index
    @testes = Teste.all
    @testes = @testes.filter_by_nome_teste(params[:nome]) if params[:nome].present?
    render json: @testes
  end

  # GET /testes/1
  def show
    render json: @testis
  end

  # POST /testes
  def create
    valid = ValidateTeste.new.validate_post_teste(testis_params)
    if valid == []
      @testis = Teste.new(testis_params)
      @testis.save
      render json: @testis, status: :created, location: @testis if @testis.save
      render json: ValidateTeste.new.unique_value(@testis.errors), status: :bad_request, location: @testis unless @testis.save
    else
      render json: valid, status: :bad_request
    end
  end

  # PATCH/PUT /testes/1
  def update
    valid = ValidateTeste.new.validate_edit_teste(testis_params)
    if valid == []
      if @testis.update(testis_params)
        render json: @testis
      else
        render json: ValidateTeste.new.unique_value(@testis.errors), status: :bad_request, location: @testis
      end
    else
      render json: valid, status: :bad_request
    end
  end

  # DELETE /testes/1
  def destroy
    @testis.destroy
    render json: { message: "Teste deletado com sucesso" }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_testis
    begin
      @testis = Teste.find(params[:id])
    rescue => e
      puts e.message
      render json: { message: "Id do teste não encontrado" }, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def testis_params
    params.require(:testis).permit(:suite_id, :nome)
  end
end
