class ResultsController < ApplicationController

  def index
  end

  def table
    @results = Result.sections('Sales').items('EQUAL')
    @terms = @results.terms_hash.delete_if { |key, val| !['CMTD', 'CYTD'].include?(key) }
    @classes = @results.classes_hash
    @types = @results.types_hash
  end

end
