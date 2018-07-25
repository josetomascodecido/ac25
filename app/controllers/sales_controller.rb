class SalesController < ApplicationController

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @discount = @sale.value.to_i * (@sale.discount.to_f/100)
    @sale.total = @sale.value.to_i - @discount
    if @sale.tax == 0
      @sale.total = @sale.total.to_f * 1.19
    end
    @sale.save
    redirect_to sales_done_path
  end

  def done
    @sales = Sale.all
  end


  private
  def sale_params

    params.require(:sale).permit(:cod, :detail, :category, :value, :discount, :tax)
  end
end
