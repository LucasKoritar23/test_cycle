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
    @testis = Teste.new(testis_params)

    if @testis.save
      render json: @testis, status: :created, location: @testis
    else
      render json: @testis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /testes/1
  def update
    if @testis.update(testis_params)
      render json: @testis
    else
      render json: @testis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /testes/1
  def destroy
    @testis.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testis
      @testis = Teste.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def testis_params
      params.require(:testis).permit(:suite_id, :nome)
    end
end
