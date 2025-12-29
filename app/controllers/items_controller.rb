require "csv"

class ItemsController < ApplicationController
  before_action :require_login
  before_action :set_item, only: %i[show edit update destroy]

  # ======================
  # INDEX / FILTER / SORT
  # ======================
  def index
    @categories = Category.all
    @items = current_user.items

    if params[:search].present?
      @items = @items.where("name ILIKE ?", "%#{params[:search]}%")
    end

    if params[:category_id].present? && params[:category_id] != "all"
      @items = @items.where(category_id: params[:category_id])
    end

    case params[:sort]
    when "name_asc"
      @items = @items.order(name: :asc)
    when "name_desc"
      @items = @items.order(name: :desc)
    when "qty_asc"
      @items = @items.order(quantity: :asc)
    when "qty_desc"
      @items = @items.order(quantity: :desc)
    end
  end

  def show; end

  def new
    @item = current_user.items.new
  end

  def edit; end

  # =======
  # CREATE
  # =======
  def create
    @item = current_user.items.new(item_params)

    if @item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to items_path, notice: "Item was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # =======
  # UPDATE
  # =======
  def update
    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to items_path, notice: "Item was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # ========
  # DESTROY
  # ========
  def destroy
    @item.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to items_path, notice: "Item was successfully destroyed." }
    end
  end

  # ===========
  # CSV EXPORT
  # ===========
  def export
    csv = current_user.items.to_csv

    send_data csv,
              filename: "items-#{Date.today}.csv",
              type: "text/csv"
  end

  # ===========
  # CSV IMPORT
  # ===========
  def import
    if params[:file].blank?
      redirect_to items_path, alert: "Please upload a CSV file."
      return
    end

    Item.import(params[:file])
    redirect_to items_path, notice: "Items imported successfully."
  end

  private

  # ===========
  # HELPERS
  # ===========
  def set_item
    @item = current_user.items.find_by(id: params[:id])
    redirect_to items_path, alert: "Not authorized" unless @item
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :category_id)
  end
end
