class CheesesController < ApplicationController

  def index
    if current_user
      @cheeses = Cheese.all
    else
      redirect_to '/'
      flash[:notice] = "You must register or log in before you can do that!"
    end
  end

  def new
    @cheese = Cheese.new
  end

  def create
    @cheese = Cheese.new(params.require(:cheese).permit(:name, :price_per_lb))
    if @cheese.save
      redirect_to cheeses_path
      flash[:notice] = "Cheese created successfully!"
    else
      render :edit
    end
  end

  def edit
    @cheese = Cheese.find(params[:id])
  end

  def show
    @cheese = Cheese.find(params[:id])
  end

  def update
    @cheese = Cheese.find(params[:id])
    if @cheese.update(params.require(:cheese).permit(:name, :price_per_lb))
      redirect_to cheese_path
      flash[:notice] = "Cheese updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @cheese = Cheese.find(params[:id])
      flash[:notice] = "Deleted cheese: " + @cheese.name
        @cheese.destroy
      redirect_to cheeses_path
  end
end
