class QuotesController < ApplicationController
  def index
    @quotes = Quote.all()
  end

  def new
    @quote = Quote.new
  end

  def random
  end
  
  def search
  end
  
  def browse
  end

  def create
    @quote = Quote.new
    @quote.content = params[:quote][:content]

    if @quote.save
      redirect_to quotes_path, :notice => 'Thanks, quote accepted'
    else
      render :action => "new"
    end
  end

  def show
    @quote = Quote.find(params[:id])
  end

end
