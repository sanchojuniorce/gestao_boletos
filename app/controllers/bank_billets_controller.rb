class BankBilletsController < ApplicationController
  before_action :set_bank_billet, only: %i[ show edit update destroy new]

  # GET /bank_billets or /bank_billets.json
  def index
    @bank_billets = BankBillet.list_bank
  end

  # GET /bank_billets/1 or /bank_billets/1.json
  def show
  end

  # GET /bank_billets/new
  def new
    @bank_billet = BankBillet.new
  end

  # GET /bank_billets/1/edit
  def edit
  end

  # POST /bank_billets or /bank_billets.json
  def create
    @bank_billet = BankBillet.create_bank(bank_billet_params)
    respond_to do |format|
      format.html { redirect_to bank_billets_path, notice: "Bank billet was successfully created." }
    end  
  end

  # PATCH/PUT /bank_billets/1 or /bank_billets/1.json
  def update
    respond_to do |format|
      if @bank_billet.update(bank_billet_params)
        format.html { redirect_to bank_billet_url(@bank_billet), notice: "Bank billet was successfully updated." }
        format.json { render :show, status: :ok, location: @bank_billet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bank_billet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_billets/1 or /bank_billets/1.json
  def destroy
    @bank_billet.destroy!

    respond_to do |format|
      format.html { redirect_to bank_billets_url, notice: "Bank billet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_billet
      if params[:action] != 'new'
        @bank_billet = BankBillet.find(params[:id])
      end  
      @interest_types = [["Inexistente",0],["Para porcentagem diária",1],["Para valor diário",2]]
      @interest_days_types = [["Corridos",0],["Úteis",1]]
      @fine_types = [["Inexistente",0],["Para percentual do valor do boleto",1],["Para valor fixo",2]]
      @discount_types = [["Inexistente",0],["Para valor fixo",1],["Para percentual do valor do boleto",2]]
      @charge_types = [["Simples",1],["Vinculada",2],["Descontada",3],["Vendor",4]]
      @dispatch_types = [["Cliente",1],["Banco",2]]
      @document_types = BankBillet.document_types
      @acceptances = [["Não","N"],["Sim","S"]]
      @instructions_modes = [["Não preencher as instruções para o caixa",0],["Calcular data pela via de registro (API/CNAB)",1],["Usar a data configurada no boleto",2]]
    end

    # Only allow a list of trusted parameters through.
    def bank_billet_params
      params.fetch(:bank_billet, {})
    end
end
