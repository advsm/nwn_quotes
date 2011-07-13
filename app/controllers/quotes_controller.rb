class QuotesController < ApplicationController
  before_filter :authenticate_user!, :only => [:destroy, :approve, :edit, :update]
  before_filter :get_quote, :only => [:new, :create, :edit, :update, :destroy, :approve]

  def get_quote
    if params[:quote_id]
      @quote = Quote.find(params[:quote_id])
    elsif params[:id]
      @quote = Quote.find(params[:id])
    else
      @qoute = Quote.new
    end
  end

  def index
    @quotes = Quote.all()
  end

  def new
  end

  def create
    @quote.content = params[:quote][:content]

    if @quote.save
      redirect_to quotes_path, :notice => 'Thanks, quote was added'
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    @quote.delete
  end

  def approve
    @quote.user = current_user
    @quote.approved_at= Time.now
    @quote.save

    redirect_to quotes_path, :notice => 'Quote was approved'
  end

  def random
  end
  
  def search
  end
  
  def browse
  end

end
