class CapitulosController < ApplicationController
  before_action :set_capitulo, only: [:show, :edit, :update, :destroy]

  # GET /capitulos
  # GET /capitulos.json
  def index
    @capitulos = Capitulo.all
  end

  # GET /capitulos/1
  # GET /capitulos/1.json
  def show
    @user = current_user
  end

  def showsome
    @serie = Serie.find_by_id(params[:id])
    @capitulos = @serie.capitulos
    @user = current_user.id
  end

  # GET /capitulos/new
  def new
    @capitulo = Capitulo.new
  end

  # GET /capitulos/1/edit
  def edit
    @capitulo = Capitulo.find_by_id(params[:id])
  end

  # POST /capitulos
  # POST /capitulos.json
  def create
    @capitulo = Capitulo.new(capitulo_params)

    respond_to do |format|
      if @capitulo.save
        uid = current_user.id
        users = User.where(parent_id: uid).all
        MailerMailer.mail1(users, @capitulo.title).deliver
        format.html { redirect_to @capitulo, notice: 'Capitulo was successfully created.' }
        format.json { render :show, status: :created, location: @capitulo }
      else
        format.html { render :new }
        format.json { render json: @capitulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /capitulos/1
  # PATCH/PUT /capitulos/1.json
  def update
    @capitulo = Capitulo.find_by_id(params[:id])

      if @capitulo.update(capitulo_params)
        redirect_to capitulos_path, :notice => 'Capitulo was successfully updated.'
      else
        render "edit"
    end

  end

  # DELETE /capitulos/1
  # DELETE /capitulos/1.json
  def destroy
    @capitulo.destroy
    respond_to do |format|
      format.html { redirect_to capitulos_url, notice: 'Capitulo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capitulo
      @capitulo = Capitulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capitulo_params
      params.require(:capitulo).permit(:name, :serie_id, :parent_id, :id)
    end
end
