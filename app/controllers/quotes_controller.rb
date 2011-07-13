class QuotesController < ApplicationController
  before_filter :authenticate_user!, :only => [:destroy, :approve, :edit, :update]
  before_filter :get_quote, :only => [:new, :create, :edit, :update, :destroy, :approve]

  def get_quote
    if params[:quote_id]
      @quote = Quote.find(params[:quote_id])
    elsif params[:id]
      @quote = Quote.find(params[:id])
    else
      @quote = Quote.new
    end
  end

  def index
    @quotes = Quote.desc(:created_at)
    if !user_signed_in?
      @quotes = @quotes.where( :approved_at.exists => true )
    end
    
    @quotes = @quotes.all.paginate :page => params[:page], :per_page => 2
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
    redirect_to quotes_path, :alert => 'Not yet implemented'
  end

  def update
    redirect_to quotes_path, :alert => 'Not yet implemented'
  end

  def show
  end

  def destroy
    @quote.delete
    redirect_to quotes_path, :alert => 'Quote was deleted'
  end

  def approve
    @quote.user = current_user
    @quote.approved_at= Time.now
    @quote.save

    redirect_to quotes_path, :notice => 'Quote was approved'
  end

  def random
    redirect_to quotes_path, :alert => 'Not yet implemented'
  end
  
  def search
    redirect_to quotes_path, :alert => 'Not yet implemented'
  end
  
  def browse
    redirect_to quotes_path, :alert => 'Not yet implemented'
  end

end
