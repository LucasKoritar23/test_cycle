class ExectestsController < ApplicationController
  before_action :set_exectest, only: [:show, :update, :destroy]

  # GET /exectests
  def index
    @exectests = Exectest.all

    render json: @exectests
  end

  # GET /exectests/1
  def show
    render json: @exectest
  end

  # POST /exectests
  # def create
  #   valid = ValidateExecTest.new.exec_already(exectest_params_post)
  #   @exectest = Exectest.new(exectest_params_post)
  #   if @exectest.save
  #     render json: @exectest, status: :created, location: @exectest
  #   else
  #     render json: @exectest.errors, status: :unprocessable_entity
  #   end
  # end
  #

  def create
    valid = ValidateExectest.new.validate_post_exectest(exectest_params_post)
    exist = ValidateExectest.new.exec_already_test(exectest_params_post) if valid == []
    @exectest = Exectest.new(exectest_params_post)
    return render json: exist, status: :bad_request, location: @exectest if exist != [] and valid == []

    if valid == []
      if @exectest.save
        render json: @exectest, status: :created, location: @exectest if @exectest.save
      else
        render json: ValidateExectest.new.unique_value(@exectest.errors), status: :bad_request, location: @exectest unless @exectest.save
      end
    else
      render json: valid, status: :bad_request
    end
  end

  # PATCH/PUT /exectests/1
  def update
    if @exectest.update(exectest_params_put)
      render json: @exectest
    else
      render json: @exectest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /exectests/1
  def destroy
    @exectest.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exectest
    @exectest = Exectest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exectest_params_post
    begin
      p = params.require(:exectest).permit(:qa_id, :suite_id, :teste_id, :execucao_uuid, :data_inicio, :data_fim, :status, :evidencia, :comentario)
      p[:execucao_uuid] = SecureRandom.uuid
      p[:data_inicio] = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L")
      p[:status] = "IN_PROGRESS"
    rescue => e
      puts e
    end
    p
  end

  def exectest_params_put
    begin
      p = params.require(:exectest).permit(:qa_id, :suite_id, :teste_id, :execucao_uuid, :data_inicio, :data_fim, :status, :evidencia, :comentario)
      p[:data_fim] = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L")
    rescue => e
      puts e
    end

    p
  end
end
