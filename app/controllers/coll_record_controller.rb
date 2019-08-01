class CollRecordController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_coll_record, only: [:show, :edit, :update, :destroy]

  def index
    @coll_records = CollRecord.all
  end

  def show
  end

  def new
    
    @coll_record = CollRecord.new
  end

  def edit
  end

  def create
    @coll_record = CollRecord.new(coll_record_params)

    respond_to do |format|
      if @coll_record.save
        format.html { redirect_to @coll_record, notice: 'Collection record was successfully created.' }
        format.json { render :show, status: :created, location: @coll_record }
      else
        format.html { render :new }
        format.json { render json: @coll_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @coll_record.update(coll_record_params)
        format.html { redirect_to @coll_record, notice: 'Collection record  was successfully updated.' }
        format.json { render :show, status: :ok, location: @coll_record }
      else
        format.html { render :edit }
        format.json { render json: @coll_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coll_record.destroy
    respond_to do |format|
      format.html { redirect_to coll_records_url, notice: 'Collection record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coll_record
    #  @coll_record = CollRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coll_record_params
     # params.fetch(:coll_record, {})
    end
end
