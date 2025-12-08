class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
    @items = Item.all

    # SEARCH
    if params[:search].present?
      @items = @items.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # CATEGORY FILTER
    if params[:category_id].present? && params[:category_id] != "all"
      @items = @items.where(category_id: params[:category_id])
    end

    # SORTING
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
## csv export



  def show; end
  def new; @item = Item.new end
  def edit; end


  # CREATE
  def create
    @item = Item.new(item_params)

    if @item.save
      respond_to do |format|
        format.turbo_stream   # uses create.turbo_stream.erb
        format.html { redirect_to items_path, notice: "Item was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end


  # UPDATE
  def update
    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream   # uses update.turbo_stream.erb
        format.html { redirect_to items_path, notice: "Item was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE
  def destroy
    # Item already loaded by set_item
    @item.destroy if @item

    respond_to do |format|
      format.turbo_stream   # uses destroy.turbo_stream.erb
      format.html { redirect_to items_path, notice: "Item was successfully destroyed." }
    end
  end

  private

  # SAFE FIND — prevents RecordNotFound crash
  def set_item
    @item = Item.find_by(id: params[:id])

    # If nil (record deleted or invalid id), stop gracefully
    head :not_found unless @item
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :category_id)
  end
end
