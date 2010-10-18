class ResultsController < ApplicationController

  def index
    @results = Result.sections('Sales')
    @terms = @results.terms_hash
    @classes = @results.classes_hash
    @types = @results.types_hash
  end

end
