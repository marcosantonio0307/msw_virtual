class Api::V1::ProductsController < Api::V1::ApiController
  before_action :require_authorization!, only:[:show, :update, :destroy]

  def index
	@products = current_user.products

	render json: @products
  end

  def create
  	@product = Product.create(product_params.merge(user: current_user))
  	if @product.save
  	  render json: @product, status: :created
  	else
  	  render json: @product.errors, status: :unprocessable_entily	
  	end
  end

  private
    def require_authorization!
      @product = Product.find(params[:id])
      unless current_user == @product.user
      	render json: {}, status: :forbidden
      end
    end

    def product_params
    	params.require(:product).permit(:name, :description, :price, :status)
    end
end
