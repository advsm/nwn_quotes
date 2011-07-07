class QuotesController < ApplicationController
  def index
    @quotes = Quote.all()
  end

  def new
    @quote = Quote.new
  end

  def random
  end


  def create
    @quote = Quote.new(params[:quote])

		if @quote.save
			redirect_to @quote, :notice => 'Quote was successfully created.'
		else
			render :action => "new"
		end
  end

  def show
    @quote = Quote.find(params[:id])
  end

end
